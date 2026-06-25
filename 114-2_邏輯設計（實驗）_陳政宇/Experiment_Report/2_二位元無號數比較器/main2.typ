// ==========================================
// 0. 全域設定 (Page & Text Settings)
// ==========================================
// 0.1 頁面
#set page(
  paper: "a4",
  margin: (top: 0.8cm, bottom: 1.6cm, left: 0.8cm, right: 0.8cm),
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
  numbering: "1.",
)
#show heading: it => {
  if it.level == 1 {
    v(0.5em) // 第一層上方間距較大
    it
    v(0.5em) // 第一層下方間距
  } else {
    v(0.25em) // 第二層以上間距較小
    it
    v(0.25em)
  }
}



// 0.4 目錄
#show outline.entry: it => {
  v(0.5em)
  it
}



// 0.5 只要是figure 就會有名字1，名字2, ...
// Example #set figure(supplement: [XXX])
// 0.51 當 figure 裡面是圖片時，顯示「圖 X」
#show figure.where(kind: image): set figure(supplement: [圖])

// 0.52 當 figure 裡面是表格時，顯示「表 X」
#show figure.where(kind: table): set figure(supplement: [表])



// 0.6 在文件開頭定義絕對路徑
#let components_path = "/home/andy/Downloads/Logic Design/Components_PNG/"






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
        month: 3,
        day: 13,
      ).display()]],

      [*組員*], [#underline(offset: 2pt)[S14350338 許竣崴]],
      [], [#underline(offset: 2pt)[S14350344 周嘉心]],
      [*組別*], [#underline(offset: 2pt)[資工 1C 第 15 組]],
    )
  ]
]

// 1.11 留出足夠的頂部空間給右上角的資訊
#v(2.5em)



// 1.2 標題
#move(dx: 0cm)[  // 調整這個數值（例如 -1cm, -3cm）來控制向左移的程度
  #align(center)[
    #text(size: 22pt, weight: "bold", fill: navy)[實驗二：2位元無號數比較器]
    #v(-0.5em)
    #line(length: 100%, stroke: 1.5pt + navy)
  ]
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
= 器材
#figure(
  caption: [],
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
    [7404 (NOT)],
    [1],
    image(components_path + "crop_7404.png", width: 100%),
    [7408 (AND)],
    [2],
    image(components_path + "crop_7408.png", width: 100%),

    // 第二行
    [7432 (OR)],
    [2],
    image(components_path + "crop_7432.png", width: 100%),
    [7411 (AND)],
    [2],
    image(components_path + "crop_7411.png", width: 100%),

    // 第三行
    [220 #sym.Omega],
    [6],
    image(components_path + "220_ohm.png", width: 100%),
    [紅色 LED],
    [1],
    image(components_path + "LED_red.png", width: 100%),

    // 第四行
    [1000 #sym.Omega],
    [4],
    image(components_path + "1000_ohm.png", width: 100%),
    [綠色 LED],
    [1],
    image(components_path + "LED_green.png", width: 100%),

    // 第四行
    //  [], [], [],
    [4 Way DIP Switch ],
    [1],
    image(components_path + "DIP_switch_4.png", width: 100%),
    [黃色 LED],
    [4],
    image(components_path + "LED_yellow.png", width: 100%),

    // ... 依此類推，手動把 left_side 和 right_side 的內容填進來
    // 每 6 個一組，Typst 就會自動幫你換行
  ),
)
#pagebreak()



= 設計圖
== 化簡布林函數
#figure(
  image("函數化簡.png", width: 100%),
  caption: [],
)

#figure(
  image("LOGIC_diagram.png", width: 100%),
  caption: [],
)

#pagebreak()

== Circuit Diagram
#figure(
  image("CIRCUIT_diagram.png", width: 100%),
  caption: [],
)

#pagebreak()

== Tinkercad Simulator
#figure(
  image("FULL_circuit.png", width: 97.5%),
  caption: [],
)

== Actual Breadboard Build
#figure(
  image("ACTUALL_circuit.jpg", width: 50%),
  caption: [],
)

#pagebreak()



= 實驗結果
== 真值表
#figure(
  image("true_table.png", width: 60%),
  caption: [],
)

== 解釋
#align(center)[
  #table(
    columns: (1fr, 1fr, 1.2fr),
    stroke: 0.5pt + gray,
    fill: (x, y) => if y == 0 { gray.lighten(80%) },
    inset: 7pt,
    [*比較條件*], [*輸出狀態*], [*LED 顯示*],
    [$A < B$], [$F_1=1, F_2=0$], [紅燈],
    [$A > B$], [$F_1=0, F_2=1$], [綠燈],
    [$A = B$], [$F_1=0, F_2=0$], [不亮燈],
  )
]

#pagebreak()

== 圖片
#figure(
  grid(
    // 1. 定義 4 欄，每欄平分寬度
    columns: (1fr, 1fr, 1fr, 1fr),

    // 2. 設定間隙 (Gutter)，讓圖片之間有點呼吸空間，不要黏死
    column-gutter: 0pt,
    row-gutter: 28pt,

    // 3. 畫上淡淡的灰色邊框 (可選，如果要像表格一樣整齊就加上去)
    stroke: 0.5pt + gray.lighten(70%),

    // 4. 對齊方式
    align: center + horizon,

    // 5. 自動填入 16 張圖片 (假設你的路徑存在 all_results 陣列中)
    ..range(1, 17)
      .map(i => (
        box(inset: 2pt)[
          #image("實驗拍照/" + str(i) + ".jpg", width: 100%)

          //       #v(-2pt)
          //       #text(size: 8pt, fill: gray)[Case #i]
        ]
      ))
      .flatten()
  ),
  caption: [],
)
#pagebreak()



= 心得
#set text(size: 14pt, weight: "regular")
#set par(first-line-indent: 2em, justify: true, leading: 0.5em)
#h(1em)

這次實驗一開始看到真值表，我們其實不太清楚它的用途是什麼，只是照著格式把輸入輸出填上去。後來慢慢理解，才發現原來概念很簡單——就是比較兩個數字的大小，A 比較大亮綠燈，B 比較大亮紅燈，一目瞭然。

整個實驗過程中，我們覺得最有挑戰性的部分是化簡邏輯閘。要從真值表推導出布林式，再想辦法用最少的邏輯閘實現，我們花了不少時間討論和思考。

在 Tinkercad 上模擬的時候，我們把線路排得整齊又美觀，感覺一切都在掌控之中。沒想到換成實際麵包板操作，線路完全不聽話，東彎西繞，我們的手也沒有想像中靈巧，跟模擬圖差了十萬八千里。

第一次把所有線路接完、通電測試，結果是錯的。那一刻我們真的很懊惱，只能從頭一條一條檢查哪裡接錯。雖然過程辛苦，但最後排除錯誤、看到正確結果的時候，我們還是覺得很有成就感。這次實驗讓我們體會到，理論和實作之間的差距，往往比想像的還要大。
