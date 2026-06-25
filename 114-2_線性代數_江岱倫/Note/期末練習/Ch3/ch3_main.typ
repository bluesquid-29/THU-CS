#import "@preview/mannot:0.3.3": markhl
#let vect(name) = $arrow(#h(1.4pt) name #h(1.4pt))$
// 綜合優化版快顯通知方塊 (Callout / Example Box)
// 綜合優化版快顯通知方塊（新增自訂背景色功能）
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
    #text(size: 20pt, weight: "bold", fill: navy)[線性代數——期末練習]\ 
    #text(size: 16pt, weight: "regular")[Chapter 3.1 \~ 3.4]\ 
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
        [江岱倫],
        [*撰寫日期：*],
        [#underline(offset: 2pt)[#datetime(
          year: 2026,
          month: 6,
          day: 07,
        ).display()]],

      )
    ]
  ]
]

#v(0em)
#outline(title: [目錄], indent: 2em)
#v(0em)
#line(length: 100%, stroke: 1pt + gray)


#grid(
  columns: (1.8fr, 1.05fr), // Two equal columns
  gutter: 0em,         // Space between the tables
  [
    #image("P259.jpeg")
  ],
  [
    #image("P260.jpeg")
  ]
)

#move(dy: 0.5cm)[
  = 手寫 Ch3 Exercise
]
#pagebreak()

// 自動處理多頁 PDF 的全畫面居中與自訂頁碼排版
#let insert-pdf(file-path, total-pages) = {
  // /* TODO: 請確認您的系統字型，確保頁尾字型能正確顯示 */
  
  for p in range(1, total-pages + 1) {
    page(paper: "a4", margin: 0pt)[
      // 1. 讓 PDF 單頁完美填滿並居中在畫布內（配合外層 90% 的縮放感，可用 width 控制）
      #place(center + horizon)[
        #image(file-path, page: p, width: 95%, height: 95%)
      ]
      
      // 2. 局部自訂頁尾位置，向上微調免於貼底
      #place(bottom + center, dy: -0.25cm)[
        #context [
          #set text(size: 9pt, fill: gray)
          第 #counter(page).display() 頁 / 共 #counter(page).final().at(0) 頁
        ]
      ]
    ]
  }
}
// === 使用方式 ===
// /* TODO: 請修改為您的實際檔案路徑與總頁數 */
#insert-pdf("Handwriting_solution.pdf", 11)

= Extra: 考前筆記
== 克拉瑪公式 (Cramer’s Rule)
#set text(size: 11pt)
=== 二元
#v(1em)

已知二元一次方程組：$display(cases(
  a_1 x + b_1 y = c_1,
  a_2 x + b_2 y = c_2
) quad arrow.r.double.long quad mat(delim: "[", a_1, b_1; a_2, b_2) mat(delim: "[", x; y) = mat(delim: "[", c_1; c_2))$

假設：
$
  Delta &= mat(delim: "|", a_1, b_1; a_2, b_2) \ 

  Delta_x &= mat(
    delim: "|", 
    markhl(c_1), b_1;
    markhl(c_2), b_2) \ 
  Delta_y &= mat(
    delim: "|", 
    a_1, markhl(c_1); 
    a_2, markhl(c_2)
  )
$

#table(
  columns: (18em, 15em, 1fr),
  align: left,
  fill: (x, y) => if y == 0 { rgb("#4ccafb") } else { none },
  table.header[條件][解的情況][幾何意義],
  
  [$Delta != 0$], 
  [恰有一組解（唯一解）$ x = Delta_x / Delta, quad y = Delta_y / Delta $], 
  [兩直線相交於一點],
  
  [$Delta = 0$ 且 $Delta_x, Delta_y$ 至少有一個不為 $0$], 
  [無解], 
  [兩直線平行（無交點）],
  
  [$Delta = 0$ 且 $Delta_x = Delta_y = 0$], 
  [無限多組解], 
  [兩直線重合],
)



=== 三元
#v(1em)

已知三元一次方程組：$display(cases(
    a_1 x + b_1 y + c_1 z = d_1,
    a_2 x + b_2 y + c_2 z = d_2,
    a_3 x + b_3 y + c_3 z = d_3,
  ))$

假設：

