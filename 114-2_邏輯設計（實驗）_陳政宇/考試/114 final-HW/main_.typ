#import "@preview/mannot:0.3.3": markhl
#let vect(name) = $arrow(#h(1.4pt) name #h(1.4pt))$
#let callout(
  type: "note",       // note, tip, important, warning, caution, theorem, green, red, gold, lightgray
  title: auto,        // auto: 依類型顯示預設標籤; none: 隱藏標題橫列; "自訂文字": 顯示自訂標題
  fill: "default",    // auto: 使用類型的預設淡化色; 亦可傳入自訂顏色（如：rgb("#f2f2f2")）
  body
) = {
  // 整合所有顏色、圖示與預設標籤配置
  let conf = (
    note:       (color: rgb("#0969da"), icon: "ℹ️", label: "NOTE"),
    tip:        (color: rgb("#1a7f37"), icon: "💡", label: "TIP"),
    important:  (color: rgb("#8250df"), icon: "💬", label: "IMPORTANT"),
    warning:    (color: rgb("#9a6700"), icon: "⚠️", label: "WARNING"),
    caution:    (color: rgb("#cf222e"), icon: "🛑", label: "CAUTION"),
    green:      (color: rgb("#10b981"), icon: "✅", label: "SUCCESS"),
    red:        (color: rgb("#ef4444"), icon: "❌", label: "ERROR"),
    gold:       (color: rgb("#f59e0b"), icon: "⭐", label: "ATTENTION"),
    lightgray:  (color: rgb("#676e7b"), icon: "📝", label: "INFO"),

    theorem:    (color: rgb("#e07000"), icon: "",   label: "THEOREM"),
    def:        (color: rgb("#006080"), icon: "",   label: "Definition"),
    remark:     (color: rgb("#700070"), icon: "",   label: "Remark"),
    example:    (color: rgb("#008000"), icon: "",   label: "Example"),
  )

  // 取得當前配置，若找不到 type 則預設為藍色 (note)
  let current = conf.at(type, default: conf.note)
  let color = current.color

  // 判斷背景顏色：若 fill 為 auto 則使用原本的淡化色，否則使用使用者傳入的顏色
  let bg-color = if fill == auto { 
    color.lighten(93%) 
  } else if fill == "default" { 
    rgb("#f2f2f2") 
  } else { 
    fill 
  }

  block(
    fill: bg-color,          
    stroke: (left: 4.5pt + color),     
    inset: (x: 12pt, y: 10pt),
    width: 100%,
    radius: (right: 3pt),              
    spacing: 12pt,
    [
      // 判斷是否需要渲染標題列
      #if title != none [
        #let display-title = if title == auto { current.label } else { title }
        #text(fill: color, weight: "bold", size: 0.95em)[
          #if current.icon != "" [ #current.icon #h(4pt) ]
          #display-title
        ]
        #v(0pt) // 有標題時才留間距
      ]
      
      // 內容區塊
      #text(fill: rgb("#24292f"))[#body] 
    ]
  )
}
// ==========================================
// 0. 全域設定 (Page & Text Settings)
// ==========================================
// 0.1 頁面
#set page(
  paper: "a4",
  margin: (top: 0.8cm, bottom: 0.8cm, left: 0.8cm, right: 0.8cm),
  footer: context [
    #set align(center)
    #set text(size: 9pt, fill: gray)
    第 #counter(page).display() 頁 / 共 #counter(page).final().at(0) 頁
  ],
)
#set text(font: ("Noto Serif", "Noto Sans CJK TC"), lang: "zh", size: 11pt)


#show outline.entry: it => {
  v(0.5em)
  it
}




// ==========================================
// 1. 標題與封面
// ==========================================
#align(center)[
  #move(dx: 0cm)[
    #text(size: 20pt, weight: "bold", fill: navy)[邏輯設計——期末練習]\ 
    #text(size: 16pt, weight: "regular")[Chapter 5 \~ 6]\ 
  ]
  #v(1em)
  #line(length: 100%, stroke: 1.5pt + navy)
]

#place(top + right)[
  #move(dy: 0.3cm)[
    #box(width: 11.5em)[
      #set text(size: 11.5pt)
      #grid(
        columns: (auto, auto),
        column-gutter: 0.6em,
        row-gutter: 0.7em,
        align: left + horizon,
        [*撰寫者：*],
        [bluesquid29],
        [*授課老師：*],
        [陳政宇],
        [*撰寫日期：*],
        [#underline(offset: 2pt)[#datetime(
          year: 2026,
          month: 6,
          day: 10,
        ).display()]],

      )
    ]
  ]
]

#v(0em)
#outline(title: [目錄], indent: 2em)
#v(0em)
#line(length: 100%, stroke: 1pt + gray)
#pagebreak()



