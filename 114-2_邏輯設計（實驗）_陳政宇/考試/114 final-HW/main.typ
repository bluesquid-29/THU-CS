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
#set text(font: ("Noto Serif", "Noto Sans CJK TC"), lang: "zh")

#let example_box(type: "blue", it) = {
  let color = if type == "green" { rgb("#10b981") }
         else if type == "red"   { rgb("#ef4444") }
         else if type == "gold"  { rgb("#f59e0b") }
         else if type == "lightgray"  { rgb("#dfe2e5") }
         else { rgb("#6725eb") } // 預設藍色

  block(
    fill: color.lighten(92%),
    stroke: (left: 4pt + color),
    inset: (x: 12pt, y: 10pt),
    width: 100%,
    radius: 2pt,
    it
  )
}

#show outline.entry: it => {
  v(0.5em)
  it
}

// ==========================================
// 1. 標題與封面
// ==========================================
#align(center)[
  #move(dx: 0cm)[
    #text(size: 20pt, weight: "bold", fill: navy)[邏輯設計——小考二]\ 
    #text(size: 16pt, weight: "regular")[Chapter 4.9 \~ 5.8]\ 
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
          month: 6,
          day: 03,
        ).display()]],

      )
    ]
  ]
]

#v(1em)
#outline(title: [目錄], indent: 2em)
#v(2em)
#pagebreak()





// ==========================================
// 2. 內容
// ==========================================
= 1.
#example_box(type: "lightgray")[
  (20%) 請設計一個輸入如下表，但是輸入 $D_3$ 為最高優先權且輸入 $D_0$ 為最低優先權的一個*四位元優先權編碼器*。（寫出卡諾圖化簡後的輸出函數並畫出邏輯電路圖）。($V$ 為有效位元指示器)
  #align(center)[
    #table(
      // 總共 7 欄，每欄等寬，文字置中對齊
      columns: (1fr,) * 7,
      align: center + horizon,
      stroke: 0.5pt + black,

      fill: (x, y) => { 
        if y == 4 { rgb("#fee1e4") }
        if y == 5 { rgb("#E1F5FE") }
        if y == 6 { rgb("#f9f0be") }
      },
      
      // --- 第一列：大標題欄位 ---
      table.cell(colspan: 4)[Input],
      table.cell(colspan: 3)[Output],
      
      // --- 第二列：變數名稱 ---
      [$D_0$], [$D_1$], [$D_2$], [$D_3$], [$x$], [$y$], [$V$],
      
      // --- 第三列 ---
      [0], [0], [0], [0], [X], [X], [0],
      
      // --- 第四列 ---
      [1], [0], [0], [0], [0], [0], [1],
      
      // --- 第五列 ---
      [X], [1], [0], [0], [0], [1], [1],
      
      // --- 第六列 ---

      [X], [X], [1], [0], [1], [0], [1],
      
      // --- 第七列 ---
      [X], [X], [X], [1], [1], [1], [1],
    )
  ]
]

== Step1: Truth-table & K-Map

