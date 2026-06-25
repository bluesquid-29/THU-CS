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

#show raw.where(block: false): it => {
  box(
    fill: luma(240), // 淺灰色底色 (0-255)
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt, // 圓角
    text(fill: rgb("#000000"), it), // 文字改為紅色（如 Markdown 常見配色）
  )
}

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
#v(2.5em)



// 1.2 標題
#align(center)[
  #move(dx: -2.5cm)[  // 調整這個數值（例如 -1cm, -3cm）來控制向左移的程度
    #text(size: 22pt, weight: "bold", fill: navy)[實驗五：二補數與一補數轉十進位解碼器]
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

+ 經 *4-bit DIP* 開關#highlight(fill: green.lighten(25%))[輸入二進位值]，並由綠色 LED 顯示輸入位元狀態。
+ 透過 *2-to-1 MUX* 切換一/二補數模式，選定#highlight(fill: yellow.lighten(25%))[二補數]時點亮黃色 LED。
+ 藍色 LED 顯示#highlight(fill: aqua.lighten(0%))[符號位元]；紅色 LED 顯示 #highlight(fill: red.lighten(25%))[BCD]位元狀態。
+ 透過兩組 *7-Segment Display* 分別呈現十進位數值與負號。



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

= 原理知識
== 補數對照表
#align(center)[
  #table(
    columns: (auto, auto, auto, auto),
    [*7-Segment*], [*LED*], [*一補數*], [*二補數*],
    [7], [⚪ ⚪🔴🔴🔴], [0111], [0111],
    [6], [⚪ ⚪🔴🔴⚪], [0110], [0110],
    [5], [⚪ ⚪🔴⚪🔴], [0101], [0101],
    [4], [⚪ ⚪🔴⚪⚪], [0100], [0100],
    [3], [⚪ ⚪⚪🔴🔴], [0011], [0011],
    [2], [⚪ ⚪⚪🔴⚪], [0010], [0010],
    [1], [⚪ ⚪⚪⚪🔴], [0001], [0001],
    [0], [⚪ ⚪⚪⚪⚪], [0000], [0000],
    [#text(fill: blue)[*－*]0], [🔵 ⚪⚪⚪⚪], [1111], [\_],
    [#text(fill: blue)[*－*]1], [🔵 ⚪⚪⚪🔴], [1110], [1111],
    [#text(fill: blue)[*－*]2], [🔵 ⚪⚪🔴⚪], [1101], [1110],
    [#text(fill: blue)[*－*]3], [🔵 ⚪⚪🔴🔴], [1100], [1101],
    [#text(fill: blue)[*－*]4], [🔵 ⚪🔴⚪⚪], [1011], [1100],
    [#text(fill: blue)[*－*]5], [🔵 ⚪🔴⚪🔴], [1010], [1011],
    [#text(fill: blue)[*－*]6], [🔵 ⚪🔴🔴⚪], [1001], [1010],
    [#text(fill: blue)[*－*]7], [🔵 ⚪🔴🔴🔴], [1000], [1001],
    [#text(fill: blue)[*－*]8], [🔵 🔴⚪⚪⚪], [\_], [1000],
  )
]

== MUX 多工器
#figure(
  image("2to1MUX.png", width: 100%),
//   caption: [],
)

= 電路設計
== 手繪 IC 配線圖
#figure(
  image("手繪 IC 配線圖.png", width: 105%),
  //   caption: [],
)
== Digital-Logic-Sim 截圖
#figure(
  image("20_(digital-logic-sim).png", width: 105%),
  //   caption: [],
)

= 實驗結果照片
#pagebreak()

#figure(
  grid(
    // 1. 定義 4 欄，每欄平分寬度
    columns: (1fr, 1fr, 1fr, 1fr),

    // 2. 設定間隙 (Gutter)，讓圖片之間有點呼吸空間，不要黏死
    column-gutter: 0pt,
    row-gutter: 0pt,

    // 3. 畫上淡淡的灰色邊框 (可選，如果要像表格一樣整齊就加上去)
    stroke: 5pt + gray.lighten(70%),

    // 4. 對齊方式
    align: center + horizon,

    // 5. 自動填入 16 張圖片 (假設你的路徑存在 all_results 陣列中)
    ..range(0, 24)
      .map(i => (
        box(inset: 2pt)[
          #image("實驗拍照/" + str(i) + ".jpg", width: 100%, height: 16%)

          //       #v(-2pt)
          //       #text(size: 8pt, fill: gray)[Case #i]
        ]
      ))
      .flatten()
  ),
//   caption: [],
)

#figure(
  grid(
    // 1. 定義 4 欄，每欄平分寬度
    columns: (1fr, 1fr, 1fr, 1fr),

    // 2. 設定間隙 (Gutter)，讓圖片之間有點呼吸空間，不要黏死
    column-gutter: 0pt,
    row-gutter: 0pt,

    // 3. 畫上淡淡的灰色邊框 (可選，如果要像表格一樣整齊就加上去)
    stroke: 5pt + gray.lighten(70%),

    // 4. 對齊方式
    align: center + horizon,

    // 5. 自動填入 16 張圖片 (假設你的路徑存在 all_results 陣列中)
    ..range(24, 32)
      .map(i => (
        box(inset: 2pt)[
          #image("實驗拍照/" + str(i) + ".jpg", width: 100%, height: 16%)

          //       #v(-2pt)
          //       #text(size: 8pt, fill: gray)[Case #i]
        ]
      ))
      .flatten()
  ),
//   caption: [],
)

// #pagebreak()
#set par(
  first-line-indent: (amount: 2em, all: true),
  justify: true, 
  leading: 0.5em,
)
= 心得
== 嘉心
實驗五是我們花最久時間的一次，總共花了三週才完成。聽說其他組都是直接由實驗四改裝，但我們選擇重新從頭開始做（模仿期末考試）。

第一步是手繪五顆 IC 晶片的腳位接腳圖，雖然這個步驟就耗費了大量時間，但是因此能在實際接線時，不用煩惱自己是否忘記 IC 腳位。

好不容易接完電路，卻發現短路了。那種感覺非常難受，找遍了整個電路也找不出原因，最後只好將所有線路全部拆掉重來。

第二次接完之後，結果還是錯的。我們只能一條線、一個腳位慢慢檢查，反覆確認。其中的錯誤是，7483 晶片上沒有用到的腳位沒有明確給定高電位或低電位，導致電路運作不穩定，輸出結果飄忽不定。

這次讓我們學到一個非常重要的觀念：IC 晶片上所有未使用的腳位都必須明確接高電位或低電位，不能懸空，否則會造成難以預測的錯誤。


== 竣崴
第一、二週吃了不少苦頭。以前我們不太重視電源供應器 CC 與 CV 模式的差異，因此在電路已經短路的情況下還渾然不知，繼續埋頭接線。找了很久都找不出短路位置，最後只好把所有線路全部拔除，重新來過。

第三週前我徹底學會使用 Digital Logic Sim，在軟體裡手動模擬出整個實驗電路。能夠從頭搓出來，代表我真的徹底理解了每個模組的概念，也能直觀地觀察邏輯電位的變化。有了這個基礎，第三週的實作效率大幅提升，順利完成了實驗。

這次我們也優化了開關的擺放位置，讓操作時不容易碰到其他線路，降低出錯的機率。這個方法我們打算在期末考試中繼續沿用。