== 1. （封面）
== 2.
#callout(type: "example", title: none, fill: "default")[
  使用多工器實現布林函數:
  $ F(x, y, z) = Sigma(1,2,6,7) $
]
#image("1-4:1.png", width: 100%)



== 3.
#callout(type: "example", title: none, fill: "default")[
  請試著描繪出所有正反器的特性表、特性方程式以及激勵表。
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


#pagebreak()
== 4.
#callout(type: "example", title: none, fill: "default")[

]



== 5.
#callout(type: "example", title: none, fill: "default")[
  已知一個 SR NAND 閂鎖器輸入 S 與 R 的訊號波形變化圖如下所示，假設忽略門鎖器內部的閘傳遞延遲，試畫出此閂鎖器輸出 Q 的波形變化圖。

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

（請參考附錄的 SR Latch）

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



== 6.
#callout(type: "example", title: none, fill: "default")[
  使用一個 D 型正反器，一個2對1的多工器和一個反閘組成一個 JK 正反器。
]
#image("5-JK(MUX).png", width: 100%)


#pagebreak()
== 7.
#callout(type: "example", title: none, fill: "default")[
  #grid(
    columns: (2fr, 3fr), // Two equal columns
    gutter: 1em,         // Space between the tables
    [
      根據此邏輯電路圖
      1. 寫出狀態方程式和輸出布林方程式
      2. 寫出狀態表
      3. 畫出狀態圖
    ],
    [
      #align(left)[
        #image("5-Problem.png", width: 100%)
      ]
    ]
  )
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



== 8.
#callout(type: "example", title: none, fill: "default")[
  #grid(
    columns: (2fr, 3fr), // Two equal columns
    gutter: 1em,         // Space between the tables
    [
      保持外部輸入、輸出條件不變的情況下，寫出並簡化狀態表中的狀態數目，最後畫出狀態圖
    ],
    [
      #align(left)[
        #image("7-Problem.png", width: 90%)
      ]
    ]
  )
]
#table(
  columns: (1fr, 4.5fr),
  rows: (40em, 31em, 16em),
  stroke: gray,
  align: center + horizon,
  // stroke: none,

  // [*Circuit Diagram* \ (電路圖)], 
  [*Original State Table* \ (原始狀態表)], 
  [
    #align(left)[
      先製作表格，針對每個狀態討論，下圖示範 #box(circle(radius: 6pt)[#set align(center + horizon); a])
      #image("7-intro.png", width: 70%)
      總共有 7 個狀態，a \~ g
      #image("7-ori_state.png", width: 70%)
    ]
  ],

 
  [*Reducing the State Table* \ (化簡狀態表) #place(top + center, dy: -1.1em)[#text(blue, weight: "bold", size: 25pt)[$arrow.b.filled$]]], 
  [
    #align(left)[
      從上表我們可以發現，#text(red)[e 和 g 是一樣的]，所以可以將 g 全部替換成 e （並刪除 g 列）
      #image("7-delete_state1.png", width: 70%)
      又發現 #text(red)[d 和 f 是一樣的]，也是將 f 全部替換成 d （並刪除 f 列）
      #image("7-delete_state2.png", width: 70%)
    ]
  ], 

  [*Reduced State Diagram* \ (化簡後狀態圖) #place(top + center, dy: -1.1em)[#text(blue, weight: "bold", size: 25pt)[$arrow.b.filled$]]],
  [
    #image("7-reduce_diagram.png", width: 34%)
  ]
)


== 9.
#callout(type: "example", title: none, fill: "default")[
  #grid(
    columns: (1.7fr, 1fr), // Two equal columns
    gutter: 1em,         // Space between the tables
    [
      根據圖中狀態表設計一個電路，它能偵測出在輸入端的一串位元中(輸入是一個串列式位元串(serial bit stream))，有三個或更多個連續的 1 出現。寫出
      1. 此 FSM 狀態表
      2. 利用卡諾圖化簡並求出狀態方程式和輸出布林方程式； 
      3. 畫出邏輯電路圖；
      4. 判斷這個 FSM 電路為 Mealy machine 或是 Moore machine。
    ],
    [
      #align(left)[
        #image("8-Problem.png", width: 95%)
      ]
    ]
  )
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
      看上面狀態圖，製作成表：
    ]
    #image("8-statetable.png", width: 78%)
  ],

  [*Equations* \ (方程式) #place(top + center, dy: -1.1em)[#text(blue, weight: "bold", size: 25pt)[$arrow.b.filled$]]], 
  [
    #image("8-Kmap.png", width: 100%)
    $ D_A &= A x + B x \
      D_B &= A x + B' x \
      y &= A B $
  ], 
  
  [*Circuit Diagram* \ (電路圖) #place(top + center, dy: -1.1em)[#text(blue, weight: "bold", size: 25pt)[$arrow.b.filled$]]], 
  [
    #align(left)[
      如下圖，圖很難畫，須要練習。
    ]
    #image("8-circuit.png", width: 75%)
  ],
)
#callout(type: "gold", title: none, fill: auto)[
  看上圖的黃螢光筆，Moore Machine 只由 當前狀態決定，輸入不影響。
  #align(left)[
    #image("moore.png", width: 80%)
  ]
]