#table(
  // 定義 2 欄（左欄、右欄）
  columns: (1fr, 1.5fr),
  align: center,
  
  stroke: none, 
  
  [
    #align(center)[
      #table(
        columns: (1fr,) * 8,
        align: center + horizon,
        stroke: 0.5pt + black,
        
        fill: (x, y) => {
          if      y >= 4  and y <= 5  { rgb("#fee1e4") }
          else if y >= 6 and y <= 9 { rgb("#E1F5FE") }
          else if y >= 10 and y <= 17 { rgb("#f9f0be") }
        },

        // --- 第一列：大標題欄位 ---
        table.cell(colspan: 4)[Input],
        table.cell(colspan: 3)[Output],
        table.cell(rowspan: 2)[min-\ term],
        // --- 第二列：變數名稱 ---
        [$D_0$], [$D_1$], [$D_2$], [$D_3$], [$x$], [$y$], [$V$],
        
        [0], [0], [0], [0], [X], [X], [0], [$m_0$],
        [1], [0], [0], [0], [0], [0], [1], [$m_8$],
        [0], [1], [0], [0], [0], [1], [1], [$m_4$],
        [1], [1], [0], [0], [0], [1], [1], [$m_12$],
        [0], [0], [1], [0], [1], [0], [1], [$m_2$],
        [0], [1], [1], [0], [1], [0], [1], [$m_6$],
        [1], [0], [1], [0], [1], [0], [1], [$m_10$],
        [1], [1], [1], [0], [1], [0], [1], [$m_14$],
        [0], [0], [0], [1], [1], [1], [1], [$m_1$],
        [0], [0], [1], [1], [1], [1], [1], [$m_3$],
        [0], [1], [0], [1], [1], [1], [1], [$m_5$],
        [0], [1], [1], [1], [1], [1], [1], [$m_7$],
        [1], [0], [0], [1], [1], [1], [1], [$m_9$],
        [1], [0], [1], [1], [1], [1], [1], [$m_11$],
        [1], [1], [0], [1], [1], [1], [1], [$m_13$],
        [1], [1], [1], [1], [1], [1], [1], [$m_15$],
      )
    ]
  ],
  [
    #figure(
      image("1-Kmap.png", width: 100%),
      //   caption: [],
    )
  ],
)


== Step2: Equation & Circuit
#table(
  columns: (1fr, 1.75fr),
  align: center + horizon,
  stroke: none, 
  
  [
    #figure(
      image("1-equation.png", width: 100%),
      //   caption: [],
    )
  ],
  [
    #figure(
      image("1-circuit.png", width: 100%),
      //   caption: [],
    )
  ],
)

#v(0.5em)
#line(length: 100%, stroke: 1pt + rgb("000000"))
#v(0.5em)



= 2. 
#example_box(type: "lightgray")[
  (20%) 請試著描繪 (a) *SR NOR Latch* 以及 (b)* D Latch* 的邏輯電路圖以及所代表的功能。（每一個閂鎖器為 10%，邏輯電路圖 5%，功能表 5%）
]

== SR NOR Latch
#figure(
  image("2-SRNOR.png", width: 100%),
  //   caption: [],
)

== D Latch
#figure(
  image("2-D.png", width: 100%),
  //   caption: [],
)

#v(0.5em)
#line(length: 100%, stroke: 1pt + rgb("000000"))
#v(0.5em)



= 3.
#example_box(type: "lightgray")[
  (30%) 請試著描繪出所有正反器的特性表、特性方程式以及激勵表。（共三種 (D, JK, T)，功能表 4%、功能函數 3% 和激勵表 3%）
]