$
  Delta &= mat(
    delim: "|", 
    a_1, b_1, c_1; 
    a_2, b_2, c_2; 
    a_3, b_3, c_3
  ) \ 

  Delta_x &= mat(
    delim: "|", 
    markhl(d_1), b_1, c_1; 
    markhl(d_2), b_2, c_2; 
    markhl(d_3), b_3, c_3
  ) \ 

  Delta_y &= mat(
    delim: "|", 
    a_1, markhl(d_1), c_1; 
    a_2, markhl(d_2), c_2; 
    a_3, markhl(d_3), c_3
  ) \ 

  Delta_z &= mat(
    delim: "|", 
    a_1, b_1, markhl(d_1); 
    a_2, b_2, markhl(d_2); 
    a_3, b_3, markhl(d_3)
  )
$

#table(
  columns: (18em, 15em, 1fr),
  align: left,
  fill: (x, y) => if y == 0 { rgb("#4ccafb") } else { none },

  table.header[條件][解的情況][幾何意義],
  
  [$Delta != 0$], 
  [恰有一組解（唯一解）$ x = Delta_x / Delta, quad y = Delta_y / Delta, quad z = Delta_z / Delta $], 
  [三平面相交於一點],
  
  [$Delta = 0$ 且 $Delta_x, Delta_y, Delta_z$ 至少有一個不為 $0$], 
  [無解], 
  [兩兩平行、形成三角柱、相交無共點],
  
  [$Delta = 0$ 且 $Delta_x = Delta_y = Delta_z = 0$], 
  [無限多組解], 
  [三平面交於一線、重合為同一平面],
)


#set text(size: 12pt)
#set list(spacing: 0.8em)
#let adj = math.op("adj")

== 定義、定理快速複習
#v(0.5em)
令 $A, B$ 均為 $n times n$ 方陣，$c$ 為一非 0 純量。

#callout(type: "def", title: "行列式", fill: "default")[
+ $det(A)$ 也記作 $abs(A)$
+ 令 $A$ 為一方陣 (square matrix)，元素 (element) 記為 $a$
  - 元素 $a_(i j)$ 之*子行列式 (minor)* 記為 $M_(i j)$，定義為方陣 A 刪去第 i 列第 j 行後留存矩陣之行列式。
  - 元素 $a_(i j)$ 之*餘因子 (cofactor)* 記為 $C_(i j)$， 定義為 $display(C_(i j) = (-1)^(i + j) dot M_(i j))$ #v(1em)
  - 計算行列式技巧  $display(
  mat(
    delim: "[",
    +, -, +, -, ...;
    -, +, -, +, ...;
    +, -, +, -, ...;
    dots.v,  ,  ,  ,    
  )
  )$ ，適用於求降階、餘因子矩陣
]

#callout(type: "theorem", title: "Theorem 3.1 降階", fill: "default")[
  任何一行或任何一列之元素與其對應之餘因子的和：#v(5pt) 
  - 第 $i$ 列展開：$display(abs(A) = a_(i 1)C_(i 1) + a_(i 2)C_(i 2) + ... + a_(i n)C_(i n))$
  - 第 $i$ 列展開：$display(abs(A) = a_(1 j)C_(1 j) + a_(2 j)C_(2 j) + ... + a_(n j)C_(n j))$
]

#callout(type: "theorem", title: "Theorem 3.2 列運算", fill: "default")[
  $B$ 是 $A$ 運算後的結果，#v(5pt) 
  - $A$ 某列（行）乘以 $c$ ：$display(abs(B) = c abs(A))$
  - $A$ 任意交換二列（行）： $display(abs(B) = - abs(A))$
  - $A$ 任意一列（行）之倍數加總至另一列（行）：$display(abs(B) =  abs(A))$
]

#callout(type: "def", title: "奇異矩陣", fill: "default")[
  - 若 $abs(A) = 0$ ，$A$ 是*奇異 (sigular) 矩陣*
  - 若 $abs(A) != 0$ ，$A$ 是*非奇異 (nonsigular) 矩陣*
]


#callout(type: "theorem", title: "Theorem 3.3 ", fill: "default")[
  #set enum(numbering: "(a)")
  若滿足以下條件則 $A$ 為奇異矩陣 #v(5pt)
  + 某一列（行）的所有元素皆為零。
  + 兩列（行）完全相等。
  + 兩列（行）成比例（proportional）。

  ［註：(b) 是 (c) 的特例，但特別列出以示強調。］
]

