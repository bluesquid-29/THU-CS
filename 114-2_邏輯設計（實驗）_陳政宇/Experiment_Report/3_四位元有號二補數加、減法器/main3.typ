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
  numbering: "1.A.",
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
        month: 4,
        day: 24,
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
#align(center)[
  #move(dx: -2.5cm)[  // 調整這個數值（例如 -1cm, -3cm）來控制向左移的程度
    #text(size: 22pt, weight: "bold", fill: navy)[實驗三：四位元有號二補數加/減法器]
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

- 使用一個 *DIP Switch* 控制運算功能（加法或減法）。
- 當執行#highlight(fill: yellow.lighten(25%))[減法]時，使用黃色 LED 亮起作為指示。
- 使用紅色與綠色 LED 分別顯示#highlight(fill: red.lighten(25%))[輸入]數與#highlight(fill: green.lighten(25%))[輸出]數中為 1 的位元。
- 使用紅色 LED 顯示是否發生#highlight(fill: red.lighten(25%))[溢位]。



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
    [7483 (XOR)],
    [2],
    image(components_path + "crop_7486.png", width: 100%),
    [7483 (4 bit adder)],
    [1],
    image(components_path + "crop_7483.png", width: 100%),

    // 第二行
    [220 #sym.Omega],
    [14],
    image(components_path + "220_ohm.png", width: 100%),
    [紅色 LED],
    [8],
    image(components_path + "LED_red.png", width: 100%),

    // 第三行
    [1000 #sym.Omega],
    [9],
    image(components_path + "1000_ohm.png", width: 100%),
    [綠色 LED],
    [4],
    image(components_path + "LED_green.png", width: 100%),

    // 第四行
    //  [], [], [],
    [4 Way DIP Switch ],
    [3],
    image(components_path + "DIP_switch_4.png", width: 100%),
    [黃色 LED],
    [1],
    image(components_path + "LED_yellow.png", width: 100%),

    // 第五行
    [], [], [],
    [藍色 LED],
    [1],
    image(components_path + "LED_blue.png", width: 100%),

    // ... 依此類推，手動把 left_side 和 right_side 的內容填進來
    // 每 6 個一組，Typst 就會自動幫你換行
  ),
)
#pagebreak()



= 原理知識
== 半加法器 Half Adder
半加法器只能計算一位二進制的加法。
#figure(
  image("Half_Adder.png", width: 105%),
//   caption: [],
)


== 全加法器 Full Adder
全加法器可以輸入「上一位數的進位」。
#figure(
  image("Full_Adder.png", width: 105%),
//   caption: [],
)

== 串行進位加法器 Ripple-Carry Adder
如下圖，將四個全加法器的 Cin 和 Cout 首尾相連：

#figure(
  image("Full_Adder-(textbook).png", width: 100%),
//   caption: [],
)

此加法器是從低位到高位一步一步計算的，耗時較長，須經過 *9T* 週期時間。
#pagebreak()

== 並行進位加法器 Carry-Lookahead Adder
此加法器可以在輸入數據的一瞬間，就得到所有位的進位。推導如下：

#move(dx: -0.3cm)[
  #figure(
    image("LookAhead-(formula).png", width: 60%),
  //   caption: [],
)
]
#figure(
  image("LookAhead-(bilibili).png", width: 90%),
//   caption: [],
)
#pagebreak()

== 7483 與 74283
後者是前者的優化與改良，且兩者腳位皆不相同。

#figure(
  image("7483_inside.png", width: 90%),
  caption: [7483 內部邏輯圖],
)
#figure(
  grid(
    columns: (1fr, 1fr),
    column-gutter: 0pt,
    image(components_path + "74LS83.png", width: 100%),
    image(components_path + "74LS283.png", width: 100%),
  ),
//   caption: [],
)
#pagebreak()

== 檢查溢位 Overflow
Overflow = 最高位carry $plus.o$ 次高位carry

對於此實驗要如何檢查，可參考以下證明：
#figure(
  image("overflow-(formula).png", width: 50%),
//   caption: [],
)
// #pagebreak()

== 應用二的補數做加減法
減法本質上就是加上一個數的負數。而我們可以利用「二的補數」來尋找此數的相反數。請參考#link(<result>)[#text(fill: blue)[*5. 實際實驗結果*]]

#figure(
  image("2-complement.png", width: 100%),
//   caption: [],
)
#pagebreak()

= 電路設計
== Circuit Diagram
#figure(
  image("Circuit.png", width: 86%),
//   caption: [],
)

== Crumb Circuit Simulator
#figure(
  image("1_crumb-(full).png", width: 75%),
//   caption: [],
)
#pagebreak()

= 實際實驗結果 <result>
#grid(
  columns: (1fr, 1fr),
  stroke: 0.5pt + black,
  align: center + horizon,

  // 標題 1：使用 inset 撐開高度
  grid.cell(
    colspan: 2,
    fill: rgb("#f0f0f0"),
    inset: 0.5em // 調整這個數值可以控制標題的高矮
  )[*Example 1*],

  // 第一組圖片 (會自動填滿兩欄)
  image("1_real-(full).jpg", width: 95%),
  image("1_real-(full_R).jpg", width: 95%),
  image("1_real-(full_formula).png", width: 95%),
  image("1_real-(full_R_formula).png", width: 95%),

  // 標題 2
  grid.cell(
    colspan: 2,
    fill: rgb("#f0f0f0"),
    inset: 0.5em
  )[*Example 2*],

  // 第二組圖片
  image("2_real-(full).jpg", width: 95%),
  image("2_real-(full_R).jpg", width: 95%),
  image("2_real-(full_formula).png", width: 93%),
  image("2_real-(full_R_formula).png", width: 95%),
)
#pagebreak()



#set par(first-line-indent: 2em, justify: true, leading: 0.5em)
= 心得
== 嘉心
　　這週的實驗是四位元有號二補數加／減法器，難度比上週明顯提升了許多。要完成這個實驗，我們必須先搞清楚半加法器的運作原理，再理解全加法器如何把進位串接起來，同時還要熟練運用二補數的概念來處理負數與減法，每一個環節都環環相扣，缺一不可。

實作過程中，我們犯了一個很關鍵的錯誤——沒有養成接完一部分就立刻測試的習慣，而是把整個電路全部接完才一次測試。結果出錯的時候，要從一大堆線路裡面找出問題所在非常困難，像是邏輯閘的 VCC／GND 接錯位置、開關本身損壞等等，這些問題混在一起根本不知道從哪裡下手。

這次讓我們深刻體會到，實驗應該要分段驗證，每完成一個小模組就測試一次，才能快速定位錯誤，而不是等全部接完才發現問題、又要從頭找起。

== 竣崴

　　為了更方便接電路，我下載了 Crumb Circuit Simulator。這款模擬器能完整重現現實情況、電路模擬功能，使用起來很直觀。

不過要特別注意的是，74283 與 7483 的腳位差異很大。我一開始就犯了嚴重錯誤──把 VCC 與 GND 接反了，而且當下完全沒有察覺。結果花了整整 40 分鐘檢查，過程實在非常煎熬。

另外，寫報告也頗具挑戰。若要有邏輯地說明實驗原理，就必須從頭到尾徹底搞清楚整個流程，不然都是瞎寫。
