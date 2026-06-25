// ╔══════════════════════════════════════════╗
// ║ 0. 全域設定
// ╚══════════════════════════════════════════╝
#set page(
  paper: "a4",
  margin: 0.5cm,
//   flipped: true
)
#set text(font: ("Noto Serif", "Noto Sans CJK TC"), size: 11pt, lang: "zh")
// #set enum(numbering: "a.")
#set raw(tab-size: 4)
#show raw: set text(size: 10pt)

#show raw.where(block: false): it => {
  box(
    fill: luma(245),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,         // 圓角
    text(fill: rgb("#000000"), it)
  )
}

// 預設題解框樣式
#let example_box(type: "blue", it) = {
  let color = if type == "green" { rgb("#10b981") }
         else if type == "red"   { rgb("#ef4444") }
         else if type == "gold"  { rgb("#f59e0b") }
         else if type == "lightgray"  { rgb("#dfe2e5") }
         else { rgb("#2563eb") } // 預設藍色

  block(
    fill: color.lighten(92%),
    stroke: (left: 4pt + color),
    inset: (x: 12pt, y: 10pt),
    width: 100%,
    radius: 2pt,
    it
  )
}


// 行號與程式碼渲染邏輯 (維持不變)
#show raw.where(block: true): it => {
  let is-numbered = it.lang != none and it.lang.ends-with("-n")
  let clean-lang = if is-numbered { it.lang.slice(0, -2) } else { it.lang }

  block(
    // fill: rgb("#f8f9fa"),
    fill: luma(245),
    inset: 12pt,
    radius: 4pt,
    stroke: 0.5pt + luma(200),
    width: 100%,
    {
      set text(size: 0.85em, font: "DejaVu Sans Mono")
      
      // 【核心關鍵 1】：不論有沒有行號，強制拔除內部所有單行 raw 的預設灰色背景
      // show raw.where(block: false): set text(background: none)
      
      // 提取行資料（嚴格遵守屬性存取規範）
      let lines = it.lines 
      
      if is-numbered {
        grid(
          columns: (1.0em, 1fr),
          column-gutter: 0.8em,
          row-gutter: 0.6em,
          ..lines.enumerate().map(((i, line)) => (
            align(right, text(fill: gray.darken(20%), size: 1em, font: "DejaVu Sans Mono")[#(i + 1)]),
            // 使用 block: false 阻斷無限遞迴
            raw(line.text, lang: clean-lang, block: false)
          )).flatten()
        )
      } else {
        // 【核心關鍵 2】：沒行號時，同樣使用 block: false 逐行輸出，徹底阻斷遞迴崩潰！
        // 用單一欄位的 grid 排版，並微調行距，視覺效果與原生完全一致
        grid(
          columns: (1fr,),
          row-gutter: 0.6em,
          ..lines.map(line => raw(line.text, lang: clean-lang, block: false))
        )
      }
    }
  )
}

// 目錄樣式
#show outline.entry: it => {
  v(0.5em)
  it
}

// 標題區
// #align(center)[
//   #text(size: 22pt, weight: "bold")[26/05/18 Ch15小考——運算子的多載 operator overloading] \
//   #text(size: 16pt, weight: "regular")[Problem 1]
// ]
// 
#align(center)[
  #move(dx: 0cm)[
    #text(size: 20pt, weight: "bold", fill: navy)[Ch16作業——類別的繼承 Class Inheritance]\ 
    #text(size: 16pt, weight: "regular")[Problem 3, 4, 15]\ 
  ]
  #v(1em)
  #line(length: 100%, stroke: 1.5pt + navy)
]

#place(top + right)[
  #move(dy: 1.5cm)[
    #box(width: 11.5em)[
      #set text(size: 11.5pt)
      #grid(
        columns: (auto, auto),
        column-gutter: 0.6em,
        row-gutter: 0.7em,
        align: left + horizon,

        [*撰寫日期：*],
        [#underline(offset: 2pt)[#datetime(
          year: 2026,
          month: 5,
          day: 24,
        ).display()]],

      )
    ]
  ]
]

#v(1em)
#outline(title: [目錄], indent: 2em)
#v(2em)