#callout(type: "theorem", title: "Theorem 3.4", fill: "default")[
  - 純量乘積：$display(abs(c A) = c^n abs(A))$
  - 矩陣乘積：$display(abs(A B) = abs(A) abs(B))$
  - 轉置矩陣：$display(abs(A^t) = abs(A))$ #v(2pt)
  - 反矩陣（若存在）：$display(abs(A^(-1)) = frac(1, abs(A)))$
]

#callout(type: "remark", title: "三角矩陣行列式值", fill: "default")[
  一個三角矩陣的行列式值為其對角線元素之乘積： $display(det(A) = a_(1 1) dot a_(2 2) dot dots dot a_(n n))$
]

#callout(type: "theorem", title: "Theorem 3.5", fill: "default")[
  - $display(A dot adj(A)) = abs(A) dot I_n$ #v(8pt)
  - $display(A^(-1) = frac(1, abs(A)) dot adj(A))$
    - 或是用高斯消去法： $display(mat(delim: "[", A,|, I) arrow.r.long mat(delim: "[", I,|, A^(-1)))$ 
]

#callout(type: "theorem", title: "Theorem 3.6", fill: "default")[
  - $display(A^(-1))$ 存在 $arrow.r.l.double.long$ $abs(A) != 0$
]

#callout(type: "theorem", title: "Theorem 3.7, 3.8 克拉瑪法則", fill: "default")[
  令 $A X = B$ 為一具 $n$ 個方程式、$n$ 個未知數之線性方程式系統，#v(5pt)
  $
    cases(
      a_1 x_1 + b_1 x_2 + dots + z_1 x_n = B_1,
      a_2 x_1 + b_2 x_2 + dots + z_2 x_n = B_2,
      dots.v,
      a_n x_1 + b_n x_2 + dots + z_n x_n = B_n,
    ) quad arrow.l.r.long.double quad
    underbrace(
      mat(delim: "[", a_1, b_1, dots.h, z_1; a_2, b_2, dots.h, z_2; dots.v, dots.v, dots.down,dots.v; a_n, b_n, ..., z_n),
      n "columns"\ A
    ) 
    underbrace(
      vec(delim: "[", x_1, x_2, dots.v, x_n), \ \ \  X
    ) = vec(delim: "[", B_1, B_2, dots.v, B_n) 
  $
  - 若 $abs(A) != 0$ ，則系統有唯一解，且可寫成：
    $
    x_1 = frac(abs(A_1), abs(A))\, quad x_2 = frac(abs(A_2), abs(A))\, quad ... quad \, x_n = frac(abs(A_n), abs(A))
    $
    其中 $A_i$ 為將常數行矩陣 $B$ 取代矩陣 $A$ 第 $i$ 行後所得之矩陣。 #v(2pt)
  - 若 $abs(A) = 0$，則系統可能為無解或無限多組解。
]

#callout(type: "def", title: "特徵值、特徵向量", fill: "default")[
  對純量 $lambda$ 而言，若 $display(bb(R)^(n))$ 中存在有*非 0 向量* $bold(x)$ 使得 $ display(A vect(x) = lambda vect(x)) $
  - $lambda$ 為矩陣 $A$ 之特徵值 (eigenvalue)
  - $vect(x)$ 則稱為對應於 $lambda$ 之特徵向量 (eigenvector)
  上式可改寫成 $ display(A vect(x) - lambda vect(x)) = 0 $ 因此 $ display((A  - lambda I_n )vect(x)) = 0 $
  因為 $vect(x) != 0$ ，故矩陣 $(A - lambda I_n)$ 不可逆 $ det(A - lambda I_n) = 0 $
  // 在其次方程式$X$ = 0 必為一解，稱其為*顯然解 (trivial solution)*
  #v(0.5em)
  #line(length: 100%, stroke: 1pt + rgb("000000"))
  #v(0.5em)

  - $abs(A - lambda I_n)$ #h(22pt)是矩陣 $A$ 的 *特徵多項式 (characteristic polynomial)*
  - $abs(A - lambda I_n) = 0$ 是矩陣 $A$ 的 *特徵方程式 (characteristic equation)*
]

#callout(type: "theorem", title: "Theorem 3.9 特徵空間", fill: "default")[
  設 $lambda$ 為 $A$ 的一個特徵值（eigenvalue）。所有對應於 $lambda$ 的特徵向量（eigenvectors）連同零向量所構成的集合，是 $bb(R)^n$ 的一個子空間（subspace）。

  此子空間稱為 $lambda$ 的*特徵空間（eigenspace）*。
]
