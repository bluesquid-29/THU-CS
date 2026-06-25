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
  #text(size: 22pt, weight: "bold")[26/04/27 Ch12作業——類別 class ] \
  #text(size: 16pt, weight: "regular")[課後習題 12-8, 12-9]
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
  [== 實際畫面]
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
  "P1 計算函數",
  [
    #figure(
      image("4-27_Q12-8.jpg", width: 80%),
    )
  ],
  [

  ],
  [
    #figure(
      image("作業上傳Q12-8.png", width: 80%),
    )
  ],
  "Q12_8.cpp",
//   references: (
//     "https://zerojudge.tw/ShowProblem?problemid=d190",
//     "https://vjudge.net/problem/UVA-11462"
//   )
)

#exam_item(
  "P2 計算長方形",
  [
    #figure(
      image("4-27_Q12-9.jpg", width: 80%),
    )
  ],
  [

  ],
  [
    #figure(
      image("作業上傳Q12-9.png", width: 70%),
    )
  ],
  "Q12_9.cpp",
//   references: (
//     "https://zerojudge.tw/ShowProblem?problemid=d190",
//     "https://vjudge.net/problem/UVA-11462"
//   )
)