== 10.
#callout(type: "example", title: none, fill: "default")[

]



== 11. （與 7 相同題目）
== 12. （與 7 相同題目）
#pagebreak()
== 13.
#callout(type: "example", title: none, fill: "default")[
  以 *D 型正反器*建構的三位元同步下數計數器:
  要設計一個用 D 型正反器建構的三位元同步下數計數器 (111 → 110 → 101 → 100 → 011 → 010 →
  001 → 000 → 111 → 110…，持續循環下去) 。需寫出狀態表、卡諾圖、化簡後正反器輸入方程式、
  狀態方程式以及電路圖。
  #grid(
    columns: (1fr, 2fr), // Two equal columns
    gutter: 1em,         // Space between the tables
    [
      #image("13-circle.png", width: 95%)
    ],
    [
      #table(
        columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
        align: center + horizon,
        fill: (x, y) => {
              if  x == 3 and y == 1  { rgb("#FFD700").lighten(40%) }
              if  x == 4 and y == 1  { rgb("#006FFF").lighten(40%) }
              if  x == 5 and y == 1  { rgb("#ED3624").lighten(40%) }
        },
        
        // 表頭第一行（合併儲存格）
        table.cell(colspan: 3, fill: gray.lighten(50%))[*輸入：目前狀態*],
        table.cell(colspan: 3, fill: gray.lighten(50%))[*輸出：次一狀態*],
        table.cell(rowspan: 2, fill: gray.lighten(50%))[minterm],
        
        // 表頭第二行（欄位名稱）
        [$Q_X(t)$], [$Q_Y(t)$], [$Q_Z(t)$], table.vline(stroke: 2.5pt + black),
        [$Q_X(t+1)$], [$Q_Y(t+1)$], [$Q_Z(t+1)$], table.vline(stroke: 2.5pt + black),
        
        // 資料行
      [0], [0], [0], [1], [1], [1], [$m_0$],
      [0], [0], [1], [0], [0], [0], [$m_1$],
      [0], [1], [0], [0], [0], [1], [$m_2$],
      [0], [1], [1], [0], [1], [0], [$m_3$],
      [1], [0], [0], [0], [1], [1], [$m_4$],
      [1], [0], [1], [1], [0], [0], [$m_5$],
      [1], [1], [0], [1], [0], [1], [$m_6$],
      [1], [1], [1], [1], [1], [0], [$m_7$],
      )
    ]
  )
]

由於使用 D 型正反器，因此輸入 D 等於下一個狀態：
$display(cases(Q_X (t + 1) &= D_X,
  Q_Y (t + 1) &= D_Y,
  Q_Z (t + 1) &= D_Z )) quad $。使用卡諾圖化簡：
  #image("13-Kmap.png")

畫出電路圖：
#image("13-sim.png")


#pagebreak()
== 14.
#callout(type: "example", title: none, fill: "default")[
  請利用 *JK 型正反器*設計一個4位元的下數計數器。需寫出FSM狀態圖、狀態表、卡諾圖、化簡後正反器輸入方程式、狀態方程式 、以及電路圖。
]
#table(
  columns: (auto, auto),
  // rows: (2em, 2em, 2em),
  align: left + horizon,
  stroke: none, // 隱藏預設格線

  table.cell(rowspan: 2)[#image("14-cycle_(graphviz).svg", width: 62%)],
  [
    #align(left)[
      請參考：
      - JK 的激勵表，可以找到規律
      - State Diagram
    ]
  ],
  [
    #table(
      columns: (auto, auto, auto, auto),
      align: left + horizon,
      fill: none,
      table.header([*$Q(t)$*], [*$Q(t+1)$*], [*J*], [*K*]),
      [0], [0], [0], [X],
      [0], [1], [1], [X],
      [1], [0], [X], [1],
      [1], [1], [X], [0],
    )
  ]
)

