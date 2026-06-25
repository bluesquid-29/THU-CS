// ==========================================
// 0. 全域設定 (Page & Text Settings)
// ==========================================
// 0.1 頁面
#set page(
  paper: "a4",
  margin: (top: 0.8cm, bottom: 1.2cm, left: 0.8cm, right: 0.8cm),
  footer: context [
    #set align(center)
    #set text(size: 9pt, fill: gray)
    第 #counter(page).display() 頁 / 共 #counter(page).final().at(0) 頁
  ],
)

// 0.2 字體
#set text(
  font: ("Noto Serif", "Noto Sans CJK TC"),
  size: 12pt,
  lang: "zh",
)

// 0.3 標題
#set heading(
  numbering: "1.A.",
)
#show heading: it => {
  if it.level == 1 {
    v(0.25em) // 第一層上方間距較大
    it
    v(0.25em) // 第一層下方間距
  } else {
    v(0.1em) // 第二層以上間距較小
    it
    v(0.1em)
  }
}

// 0.4 目錄
#show outline.entry: it => {
  v(0.5em)
  it
}

// 0.5 let
#let components_path = "/home/andy/Documents/THU/114-2_邏輯設計（實驗）_陳政宇/Material/Components_PNG/"





// ==========================================
// 1. 報告表頭 (右上角資訊 + 置中標題)
// ==========================================
// 1.1 組別資訊
#place(top + right)[
  #box(width: 11.5em)[
    #set text(size: 11.5pt)
    #grid(
      columns: (auto, auto),
      column-gutter: 0.6em,
      row-gutter: 0.7em,
      align: left + horizon,

      [*日期*],
      [#underline(offset: 2pt)[#datetime(
        year: 2026,
        month: 6,
        day: 12,
      ).display()]],

      [*組員*], [#underline(offset: 2pt)[S14350338 許竣崴]],
      [], [#underline(offset: 2pt)[S14350344 周嘉心]],
      [*組別*], [#underline(offset: 2pt)[資工 1C 第 15 組]],
    )
  ]
]
#v(2.5em)

// 1.2 標題
#align(center)[
  #move(dx: -2.5cm)[
    #text(size: 22pt, weight: "bold", fill: navy)[實驗六：時脈產生器與移位暫存器]
  ]
  #v(0.5em)
  #line(length: 100%, stroke: 1.5pt + navy)
]

// 1.3 自動目錄 + 灰線
#outline(title: [目錄], indent: 1.5em)
#v(1em)
#line(length: 100%, stroke: 1pt + gray)
#v(1em)
#pagebreak()





// ==========================================
// 2. 實驗內容
// ==========================================
= 實驗目標



= 器材
#figure(
  //   caption: [],
  table(
    // 保持你的 6 欄比例
    columns: (0.25fr, 20pt, 125pt, 0.25fr, 20pt, 125pt),
    align: center + horizon,

    // --- 關鍵修正：每一格都畫上灰色細線 ---
    stroke: 0.5pt + gray.lighten(50%),

    // 表頭填色 (保持海軍藍)
    fill: (x, y) => if y == 0 { navy },
    inset: 6pt,

    // --- 表頭 (第一行，共 6 格) ---
    [#text(fill: white)[*名稱*]],
    [#text(fill: white)[*n*]],
    [#text(fill: white)[*圖片*]],
    [#text(fill: white)[*名稱*]],
    [#text(fill: white)[*n*]],
    [#text(fill: white)[*圖片*]],

    // --- 內容 (手動左右配對，每行塞 6 個內容) ---
    // 第一行
    [7486 (XOR)],
    [1],
    image(components_path + "crop_7486.png", width: 110%),
    [7483 (4 bit adder)],
    [1],
    image(components_path + "crop_7483.png", width: 110%),

    // 第二行
    [7404 (NOT)],
    [1],
    image(components_path + "crop_7404.png", width: 110%),
    [7447 (7-segment display decoder)],
    [1],
    image(components_path + "crop_7447.png", width: 110%),

    // 第三行
    [74157 (Quad 2-to-1 MUX)], [1], image(components_path + "crop_74157.png", width: 110%), [], [], [],

    // 第四行
    [220 #sym.Omega],
    [12],
    image(components_path + "220_ohm.png", width: 85%),
    [1000 #sym.Omega],
    [5],
    image(components_path + "1000_ohm.png", width: 85%),

    // 第五行
    [紅色 LED],
    [4],
    image(components_path + "LED_red.png", width: 85%),
    [綠色 LED],
    [4],
    image(components_path + "LED_green.png", width: 85%),

    // 第六行
    [藍色 LED],
    [1],
    image(components_path + "LED_blue.png", width: 85%),
    [黃色 LED],
    [1],
    image(components_path + "LED_yellow.png", width: 85%),

    // 第七行
    [7-Segment Display (common anode)],
    [2],
    image(components_path + "7_segment_display.png", width: 75%),
    [4 Way DIP Switch ],
    [2],
    image(components_path + "DIP_switch_4.png", width: 60%),

    // ... 依此類推，手動把 left_side 和 right_side 的內容填進來
    // 每 6 個一組，Typst 就會自動幫你換行
  ),
)
#pagebreak()



#table(
  columns: (0.25fr, 20pt, 125pt, 0.25fr, 20pt, 125pt),
  align: center + horizon,
  
)