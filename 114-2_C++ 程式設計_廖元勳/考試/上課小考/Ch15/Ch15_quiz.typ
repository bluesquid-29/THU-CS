// ╔══════════════════════════════════════════╗
// ║ 0. 全域設定
// ╚══════════════════════════════════════════╝
#set page(
  paper: "a4",
  margin: 0.5cm,
//   flipped: true
)
#set text(font: ("Noto Serif", "Noto Sans CJK TC"), size: 11pt, lang: "zh")

// Tab 4格 與 程式碼字體大小
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
#place(top + right)[
  #move(dy: 1.5cm)[
    #box(width: 11.5em)[
      #set text(size: 11.5pt)
      #grid(
        columns: (auto, auto),
        column-gutter: 0.6em,
        row-gutter: 0.7em,
        align: left + horizon,

        [*考試日期：*],
        [#underline(offset: 2pt)[#datetime(
          year: 2026,
          month: 5,
          day: 18,
        ).display()]],

      )
    ]
  ]
]

#align(center)[
  #move(dx: 0cm)[
    #text(size: 20pt, weight: "bold", fill: navy)[Ch15小考——運算子的多載 Operator Overloading]\ 
    #text(size: 16pt, weight: "regular")[Problem 1]\ 
  ]
  #v(1em)
  #line(length: 100%, stroke: 1.5pt + navy)
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
  "Problem 1",
  [
    #grid(
      columns: (auto, auto),
      gutter: 1em,
      [
        定義一個 Point（點）的類別擁有 $x$ 及 $y$ 座標資料成員，再透過 Point 類別宣告 `p1(10, 20)`、`p2(15, 23)`、`p3(0, 0)` 三個物件。最後多載 $+$ 一元運算子（前置運算）及 $+$ 二元運算子的功能。運算子功能分別說明如下：

        #grid(
          columns: (auto, auto, auto, auto),
          gutter: 8pt,
          [1. `p3 = p1 + p2`],
          [➡️], 
          [$ (25, 43) = (10, 20) + (15, 23)$], 
          [],

          [2. `p3 = p3 + 6`],
          [➡️], 
          [$ (31, 49) = (25, 43) + (6, 6)$], 
          [\/\/ 表示x, y 座標都加 6],

          [3. `++p3`],
          [➡️], 
          [$ (32, 50) = (25, 43) + (1, 1)$], 
          [\/\/ 表示x, y 座標都加 1],
        )
      ]
    )
    
    *執行結果：*
    #figure(
      image("quiz15-1_(terminal).png", width: 55%),
    )
  ],
  [
    請翻閱 Ch15 PPT 、與此 pdf 下方附錄，來實現以下運算子（可點擊下列）：
    - #link(<EX1>)[Addition `+`] 
    - #link(<EX2>)[Assignment `=`] 
    - #link(<EX3>)[Post-increment `++`] 
  ],
  [

  ],
  [

  ],
  [
    
  ],
  ("quiz15-1.cpp"),
)



#pagebreak()

#v(0.5em)
= 1A. operator 附錄
#v(1em)

多看多背多學習。

#table(
  columns: (0.6fr, 1.5fr, 1.5fr),
  fill: (x, y) => if y == 0 { rgb("#E1F5FE") },
  
  [Operators], 
  table.cell(colspan: 2)[Code example for `object p1, p2`],

  table.cell(rowspan: 4, align: horizon)[Increment/Decrement:\ `++` and `--`],   
  
  // 1.1 前置運算子 pre-increment ✅
  table.cell(colspan: 2, stroke: (bottom: gray))[
    #v(0.5em)
    *前置運算子 pre-<EX3>*:
    ```cpp-n
    Point p1(1, 1);     
    Point old_p1 = ++p1; // old_p1 is (2, 2), and p1 is now (2, 2)

    Point p2(5, 5);     
    Point old_p2 = --p2; // old_p2 is (4, 4), and p2 is now (4, 4)
    ```
  ],
  [
    ```cpp 
    Point& operator++() 
    {
        this->x += 1;
        this->y += 1;
        
        return *this;
    }
    ```
  ],
  table.cell(stroke: (left: gray))[
    ```cpp
    Point& operator--() 
    {
        this->x -= 1;
        this->y -= 1;
        
        return *this;
    }
    ```
  ],


  // 1.2 後置運算子 post-increment ✅
  table.cell(colspan: 2, stroke: (bottom: gray))[
    #v(0.5em)
    *後置運算子 post-*:
    ```cpp-n
    Point p1(1, 1);
    Point old_p1 = p1++; // old_p1 is (1, 1), but p1 is now (2, 2)

    Point p2(5, 5);
    Point old_p2 = p2--; // old_p2 is (5, 5), but p2 is now (4, 4)
    ```
  ],
  [
    ```cpp
    Point operator++(int)
    {
        Point temp = *this;
        
        this->x += 1;
        this->y += 1;
        
        return temp;
    }
    ```
  ],
  table.cell(stroke: (left: gray))[
    ```cpp
    Point operator--(int)
    {
        Point temp = *this;
        this->x -= 1;
        this->y -= 1;
        return temp;
    }
    ```
  ],

  table.cell(rowspan: 2, align: horizon)[Assignment: `=` <EX2>],
  table.cell(colspan: 2, stroke: (bottom: gray))[
    #v(0.5em)
    *賦值運算子 Assignment Operator*:
    ```cpp-n
    Point p1(1, 1);
    Point p2(5, 5);
    Point p3(2, 6);
    p1 = p2 = p3; // Evaluates right-to-left: p2 becomes (2, 6), then p1 becomes (2, 6)
    ```
  ],
  table.cell(colspan: 2)[
    ```cpp
    Point& operator=(Point const& b) 
    {
        this->x = b.x;
        this->y = b.y;
        
        return *this;
    }
    ```
  ],

  table.cell(rowspan: 2, align: horizon)[Addition: `+` <EX1>],
  table.cell(
    colspan: 2, 
    stroke: (bottom: gray)
  )[
    #v(0.5em)
    *加法運算子 Addition Operator*:
    ```cpp-n
    Point p1(1, 1), p2(2, 3);
    Point p3 = p1 + p2; // p3 is (3, 4)
    Point p4 = p1 + 5;  // p4 is (6, 6)
    ```
  ],
 
  [
    ```cpp
    Point operator+(Point const& b) 
    {
        return Point(
            this->x + b.x, 
            this->y + b.y
        );
    }
    ```
  ],
  table.cell(stroke: (left: gray))[
    ```cpp
    Point operator+(int const& b) 
    {
        return Point(
            this->x + b, 
            this->y + b
        );
    }
    ```
  ]
)