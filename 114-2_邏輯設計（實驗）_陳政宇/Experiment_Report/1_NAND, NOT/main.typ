// ==========================================
// 1. 全域設定 (Page & Text Settings)
// ==========================================
#set page(
  paper: "a4",
//   margin: (x: 0.8cm, y: 0.8cm),
  margin: (top: 0.8cm, bottom: 1.6cm, left: 0.8cm, right: 0.8cm),
  footer: context [
    #set align(center)
    #set text(size: 9pt, fill: gray)
    第 #counter(page).display() 頁 / 共 #counter(page).final().at(0) 頁
  ]
)

#set text(font: ("Noto Serif", "Noto Sans CJK TC"), size: 11pt, lang: "zh")

#set heading(numbering: "1.")
#show heading: it => {
  if it.level == 1 {
    v(0.1em) // 第一層標題上方留大一點
    it
    v(0.1em)   // 第一層標題下方
  } else {
    v(0.1em) // 第二層（或以上）維持原狀
    it
    v(0.1em)
  }
}

// 修正後的目錄間距 (建議 0.5em)
#show outline.entry: it => {
  v(0.5em)
  it
}

#set figure(supplement: [圖])

// ==========================================
// 2. 報告表頭 (右上角資訊 + 置中標題)
// ==========================================

#place(top + right)[
  #box(width: 10em)[
    #set text(size: 9pt)
    #grid(
      columns: (auto, 1fr),
      column-gutter: 0.6em,
      row-gutter: 0.5em,
      // 關鍵在這裡：強制所有內容靠左 (left) 且垂直居中 (horizon)
      align: left + horizon,

      [*日期*], [#underline(offset: 2pt)[#datetime(year: 2026, month: 3, day: 13).display()]],
      [*組員 1*], [#underline(offset: 2pt)[S14350338 許竣崴]],
      [*組員 2*], [#underline(offset: 2pt)[S14350344 周嘉心]],
      [*組別*], [#underline(offset: 2pt)[資工 1C 第 15 組]],
    )
  ]
]

// 2. 留出足夠的頂部空間給右上角的資訊
#v(2em)

// 3. 標題置中
#align(center)[
  #text(size: 22pt, weight: "bold", fill: navy)[邏輯設計實驗：第一次報告]
  #v(-0.5em)
  #line(length: 100%, stroke: 1.5pt + navy)
]

// #v(1em)
// #line(length: 100%, stroke: 0.5pt + gray)
// #v(1em)

// ==========================================
// 3. 自動目錄
// ==========================================
// #outline(title: [實驗大綱], indent: 1.5em)
//
// #v(1em)
// #line(length: 100%, stroke: 0.5pt + gray) // 修正了 0.5pt
// #v(1em)

// ==========================================
// 4. 實驗內容
// ==========================================

= 實驗一：7404 NOT gate (green, red LED)

#let circuit_1 = image("7404-on_circuit.png", width: 100%, height: 100%, fit: "contain")
#let input_1 = image("7404-on_input.png", width: 100%, height: 100%, fit: "contain")
#let output_1 = image("7404-on_output.png", width: 100%, height: 100%, fit: "contain")
#let circuit_11 = image("7404-off_circuit.png", width: 100%, height: 100%, fit: "contain")
#let input_11 = image("7404-off_input.png", width: 100%, height: 100%, fit: "contain")
#let output_11 = image("7404-off_output.png", width: 100%, height: 100%, fit: "contain")

#table(
  columns: (1fr, 1fr, 1fr),      // Defined widths prevent jumping
  rows: (25pt, 120pt, 120pt), // Matches your data rows
  stroke: 0.5pt + gray,
  align: center + horizon,
  fill: (x, y) => if y == 0 { gray.lighten(80%) },
  inset: 5pt, // Reduced inset to give the image more breathing room

  // --- Header ---
  [*電路圖*], [*Input*], [*Output*],

  // --- Data Rows ---
  circuit_1, input_1, output_1,
  circuit_11, input_11, output_11,
)


// #v(1em)
// #line(length: 100%, stroke: 0.5pt + gray)
// #v(1em)

= 實驗二：7404 NOT gate (bulb and green LED)
// == 實驗截圖
#figure(
  image("7404-bulb.jpg", width: 85%),
//   caption: [加法器電路連接圖],
) <fig-q2>

= 實驗三：7400 NAND gate (2 green, 1 red LED)

#let zero_zero = image("nand_0-0.png", width: 100%, height: 100%, fit: "contain")
#let zero_one = image("nand_0-1.png", width: 100%, height: 100%, fit: "contain")
#let one_zero = image("nand_1-0.png", width: 100%, height: 100%, fit: "contain")
#let one_one = image("nand_1-1.png", width: 100%, height: 100%, fit: "contain")


#table(
  columns: (40pt, 40pt, 80pt, 3fr, 1fr),      // Defined widths prevent jumping
  rows: (25pt, 120pt, 120pt, 120pt, 120pt), // Matches your data rows
  stroke: 0.5pt + gray,
  align: center + horizon,
  fill: (x, y) => if y == 0 { gray.lighten(80%) },
  inset: 5pt, // Reduced inset to give the image more breathing room

  // --- Header ---
  [*A*], [*B*], [*A NAND B*], [*模擬圖*], [*說明*],

  // --- Data Rows ---
  [0], [0], [1], zero_zero, [],
  [0], [1], [1], zero_one, [],
  [1], [0], [1], one_zero, [],
  [1], [1], [0], one_one, [],
)

= 實驗四：7400 NAND gate (2 green LED)

- 實驗內容為把紅燈拔起來。
- 忘記拍照

// #pagebreak()
= 實驗總結與心得

// 在此處輸入你的實驗心得。

// #v(10em)
//
// #align(right)[
//   #text(size: 9pt, fill: red.darken(20%))[*注意：報告抄襲者雙方 0 分*]
// ]