#table(
  columns: (1fr, 2.5fr, 4fr, 3fr),
  align: left + horizon,
  stroke: 0.5pt + gray,
  fill: (x, y) => if y == 0 { rgb("#1a5f7a") } else { none },
  
  // 主表頭
  table.header(
    text(white)[*正反器* \ *(flipflop)*],
    text(white)[*特性方程式* \ *(Characteristic Eq.)*],
    text(white)[*特性表 (Characteristic Table)*],
    text(white)[*激勵表 (Excitation Table)*],
  ),

  // --- D 正反器 ---
  [*D*],
  $Q(t+1) = D$,
  table(
    columns: (auto, auto, auto),
    align: left + horizon,
    fill: none,
    table.header([*D*], [*$Q(t+1)$*], [*說明*]),
    // table.hline(stroke: 0.5pt + gray),
    // [0], [0], [Reset (重設)],
    [1], [1], [Set (設定)],
  ),
  table(
    columns: (auto, auto, auto),
    align: left + horizon,
    fill: none,
    table.header([*$Q(t)$*], [*$Q(t+1)$*], [*D*]),
    [0], [0], [0],
    [0], [1], [1],
    [1], [0], [0],
    [1], [1], [1],
  ),

  // --- JK 正反器 ---
  [*JK*],
  $Q(t+1) = J Q' + K' Q$,
  table(
    columns: (auto, auto, auto, auto),
    align: left + horizon,
    fill: none,
    table.header([*J*], [*K*], [*$Q(t+1)$*], [*說明*]),
    [0], [0], [$Q(t)$], [No change (保持)],
    [0], [1], [0], [Reset (重設)],
    [1], [0], [1], [Set (設定)],
    [1], [1], [$Q'(t)$], [Complement (反轉)],
  ),
  table(
    columns: (auto, auto, auto, auto),
    align: left + horizon,
    fill: none,
    table.header([*$Q(t)$*], [*$Q(t+1)$*], [*J*], [*K*]),
    [0], [0], [0], [X],
    [0], [1], [1], [X],
    [1], [0], [X], [1],
    [1], [1], [X], [0],
  ),

  // --- T 正反器 ---
  [*T*],
  $Q(t+1) = T xor Q$,
  table(
    columns: (auto, auto, auto),
    align: left + horizon,
    fill: none,
    table.header([*T*], [*$Q(t+1)$*], [*說明*]),
    // table.hline(stroke: 0.5pt + gray),
    [0], [$Q(t)$], [No change (保持)],
    [1], [$Q'(t)$], [Complement (反轉)],
  ),
  table(
    columns: (auto, auto, auto),
    align: left + horizon,
    fill: none,
    table.header([*$Q(t)$*], [*$Q(t+1)$*], [*T*]),
    [0], [0], [0],
    [0], [1], [1],
    [1], [0], [1],
    [1], [1], [0],
  ),
)

#v(0.5em)
#line(length: 100%, stroke: 1pt + rgb("000000"))
#v(0.5em)



= 4.
#example_box(type: "lightgray")[
  (10%) 已知一個 SR NAND 閂鎖器輸入 S 與 R 的訊號波形變化圖如下所示，假設忽略門鎖器內部的閘傳遞延遲，試畫出此閂鎖器輸出 Q 的波形變化圖。

  #align(center)[
    #let H = table.cell(stroke: (top: 1.5pt + black))[ ]
    #let L = table.cell(stroke: (bottom: 1.5pt + black))[ ]     
    #let H-trig = table.cell(stroke: (top: 1.5pt + black, left: 1.5pt + black))[ ]
    #let L-trig = table.cell(stroke: (bottom: 1.5pt + black, left: 1.5pt + black))[ ]
    #table(
      columns: (3.2em, ..(2.6em,) * 7),
      rows: (1.8em, 2.3em, 1.2em, 2.3em),
      align: center + horizon,
      
      // 背景灰色虛線（僅垂直時間分割線）
      stroke: (x, y) => if x > 0 {
        (left: (paint: gray.lighten(35%), thickness: 0.6pt))
      } else {
        none
      },

      // Row 1: 時間軸
      none, [$t_1$], [$t_2$], [$t_3$], [$t_4$], [$t_5$], [$t_6$], [$t_7$],

      // Row 2: S 訊號
      align(right)[*S* #text(size: 14pt, fill: gray)[1 \ 0]], 
      H, H, L-trig, H-trig, H, H, L-trig,

      // Row 3: 間隔（完全空白）
      none, none, none, none, none, none, none, none,

      // Row 4: R 訊號
      align(right)[*R* #text(size: 14pt, fill: gray)[1 \ 0]], 
      L, H-trig, H, L-trig, H-trig, H, H,
    )
  ]
]

按照筆者的記憶方法，想求出 SR NAND 的功能表，即將 NOR 的輸入全部取反。

#figure(
  image("4-SRNAND.png", width: 80%),
  //   caption: [],
)

因此可以得到：

#align(center)[
  #let H = table.cell(stroke: (top: 1.5pt + blue))[ ]
  #let L = table.cell(stroke: (bottom: 1.5pt + blue))[ ]     
  #let H-trig = table.cell(stroke: (top: 1.5pt + blue, left: 1.5pt + blue))[ ]
  #let L-trig = table.cell(stroke: (bottom: 1.5pt + blue, left: 1.5pt + blue))[ ]
  #table(
    columns: (3.2em, ..(2.6em,) * 7),
    rows: (1.8em, 2.3em),
    align: center + horizon,
    
    // 背景灰色虛線（僅垂直時間分割線）
    stroke: (x, y) => if x > 0 {
      (left: (paint: gray.lighten(35%), thickness: 0.6pt))
    } else {
      none
    },

    // Row 1: 時間軸
    none, [$t_1$], [$t_2$], [$t_3$], [$t_4$], [$t_5$], [$t_6$], [$t_7$],

    align(right)[*Q* #text(size: 14pt, fill: gray)[1 \ 0]], 
    L, L, H-trig, L-trig, L, L, H-trig,
  )
]

