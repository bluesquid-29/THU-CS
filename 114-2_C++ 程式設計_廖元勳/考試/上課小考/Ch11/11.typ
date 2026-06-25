#set page(
  paper: "a4",
  margin: 0.5cm,
//   flipped: true // 橫向排版
)
#set text(font: ("Noto Serif", "Noto Sans CJK TC"), size: 11pt, lang: "zh")

// 全域設定：Tab 4格 與 程式碼字體大小
#set raw(tab-size: 4)
#show raw: set text(size: 10pt)

#show raw.where(block: false): it => {
  box(
    fill: luma(240),      // 淺灰色底色 (0-255)
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,         // 圓角
    text(fill: rgb("#000000"), it) // 文字改為紅色（如 Markdown 常見配色）
  )
}

// 藍色題解框樣式
#let example_box(it) = block(
  fill: rgb("#eef6ff"),
  stroke: (left: 4pt + rgb("#2563eb")),
  inset: (x: 12pt, y: 10pt),
  width: 100%,
  radius: 2pt,
  it
)

// 目錄樣式
#show outline.entry: it => {
  v(0.5em)
  it
}

// 標題區
#align(center)[
  #text(size: 22pt, weight: "bold")[26/04/27 Ch11小考——結構與資料型態 ] \
  #text(size: 16pt, weight: "regular")[Problem 1, 2]
]

#v(1em)
#outline(title: [題目目錄], indent: 2em)
#v(2em)

// 核心函數定義
#let exam_item(title, desc, analysis, examples, code_file, references: ()) = {
  pagebreak(weak: true)
  heading(level: 1, title)

  // 如果 references 數組不為空，則渲染連結列表
  if references.len() > 0 {
    v(0.2em)
    block(inset: (left: 0.8em), {
      for ref in references {
        set text(size: 0.8em, fill: rgb("#2563eb"))
        // 直接用 Unicode 鏈結符號，或者用更穩定的 arrow.r
        [🔗 #link(ref) \ ]
      }
    })
  }
  v(0.8em)

  [== 題目敘述]
  desc

  v(1.5em)
  [== 題解說明]
  analysis

  v(1em)
  // 假設你原本定義的例子方塊是 example_box
  example_box(examples)

  v(1.5em)
  [== 完整程式碼]

  // 行號與程式碼渲染邏輯 (維持不變)
  show raw.where(block: true): it => {
    block(
      fill: rgb("#f8f9fa"),
      inset: 5pt,
      radius: 4pt,
      stroke: 0.5pt + luma(200),
      width: 100%,
      {
        set text(size: 0.9em)
        let lines = it.lines
        grid(
          columns: (2.5em, 1fr),
          column-gutter: 0.8em,
          row-gutter: 0.5em,
          ..lines.enumerate().map(((i, line)) => (
            align(right,
              text(fill: gray.darken(20%), size: 0.9em, font: "DejaVu Sans Mono")[#(i + 1)]
            ),
            line
          )).flatten()
        )
      }
    )
  }

  raw(read(code_file), lang: "cpp", block: true)
}

// ##############################
// 實際內容填寫區
// ##############################
#exam_item(
  "P1 個人基本資訊",
  [
    建立 person 巢狀結構，person結構中擁有身份證號碼、姓名、薪水三個成員集集生日結構，生日結構包含年、月、日。並且任意賦予初值。最後輸出成一個字串，如下圖所示。
    #figure(
      image("11_1-(problem).png", width: 100%),
    )
  ],
  [
    選擇在 `Person` 內部定義 `Birthday` 結構並直接宣告變數。這種寫法的優點是*封裝性強*，將僅屬於人員的日期格式限制在 `Person` 的作用域內，存取時透過 `A.birth.year` 層層進入，邏輯十分明確。
  ],
  [
    *範例追蹤*： \
    1. *資料存取*：透過 `A.birth.year` 存取內層成員。
    2. *記憶體佈局*：`Person` 變數在記憶體中會包含 `ID`、`name`、`salary` 以及一個完整的 `Birthday` 區塊。
    3. *輸出格式*：整合各階層成員，輸出如：
    #figure(
      image("11_1-(terminal).png", width: 100%),
    )
  ],
  "11_1.cpp",
//   references: (
//     "https://zerojudge.tw/ShowProblem?problemid=d190",
//     "https://vjudge.net/problem/UVA-11462"
//   )
)

#exam_item(
  "P2 struct 陣列應用",
  [
    將 structarray 的結構陣列範例再加入排序功能，使用者可以選擇進行由小到大排序、或由大到小排序，或進行搜尋功能。

    #figure(
      image("11_2-(problem).png", width: 50%),
    )
  ],
  [
    使用 `std::vector<CD>` 儲存資料，並利用 `<algorithm>` 標頭檔中的 `std::sort`、`std::min_element` 與 `std::max_element` 搭配自定義的比較邏輯（Lambda）來實現排序與搜尋。
  ],
  [
    *範例*： \
    輸入 3 筆 CD 資料： \
    1. `a01`, `台語`, `360` \
    2. `a02`, `華語`, `350`
    3. `a03`, `日語`, `340` \

    #line(length: 100%, stroke: 1pt + gray)

    1. *搜尋編號*：若輸入 `a02`，遍歷陣列比對 `ID` 欄位，輸出「華語」。
    2. *由小到大排序*：依據 `cost` 排序，結果為 `[a03: 340, a02: 350, a01: 360]`。
    3. *極值查詢*：
       - 最小單價：透過 `min_element` 找到 $340$。
       - 最大單價：透過 `max_element` 找到 $360$。

    #figure(
      image("11_2-(terminal).png", width: 100%),
    )
  ],
  "11_2.cpp",
//   references: (
//     "https://zerojudge.tw/ShowProblem?problemid=d190",
//     "https://vjudge.net/problem/UVA-11462"
//   )
)