寫出完整狀態表：
#table(
  // columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, (0.5fr) * 8),
  columns: (0.8fr,) * 4 + (1.4fr,) * 4 + (1fr,) + (0.5fr,) * 8, 
  align: center + horizon,
  // fill: (x, y) => {
  //       if  x == 3 and y == 1  { rgb("#FFD700").lighten(40%) }
  //       if  x == 4 and y == 1  { rgb("#006FFF").lighten(40%) }
  //       if  x == 5 and y == 1  { rgb("#ED3624").lighten(40%) }
  // },
  
  // 表頭第一行（合併儲存格）
  table.cell(colspan: 4, fill: gray.lighten(50%))[*輸入：目前狀態*],
  table.cell(colspan: 4, fill: gray.lighten(50%))[*輸出：次一狀態*],
  table.cell(rowspan: 2, fill: gray.lighten(50%))[min term],
  table.cell(rowspan: 2, fill: gray.lighten(50%))[$J_3$], 
  table.cell(rowspan: 2, fill: gray.lighten(50%))[$K_3$], table.vline(stroke: 2.5pt + black),
  table.cell(rowspan: 2, fill: gray.lighten(50%))[$J_2$], 
  table.cell(rowspan: 2, fill: gray.lighten(50%))[$K_2$], table.vline(stroke: 2.5pt + black),
  table.cell(rowspan: 2, fill: gray.lighten(50%))[$J_1$], 
  table.cell(rowspan: 2, fill: gray.lighten(50%))[$K_1$], table.vline(stroke: 2.5pt + black),
  table.cell(rowspan: 2, fill: gray.lighten(50%))[$J_0$], 
  table.cell(rowspan: 2, fill: gray.lighten(50%))[$K_0$],
  
  // 表頭第二行（欄位名稱）
  [$Q_3(t)$], [$Q_2(t)$], [$Q_1(t)$], [$Q_0(t)$], table.vline(stroke: 2.5pt + black),
  [$Q_3(t+1)$], [$Q_2(t+1)$], [$Q_1(t+1)$], [$Q_0(t+1)$], table.vline(stroke: 2.5pt + black),
  
  // 資料行
  [0], [0], [0], [0], [1], [1], [1], [1], [$m_0$],  [1], [X], [1], [X], [1], [X], [1], [X], 
  [0], [0], [0], [1], [0], [0], [0], [0], [$m_1$],  [0], [X], [0], [X], [0], [X], [X], [1], 
  [0], [0], [1], [0], [0], [0], [0], [1], [$m_2$],  [0], [X], [0], [X], [X], [1], [1], [X], 
  [0], [0], [1], [1], [0], [0], [1], [0], [$m_3$],  [0], [X], [0], [X], [X], [0], [X], [1], 
  [0], [1], [0], [0], [0], [0], [1], [1], [$m_4$],  [0], [X], [X], [1], [1], [X], [1], [X], 
  [0], [1], [0], [1], [0], [1], [0], [0], [$m_5$],  [0], [X], [X], [0], [0], [X], [X], [1], 
  [0], [1], [1], [0], [0], [1], [0], [1], [$m_6$],  [0], [X], [X], [0], [X], [1], [1], [X], 
  [0], [1], [1], [1], [0], [1], [1], [0], [$m_7$],  [0], [X], [X], [0], [X], [0], [X], [1], 
  [1], [0], [0], [0], [0], [1], [1], [1], [$m_8$],  [X], [1], [1], [X], [1], [X], [1], [X], 
  [1], [0], [0], [1], [1], [0], [0], [0], [$m_9$],  [X], [0], [0], [X], [0], [X], [X], [1], 
  [1], [0], [1], [0], [1], [0], [0], [1], [$m_10$], [X], [0], [0], [X], [X], [1], [1], [X], 
  [1], [0], [1], [1], [1], [0], [1], [0], [$m_11$], [X], [0], [0], [X], [X], [0], [X], [1], 
  [1], [1], [0], [0], [1], [0], [1], [1], [$m_12$], [X], [0], [X], [1], [1], [X], [1], [X], 
  [1], [1], [0], [1], [1], [1], [0], [0], [$m_13$], [X], [0], [X], [0], [0], [X], [X], [1], 
  [1], [1], [1], [0], [1], [1], [0], [1], [$m_14$], [X], [0], [X], [0], [X], [1], [1], [X], 
  [1], [1], [1], [1], [1], [1], [1], [0], [$m_15$], [X], [0], [X], [0], [X], [0], [X], [1], 
)

畫出卡諾圖：
#grid(
  columns: (1fr, 1fr), // Two equal columns
  gutter: 1em,         // Space between the tables
  grid.vline(x: 1, stroke: 0.5pt + gray),
  [
    #image("14-JK0.png", width: 100%)
  ],
  [
    #image("14-JK1.png", width: 100%)
  ],
  grid.hline(y: 1, stroke: 0.5pt + gray),
  [
    #image("14-JK2.png", width: 100%)
  ],
  [
    #image("14-JK3.png", width: 100%)
  ]
)



== 15.
#callout(type: "example", title: none, fill: "default")[
  請利用 *T 型正反器*設計一個4位元的下數計數器。需寫出FSM狀態圖、狀態表、卡諾圖、化簡後正反器輸入方程式、狀態方程式 、以及電路圖。
]