#v(0.5em)
#line(length: 100%, stroke: 1pt + rgb("000000"))
#v(0.5em)



= 5.
#example_box(type: "lightgray")[
  (20%) 根據此邏輯電路圖(a) 寫出狀態方程式和輸出布林方程式；(b) 寫出狀態表；(c) 畫出狀態圖。
  #align(left)[
    #image("5-Problem.png", width: 75%)
  ]
]

#table(
  columns: (1fr, 4fr),
  rows: (25em, 8em, 25em, 20em),
  stroke: gray,
  align: center + horizon,
  // stroke: none,

  [*Circuit Diagram* \ (電路圖)], 
  [
    #align(left)[
      如下圖，標示各物件。
    ]
    #image("5-circuitnote.png", width: 49%)
  ],

 
  [*Equations* \ (方程式) #place(top + center, dy: -1.1em)[#text(blue, weight: "bold", size: 25pt)[$arrow.b.filled$]]], 
  [
    $ y &= (A + B) x' \
      A(t + 1) &= A x + B x \
      B(t + 1) &= A' x $
  ], 
  
  [*State Table* \ (狀態表) #place(top + center, dy: -1.1em)[#text(blue, weight: "bold", size: 25pt)[$arrow.b.filled$]]],
  [
    #image("5-statetable.png", width: 78%)
  ],

  [*State Diagram* \ (狀態圖) #place(top + center, dy: -1.1em)[#text(blue, weight: "bold", size: 25pt)[$arrow.b.filled$]]],
  [
    #image("5-statediagram.png", width: 78%)
  ]
)

#v(0.5em)
#line(length: 100%, stroke: 1pt + rgb("000000"))
#v(0.5em)



= 6.
#example_box(type: "lightgray")[
  (20%) 根據圖中狀態表設計一個電路，它能偵測出在輸入端的一串位元中(輸入是一個串列式位元串(serial bit stream))，有三個或更多個連續的 1 出現。寫出(a) 此 FSM 狀態表；(b)利用卡諾圖化簡並求出狀態方程式和輸出布林方程式；(c) 畫出邏輯電路圖；(d) 判斷這個 FSM 電路為 Mealy machine 或是 Moore machine，並說明為什麼(沒寫原因不給分)。
  #align(left)[
    #image("6-Problem.png", width: 75%)
  ]
]

#table(
  columns: (1fr, 4fr),
  rows: (24em, 16em, 28em),
  stroke: gray,
  align: center + horizon,
  // stroke: none,

  [*State Table* \ (狀態表)],
  [
    #align(left)[
      看上面狀態圖，推導出：
    ]
    #image("6-statetable.png", width: 78%)
  ],

  [*Equations* \ (方程式) #place(top + center, dy: -1.1em)[#text(blue, weight: "bold", size: 25pt)[$arrow.b.filled$]]], 
  [
    #image("6-Kmap.png", width: 100%)
    $ D_A &= A x + B x \
      D_B &= A x + B' x \
      y &= A B $
  ], 
  
  [*Circuit Diagram* \ (電路圖) #place(top + center, dy: -1.1em)[#text(blue, weight: "bold", size: 25pt)[$arrow.b.filled$]]], 
  [
    #align(left)[
      如下圖，圖很難畫，須要練習。
    ]
    #image("6-circuit.png", width: 75%)
  ],
)

#example_box(type: "gold")[
  看上圖的黃螢光筆，Moore Machine 只由 當前狀態決定，輸入不影響。
  #align(left)[
    #image("moore.png", width: 80%)
  ]
]

#v(0.5em)
#line(length: 100%, stroke: 1pt + rgb("000000"))
#v(0.5em)