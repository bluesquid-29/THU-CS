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
        day: 30,
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
    #text(size: 22pt, weight: "bold", fill: navy)[實驗四：四位元二補數轉十進位顯示解碼器]
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

- 使用 4-bit DIP switch 輸入一個 4 位元二補數，且使用紅色 LED 顯示#highlight(fill: red.lighten(25%))[輸入]中為 1 的位元。使用「有號二補數加減法器」的概念（處理正負數）。
- 將輸入的二進位數轉換為 BCD 並加入一個符號位元。使用綠色 LED 顯示 #highlight(fill: green.lighten(25%))[BCD] 中為 1 的位元，並用黃色 LED 表示輸入為#highlight(fill: yellow.lighten(25%))[負數]。
- 使用七段顯示器顯示該二進位數的十進位值。若輸入為#highlight(fill: yellow.lighten(25%))[負數]，另一個七段顯示器顯示負號。

// - 使用一個 *DIP Switch* 控制運算功能（加法或減法）。
// - 當執行#highlight(fill: yellow.lighten(25%))[減法]時，使用黃色 LED 亮起作為指示。
// - 使用紅色與綠色 LED 分別顯示#highlight(fill: red.lighten(25%))[輸入]數與#highlight(fill: green.lighten(25%))[輸出]數中為 1 的位元。
// - 使用紅色 LED 顯示是否發生#highlight(fill: red.lighten(25%))[溢位]。



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
    image(components_path + "crop_7486.png", width: 110%),
    [7483 (4 bit adder)],
    [1],
    image(components_path + "crop_7483.png", width: 110%),

    // 第二行
    [7404 (NOT)],
    [1],
    image(components_path + "crop_7404.png", width: 110%),
    [7447 (Seven Segment Display Decoder)],
    [1],
    image(components_path + "crop_7447.png", width: 110%),

    // 第三行
    [220 #sym.Omega],
    [14],
    image(components_path + "220_ohm.png", width: 100%),
    [1000 #sym.Omega],
    [9],
    image(components_path + "1000_ohm.png", width: 100%),

    // 第四行
    [紅色 LED],
    [8],
    image(components_path + "LED_red.png", width: 100%),
    [綠色 LED],
    [4],
    image(components_path + "LED_green.png", width: 100%),

    // 第五行
    //  [], [], [],
    [藍色 LED],
    [1],
    image(components_path + "LED_blue.png", width: 100%),
    [黃色 LED],
    [1],
    image(components_path + "LED_yellow.png", width: 100%),

    // 第六行
    [7 Segment Display (common anode)],
    [2],
    image(components_path + "7_segment_display.png", width: 80%),
    [4 Way DIP Switch ],
    [3],
    image(components_path + "DIP_switch_4.png", width: 100%),

    // ... 依此類推，手動把 left_side 和 right_side 的內容填進來
    // 每 6 個一組，Typst 就會自動幫你換行
  ),
)
#pagebreak()



= 原理知識
== 四位元有號二補數轉負號與BCD
#figure(
  image("explain_LED.png", width: 80%),
//   caption: [],
)
#figure(
  image("explain_table.png", width: 90%),
//   caption: [],
)

== 檢測七段顯示器
#figure(
  image("七段顯示器.jpg", width: 45%),
//   caption: [],
)
#pagebreak()


// == 全加法器 Full Adder
// 全加法器可以輸入「上一位數的進位」。
// #figure(
//   image("Full_Adder.png", width: 105%),
// //   caption: [],
// )
//
// == 串行進位加法器 Ripple-Carry Adder
// 如下圖，將四個全加法器的 Cin 和 Cout 首尾相連：
//
// #figure(
//   image("Full_Adder-(textbook).png", width: 100%),
// //   caption: [],
// )
//
// 此加法器是從低位到高位一步一步計算的，耗時較長，須經過 *9T* 週期時間。
// #pagebreak()
//
// == 並行進位加法器 Carry-Lookahead Adder
// 此加法器可以在輸入數據的一瞬間，就得到所有位的進位。推導如下：
//
// #move(dx: -0.3cm)[
//   #figure(
//     image("LookAhead-(formula).png", width: 60%),
//   //   caption: [],
// )
// ]
// #figure(
//   image("LookAhead-(bilibili).png", width: 90%),
// //   caption: [],
// )
// #pagebreak()
//
// == 7483 與 74283
// 後者是前者的優化與改良，且兩者腳位皆不相同。
//
// #figure(
//   image("7483_inside.png", width: 90%),
//   caption: [7483 內部邏輯圖],
// )
// #figure(
//   grid(
//     columns: (1fr, 1fr),
//     column-gutter: 0pt,
//     image(components_path + "74LS83.png", width: 100%),
//     image(components_path + "74LS283.png", width: 100%),
//   ),
// //   caption: [],
// )
// #pagebreak()
//
// == 檢查溢位 Overflow
// Overflow = 最高位carry $plus.o$ 次高位carry
//
// 對於此實驗要如何檢查，可參考以下證明：
// #figure(
//   image("overflow-(formula).png", width: 50%),
// //   caption: [],
// )
// // #pagebreak()
//
// == 應用二的補數做加減法
// 減法本質上就是加上一個數的負數。而我們可以利用「二的補數」來尋找此數的相反數。請參考#link(<result>)[#text(fill: blue)[*5. 實際實驗結果*]]
//
// #figure(
//   image("2-complement.png", width: 100%),
// //   caption: [],
// )
// #pagebreak()

= 電路設計
== 實驗三 Circuit Diagram
#figure(
  image("Circuit.png", width: 85%),
//   caption: [],
)

== 實驗四延伸
#figure(
  image("circuit_addition.png", width: 78%),
//   caption: [],
)
#pagebreak()

= 實際實驗結果 <result>
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
    ..range(0, 16)
      .map(i => (
        box(inset: 2pt)[
          #image("實驗拍照/" + str(i) + ".jpg", width: 102%)

          //       #v(-2pt)
          //       #text(size: 8pt, fill: gray)[Case #i]
        ]
      ))
      .flatten()
  ),
//   caption: [],
)
#pagebreak()



#set par(first-line-indent: 2em, justify: true, leading: 0.5em)
= 心得
== 嘉心
　　這週的實驗四對我們來說整體難度不高。一開始要先確認七段顯示器是共陽極還是共陰極，確認之後照著接法連接，只要細心就不容易出錯。

真正困難的地方不在接線，而是在設計思路上。我們一開始直覺地想對 input 的符號位元接 NOT gate 來處理正負號，看似合理，但實際測試的時候，數字 -8 怎麼樣都做不出來，卡了很久。後來聽取助教的建議，改成對正負號本身接 NOT gate，才終於成功實現正確的輸出。

這次讓我們體會到，邏輯電路的設計不能只靠直覺，有時候換一個切入角度，問題就迎刃而解了。

== 竣崴
　　實驗四第一週對我們來說並不順利，主要原因是當時還不理解「四位元二補數」與「有號位元、BCD 碼」之間的關係。每個步驟幾乎都要問過助教才能繼續往下做，整體進度走得相當緩慢。

不過在下一次上課前，我花時間撰寫實驗結報、重新梳理實作觀念，才發現其實整個實驗的邏輯並不複雜，只是一開始概念沒有建立好，才會覺得無從下手。釐清觀念之後，第二週的進度就順暢許多。

此外，這次實驗也讓我更注意到接線細節——七段顯示器的共陽極處需要串接限流電阻，避免電流過大燒毀 LED 或 IC 輸出腳。