// ╔══════════════════════════════════════════╗
// ║ 01. 核心函數定義
// ╚══════════════════════════════════════════╝
#let exam_item(title, describe, analysis, examples, code_description, extra, code_file, references: ()) = {
  pagebreak(weak: true)
  heading(level: 1, title)

  if references.len() > 0 {
    v(0.2em)
    block(inset: (left: 0.8em), {
      for ref in references {
        set text(size: 0.8em, fill: rgb("#2563eb"))
        [🔗 #link(ref) \ ]
      }
    })
  }
  v(0.8em)

  [#text(fill: navy)[== 題目敘述]]
  describe

  v(1.5em)
  [#text(fill: navy)[== 題解說明]]
  analysis
  v(1em)
  // example_box(examples)


  v(1.5em)
  [#text(fill: navy)[== 完整程式碼]]
  extra

  // 判斷 code_file 的類型
  if type(code_file) == str {
    // 情況 A: 單一檔案讀取
    raw(read(code_file), lang: "cpp-n", block: true)
  } else if type(code_file) == array {
    // 情況 B: 複數檔案並排 (符合規範第 5 點 Grid 思路)
    grid(
      columns: (1fr, 1fr),
      column-gutter: 4pt,
      ..code_file.map(f => {
        stack(
          dir: ttb,
          spacing: 0.5em,
          text(size: 0.8em, fill: gray, weight: "bold")[#f], // 顯示檔名
          raw(read(f), lang: "cpp-n", block: true)
        )
      })
    )
  }
}


// ╔══════════════════════════════════════════╗
// ║ 02. 實際內容填寫區
// ╚══════════════════════════════════════════╝
// 02.1 Heading 1
#exam_item(
  "Problem 3, 4",
  [
    #grid(
      columns: (5fr, 3fr), // Two equal columns
      gutter: 1em,         // Space between the tables
      [
        #figure(
          image("16-3, 4 (hw_problem).jpg", width: 100%),
        )    
      
      ],
      [
        *執行結果：*
        #figure(
          image("16-3, 4 (hw_terminal).png", width: 100%),
        )
      ]
    )
  ],
  [
    逐步完成下列的程式設計：
    === 3a, b, c
    #example_box(type: "gold")[
      + 試設計一父類別 Animal ，內含有私有資料成員 `std::string` name（名稱）與 `int` age（年齡）。
      + 在 Animal 類別裡加入令一個有引數的建構子 `Animal(string n, int a)`，它可以用來把 name 設值為 n，把 age 設值為 a 。name 的預設值為 animal，age 的預設值為 0 。 
      + 在 Animal 類別裡加入 showInfo() 函數，用來顯示 name 與 age 的值。
    ]

    ```cpp-n
    class Animal 
    {
      private:
        string name;
        int age;

      public:
        Animal(string n = "animal", int a = 0) : name(n), age(a) {}

        void showInfo()
        {
            cout << name << ", age: " << age << endl;
        }
    };
    ```

    === 3d
    #example_box(type: "gold")[
      - 設計一子類別 Dog ，繼承自 Animal 類別，Dog() 建構子的預設值 name 為 "puppy"，age 為 0。
    ]

    ```cpp-n
    class Dog : public Animal 
    {
      public:
        Dog(string n = "puppy", int a = 0) : Animal(n, a) {}
    };
    ```

    === 4
    #example_box(type: "gold")[
      - 接續上題，設計一子類別 Cat ，繼承自 Animal 類別，Cat() 建構子的預設值 name 為 "kitty"，age 為 0。
    ]

    ```cpp-n
    class Cat : public Animal 
    {
      public:
        Cat(string n = "kitty", int a = 0) : Animal(n, a) {}
    };
    ```
  ],
  [
    
  ],
  [
    
  ],
  [
    
  ],
  ("16-3, 4 (hw).cpp"),
)



#exam_item(
  "Problem 15",
  [
    #grid(
      columns: (5fr, 3fr), // Two equal columns
      gutter: 1em,         // Space between the tables
      [
        #figure(
          image("16-15 (hw_problem).jpg", width: 100%),
        )    
      
      ],
      [
        *執行結果：*
        #figure(
          image("16-15 (hw_terminal).png", width: 100%),
        )
      ]
    )
  ],
  [
    #example_box(type: "red")[
      display() 函數多此一舉，因此不使用。
    ]

    新增下列函數即可。
    ```cpp-n
    // class Animal
    void makeSound()
    {
        cout << "Animal sound" << endl;
    }
    ```

     ```cpp-n
    // class Dog
    void makeSound()
    {
        cout << "Woof!" << endl;
    }
    ```

     ```cpp-n
    // class Cat
    void makeSound()
    {
        cout << "Meow!" << endl;
    }
    ```
  ],
  [
    
  ],
  [
    
  ],
  [
    
  ],
  ("16-15 (hw).cpp"),
)
