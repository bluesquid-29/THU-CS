// ╔══════════════════════════════════════════╗
// ║ 0. 全域設定
// ╚══════════════════════════════════════════╝
#set page(
  paper: "a4",
  margin: 0.5cm,
//   flipped: true
)
#set text(font: ("Noto Serif", "Noto Sans CJK TC"), size: 11pt, lang: "zh")

// Tab 4格 與 程式碼字體大小
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

// 預設題解框樣式
#let example_box(type: "blue", it) = {
  let color = if type == "green" { rgb("#10b981") }
         else if type == "red"   { rgb("#ef4444") }
         else if type == "gold"  { rgb("#f59e0b") }
         else { rgb("#2563eb") } // 預設藍色

  block(
    fill: color.lighten(92%),
    stroke: (left: 4pt + color),
    inset: (x: 12pt, y: 10pt),
    width: 100%,
    radius: 2pt,
    it
  )
}


// 行號與程式碼渲染邏輯 (維持不變)
#show raw.where(block: true): it => {
let lines = it.lines
  block(
    fill: rgb("#f8f9fa"),          // 淺灰色背景
    inset: 8pt,                    // 內部留白
    radius: 4pt,                   // 圓角
    stroke: 0.5pt + luma(200),     // 灰色邊框
    width: 100%,
    {
      set text(size: 0.9em, font: "DejaVu Sans Mono")

      // 自動判定：超過 5 行才顯示行號
      if lines.len() > 6 {
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
      } else {
        // 5 行以內（如 LCS 公式）不加行號，直接顯示
        it
      }
    }
  )
}

// 目錄樣式
#show outline.entry: it => {
  v(0.5em)
  it
}

// 標題區
#align(center)[
  #text(size: 22pt, weight: "bold")[26/05/04 Ch12小考——class] \
  #text(size: 16pt, weight: "regular")[Problem 1, 2, 3]
]

#v(1em)
#outline(title: [目錄], indent: 2em)
#v(2em)



// ╔══════════════════════════════════════════╗
// ║ 1. 核心函數定義
// ╚══════════════════════════════════════════╝
#let exam_item(title, desc, analysis, examples, code_file, references: ()) = {
  pagebreak(weak: true)
  heading(level: 1, title)

  if references.len() > 0 {
    v(0.2em)
    block(inset: (left: 0.8em), {
      for ref in references {
        set text(size: 0.8em, fill: rgb("#2563eb"))
        [🔗 #link(ref) \ ]
      }
    })
  }
  v(0.8em)

  [#text(fill: navy)[== 題目敘述]]
  desc

  v(1.5em)
  [#text(fill: navy)[== 題解說明]]
  analysis

  v(1em)
  example_box(examples)

  v(1.5em)
  [#text(fill: navy)[== 完整程式碼]]

  raw(read(code_file), lang: "cpp", block: true)
}


// ╔══════════════════════════════════════════╗
// ║ 2. 實際內容填寫區
// ╚══════════════════════════════════════════╝
#exam_item(
  "1. 彼得先生的薪水",
  [
    定義一個Emplyee員工類別，該類別的成員如下：

    #example_box(type: "gold")[
      + `_salary` 屬性：屬於私有屬性，屬性值為員工的薪資。
      + `public void SetSalary()` 方法：可用來設定員工薪資，最小值 20000，最大值 40000。
      + `public int GetSalary()` 方法：可用來取得員工薪資。
      + `Ename` 屬性：可用來設定員工的姓名。
      + `public void PrintData()` 方法：顯示員工的姓名，薪資資訊。
    ]

    使用Employee類別建立物件，並將該物件Ename屬性值設為"彼得"，而`_salary`屬性值設為19000，程式執行結果如下：
  ],
  [
    照題意模擬即可。`class`：
    #raw(read("12-class.cpp"), lang: "cpp", block: true)
  ],
  [
    #figure(
      image("12_1-(terminal).png", width: 80%),
    )
  ],
  "12_1.cpp",
)

#exam_item(
  "2. 很多人的薪水",
  [
    延續上例，使用 `new` 運算子動態配置 Employee 員工物件陣列，並讓使用者自己指定員工人數，接著再逐一輸入每一位員工的姓名與薪資，最後再印出所輸入的所有員工資料。
  ],
  [
    `new` 宣告：
    ```cpp
    Employee *A = new Employee[n];
    ```
  ],
  [
    #figure(
      image("12_2-(terminal).png", width: 75%),
    )
  ],
  "12_2.cpp",
)

#exam_item(
  "3. 查詢薪水",
  [
    延續上例，再製作搜尋員工姓名的功能。先讓使用者輸入要搜尋員工的姓名，接著會由員工物件陣列去尋找所符合的資料並顯示出來。
  ],
  [

  ],
  [
    #figure(
      image("12_3-(terminal).png", width: 75%),
    )
  ],
  "12_3.cpp",
)
// #exam_item(
//   "小四數學(乘積最大化)",
//   [
//     給定 $m$ 個數字（0-9），將其全部使用並拆成兩個整數 $a$ 與 $b$，求 $a times b$ 的最大可能值。
//   ],
//   [
//     這是一個貪心演算法問題。為了讓乘積最大，我們必須讓兩個數字的位元長度盡可能接近，且高位數的數字越大越好。
//
//     1. *策略邏輯*：
//        - 將所有數字由大到小排序。
//        - 取前兩個最大的數字分別作為 $a$ 與 $b$ 的最高位。
//        - 每次將新數字接在當前*數值較小*的那個整數後面。
//
//     2. *數學直觀*：
//        若 $a+b$ 為定值，則當 $|a - b|$ 越小時，$a times b$ 的值越大。
//   ],
//   [
//     *分配過程視覺化 (以 $a, b$ 的增長為例)：* \
//     #v(1em)
//     #align(center)[
//       #grid(
//         columns: (auto, 30pt, auto, 30pt, auto, 30pt, auto, 30pt, auto),
//         rows: (30pt, 30pt, 30pt),
//         gutter: 0pt,
//         align: center + horizon,
//         [*6*], [], [*3*], [], [*1*], [], [...], [], [*數值 $a$*],
//         "↓", [], "↑", "↘", "↑", "↘", [], [], [],
//         [*5*], "→", [*4*], [], [*2*], [], [...], [], [*數值 $b$*]
//       )
//     ]
//     #v(1em)
//
//     *邏輯推導（以 `{6, 5, 4, 3, 2, 1}` 為例）：*
//     #set enum(indent: 1em)
//     1. 排序後得 `{6, 5, 4, 3, 2, 1}`。
//     2. 初始分配：$a = 6, b = 5$。
//     3. 加入 4：因為 $5 < 6$，故 $arrow.r b = 54$。
//     4. 加入 3：因為 $6 < 54$，故 $arrow.r a = 63$。
//     5. 加入 2：因為 $54 < 63$，故 $arrow.r b = 542$。
//     6. 加入 1：因為 $63 < 542$，故 $arrow.r a = 631$。
//
//     #v(1em)
//     *最終計算：*
//     #align(center)[
//       $ 631 times 542 = bold(342002) $
//     ]
//   ],
//   "小四數學.cpp",
//   references: (
//     "https://puzzling.stackexchange.com/questions/46521/maximum-result-with-digits",
//     "https://zerojudge.tw/ShowProblem?problemid=a825",
//   )
// )
//
// #exam_item(
//   "UVa 10019 - Funny Encryption Method",
//   [
//     給定正整數 $N$，計算兩個位元數值：
//     - $b_1$：十進制轉二進制後 1 的個數。
//     - $b_2$：十六進制轉二進制後 1 的個數。
//   ],
//   [
//     本題重點在於 $b_2$：將輸入的數字字面上視為十六進制。例如輸入 265 就看作 $265_((16))$，而非先轉成十六進制。
//   ],
//   [
//     *舉例說明*： \
//     若 $N = 265$：
//     - $b_1$：$265_((10)) = 100001001_2$（共 *3* 個 1）。
//     - $b_2$：將 2, 6, 5 拆開分別轉二進制： \
//       $ 2 arrow 0010, 6 arrow 0110, 5 arrow 0101 $ \
//       總計 $1+2+2 = 5$ 個 1。
//   ],
//   "UVa 10019 - Funny Encryption Method.cpp",
//   references: (
//     "https://zerojudge.tw/ShowProblem?problemid=e545",
//     "https://vjudge.net/problem/UVA-10019"
//   )
// )
//
// #exam_item(
//   "UVa 674 - Coin Change",
//   [
//     給定五種面額的硬幣（1, 5, 10, 25, 50），求湊出金額 $N$ 的所有組合數。
//   ],
//   [
//     本題屬於經典的「組合找零」問題。我們定義 $d p[j]$ 為組成金額 $j$ 的方法數。為了節省空間，我們使用一維陣列進行迭代更新：
//
//     1. *狀態轉移邏輯*：
//        對於每一種面額 $c_i$，我們更新所有的金額 $j$ ($j >= c_i$)：
//        $ d p[j]^("new") = d p[j]^("old") + d p[j - c_i]^("new") $
//
//        - $d p[j]^("old")$：不使用面額 $c_i$ 時，組成金額 $j$ 的方法數。
//        - $d p[j - c_i]^("new")$：使用面額 $c_i$ 後，剩餘金額 $j - c_i$ 的方法數。
//
//     2. *避免重複計算*：
//        由於我們是「逐一加入硬幣種類」而非逐一填充金額，這確保了我們計算的是*組合 (Combination)* 而非排列 (Permutation)。
//
//     3. *邊界條件*：
//        $ d p[0] = 1 $
//   ],
//   [
//     *動態規劃填表過程 (以金額 0-26 為例)*： \
//     #v(0.5em)
//     #align(center)[
//       #table(
//         columns: (1fr, 1.2fr, 1.2fr, 1.2fr, 1.2fr, 1.2fr),
//         inset: 6pt,
//         align: center + horizon,
//         stroke: 0.5pt + luma(200),
//         fill: (x, y) => if y == 0 { rgb("#ffeef2") },
//         [*金額*], [*初始*], [*+1元*], [*+5元*], [*+10元*], [*+25元*],
//         [#text(fill: rgb("#d63384"))[*0*]], [1], [1], [1], [1], [1],
//         [#text(fill: rgb("#d63384"))[*5*]], [0], [1], [2], [2], [2],
//         [#text(fill: rgb("#d63384"))[*10*]], [0], [1], [3], [4], [4],
//         [#text(fill: rgb("#d63384"))[*25*]], [0], [1], [6], [12], [13],
//         [#text(fill: rgb("#d63384"))[*26*]], [0], [1], [6], [12], [#text(fill: rgb("#d63384"), weight: "bold")[13]],
//       )
//     ]
//     #v(0.5em)
//     *註：表格展現了當硬幣種類逐一加入時，各個金額方法數的演變過程。*
//   ],
//   "UVa 674 - Coin Change.cpp",
//   references: (
//     "https://zerojudge.tw/ShowProblem?problemid=d253",
//     "https://vjudge.net/problem/UVA-674"
//   )
// )
//
// #exam_item(
//   "UVa 10407 - Simple division",
//   [
//     給定一組整數數列 ${n_1, n_2, dots, n_k}$，求一個最大的正整數 $d$，使得數列中所有數字除以 $d$ 後的餘數皆相同。
//   ],
//   [
//     這是一題關於 *同餘性質* 的題目。若 $a$ 與 $b$ 除以 $d$ 的餘數相同，則：
//     $ a equiv b thin (mod d) arrow.r.double (a - b) equiv 0 thin (mod d) $
//     這代表 $d$ 必須是 $(a - b)$ 的因數。
//
//     1. *解題策略*：
//        - 假設餘數為 $r$，則每個數可以表示為 $n_i = q_i times d + r$。
//        - 觀察相鄰兩項的差：$n_(i+1) - n_i = (q_(i+1) - q_i) times d$。
//        - 由此可知，$d$ 必定是所有差值 $(n_(i+1) - n_i)$ 的公因數。
//        - 為了求出最大的 $d$，我們對所有相鄰項的差值取 *最大公因數 ("GCD")*。
//
//     2. *實作要點*：
//        - 持續讀入整數直到遇到 $0$ 結束該筆測試資料。
//        - 計算數列中每兩個相鄰數字的差值，並取絕對值 $|n_i - n_(i-1)|$。
//        - 使用#highlight[輾轉相除法]對所有差值求 "GCD"，所得結果即為最大可能的 $d$。
//   ],
//   [
//     *推導範例*： \
//     輸入數列：`701, 1059, 1417, 2312, 0`
//     - 計算相鄰項差值：
//       - $|1059 - 701| = 358$
//       - $|1417 - 1059| = 358$
//       - $|2312 - 1417| = 895$
//     - 求最大公因數：$gcd(358, 358, 895) = bold(179)$
//
//     *驗算 (餘數皆需相同)*：
//     - $701 = 3 times 179 + 164$
//     - $1059 = 5 times 179 + 164$
//     - $1417 = 7 times 179 + 164$
//     - $2312 = 12 times 179 + 164$
//     (餘數皆為 $164$，故最大正整數 $d = 179$)
//   ],
//   "UVa 10407 - Simple division.cpp",
//   references: (
//     "https://zerojudge.tw/ShowProblem?problemid=e565",
//     "https://vjudge.net/problem/UVA-10407"
//   )
// )

// = 詳細知識點說明 <EXPLAIN>
// #text(fill: navy)[=== 輸入]
