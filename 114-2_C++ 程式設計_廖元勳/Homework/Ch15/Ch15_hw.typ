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
         else if type == "lightgray"  { rgb("#dfe2e5") }
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
  block(
    fill: rgb("#f8f9fa"),
    inset: 12pt,
    radius: 4pt,
    stroke: 0.5pt + luma(200),
    width: 100%,
    {
      set text(size: 0.85em, font: "DejaVu Sans Mono")
      let lines = it.lines // 使用屬性存取而非方法
      grid(
        columns: (2.2em, 1fr),
        column-gutter: 0.8em,
        row-gutter: 0.6em,
        ..lines.enumerate().map(((i, line)) => (
          align(right, text(fill: gray.darken(20%), size: 1em, font: "DejaVu Sans Mono")[#(i + 1)]),
          line
        )).flatten()
      )
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
  #text(size: 22pt, weight: "bold")[26/05/11 Ch15作業——運算子的多載 operator overloading] \
  #text(size: 16pt, weight: "regular")[Problem 15-8, 11]
]

#v(1em)
#outline(title: [目錄], indent: 2em)
#v(2em)



// ╔══════════════════════════════════════════╗
// ║ 1. 核心函數定義
// ╚══════════════════════════════════════════╝
#let exam_item(title, desc, analysis, examples, code_description, code_file, references: ()) = {
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
  example_box(code_description, type: "lightgray")

  // 判斷 code_file 的類型
  if type(code_file) == str {
    // 情況 A: 單一檔案讀取
    raw(read(code_file), lang: "cpp", block: true)
  } else if type(code_file) == array {
    // 情況 B: 複數檔案並排 (符合規範第 5 點 Grid 思路)
    grid(
      columns: (1fr, 1fr),
      column-gutter: 4pt,
      ..code_file.map(f => {
        stack(
          dir: ttb,
          spacing: 0.5em,
          text(size: 0.8em, fill: gray, weight: "bold")[#f], // 顯示檔名
          raw(read(f), lang: "cpp", block: true)
        )
      })
    )
  }
}


// ╔══════════════════════════════════════════╗
// ║ 2. 實際內容填寫區
// ╚══════════════════════════════════════════╝
#exam_item(
  "8. 「>」運算子的多載 ",
  [
    #grid(
      columns: (auto, auto),
      gutter: 1em,
      [
        請仿照 Ch15_2 ，撰寫 operator<() 的三個多載函數。請參考下面的執行結果：
        ```
        win1 is larger than win2
        win1 is smaller than 7000
        win2 is larger than 4500
        ```
      ],
      [
        #figure(
          image("Ch15-2_(範例).png", width: 100%),
        )
      ]
    )
  ],
  [
    請翻閱 Ch15 PPT ，你會發現 Ch15_3 的程式碼就是這題的做法。
    #figure(
      image("Ch15-3_(範例).png", width: 100%),
    )
  ],
  [
    #figure(
      image("hw15-8_(terminal).png", width: 55%),
    )
  ],
  [

  ],
  ("hw15-8.cpp"),
)



#exam_item(
  "11. 運算子「=」的多載",
  [
    請依序完成下列題目的需求。
    #example_box(type: "gold")[
      + 建立座標類別 coord ，成員包含座標 x 和 y ，另有一個 show() 函數可將座標列印在螢幕上。
      + 撰寫 coord() 建構子，預設的座標是 (0, 0) ，並於 main() 宣告 c0(1, 1)、c1(2, 2)、c2、c3。
      + 請多載「+」、「-」與「=」運算子，使得 `c2 = c0 + c1` ，`c3 = c0 - c1`。
    ]

    請參考下面的執行結果：
    ```
    c0=(1,1)
    c1=(2,2)
    c0+c1=(3,3)
    c0-c1=(-1,-1)
    ```
  ],
  [
    照題意模擬即可，習慣它的語法糖。
  ],
  [
    #figure(
      image("hw15-11_(terminal).png", width: 55%),
    )
  ],
  [
    - (c) 這些方法都是可行的，不過個人偏好：回傳匿名物件。
    - 「`const` 修飾它左邊的東西」；如果左邊沒有東西，才修飾右邊。
  ],
  ("hw15-11.cpp"),
)

// #exam_item(
//   "2. 很多人的薪水",
//   [
//     延續上例，使用 `new` 運算子動態配置 Employee 員工物件陣列，並讓使用者自己指定員工人數，接著再逐一輸入每一位員工的姓名與薪資，最後再印出所輸入的所有員工資料。
//   ],
//   [
//     `new` 宣告：
//     ```cpp
//     Employee *A = new Employee[n];
//     ```
//   ],
//   [
//     #figure(
//       image("12_2-(terminal).png", width: 75%),
//     )
//   ],
//   "12_2.cpp",
// )
//
// #exam_item(
//   "3. 查詢薪水",
//   [
//     延續上例，再製作搜尋員工姓名的功能。先讓使用者輸入要搜尋員工的姓名，接著會由員工物件陣列去尋找所符合的資料並顯示出來。
//   ],
//   [
//
//   ],
//   [
//     #figure(
//       image("12_3-(terminal).png", width: 75%),
//     )
//   ],
//   "12_3.cpp",
// )
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

// #exam_item(
//   "10a.",
//   [
//     #figure(
//       image("13-10a_problem.jpg", width: 75%),
//     )
//   ],
//   [
//     照題意模擬即可。
//   ],
//   [
//     #figure(
//       image("13-10a_terminal.png", width: 75%),
//     )
//   ],
//   "13-10a_homework.cpp",
// )
//
//
//
// #exam_item(
//   "10b.",
//   [
//     #figure(
//       image("13-10b_problem.jpg", width: 75%),
//     )
//   ],
//   [
//     友誼函數：可在 class 外部，實作函數內容，不需加上 `friend` 或 `::` 作用域運算子。
//     ```cpp
//     friend void set_data(CCar& car, string i, int q, int p);
//     ```
//     在程式碼中，`set_data` 是外部函數，但因為在 `CCar` 內被宣告為 `friend` 因此：
//     - 直接存取： 它可以直接寫 `car.id` 或 `car.price`，不必透過公有介面。
//     - 傳址呼叫： 使用 `CCar& car`（引用）來直接修改傳入的那台車，而不是修改副本。
//   ],
//   [
//     同10a 結果
//     #figure(
//       image("13-10a_terminal.png", width: 75%),
//     )
//   ],
//   "13-10b_homework.cpp",
// )
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

// #pagebreak()
// = A 傳值、指標、參照
// 想像你有一本#strong[筆記本]（這就是#strong[物件/變數]）。
//
// #line(length: 100%, stroke: gray.lighten(50%))
// #v(1.5em)
//
//
//
// == A1. 傳值 (Pass by Value) ------ 「影印給對方」
// <傳值-pass-by-value-影印給對方>
// 函數收到的是一份#strong[副本]，怎麼改都不影響原本。
//
// - #strong[缺點]：物件很大時，影印很花時間與記憶體。
//
// #line(length: 100%, stroke: gray.lighten(50%))
// #v(1.5em)
//
//
//
// == A2. 指標 (Pointer) ------ 「給對方地址」
// <指標-pointer-給對方地址>
// 你給對方一張#strong[紙條]，上面寫著筆記本的存放位置。
//
// - #strong[`&`]（取址）：取得紙條上的地址
// - #strong[`*`]（解參考）：拿著地址，找到本人
//
// ```cpp
// int a = 5;
// int* p = &a;  // p 存的是 a 的地址
// *p = 10;      // 解參考，直接改 a 本人
// ```
//
// `->` 只是 struct/class 的語法糖，等價於
// `(*ptr).member`，跟「找到本人」這個動作本身無關。
//
// - #strong[危險性]：地址可以是空的（`nullptr`），存取前最好檢查。
//
// #line(length: 100%, stroke: gray.lighten(50%))
// #v(1.5em)
//
//
//
// == A3. 參照 (Reference) ------ 「取個綽號」
// <參照-reference-取個綽號>
// 直接幫筆記本取另一個名字，#strong[它就是本人]，不是副本也不是地址。
//
// ```cpp
// int a = 5;
// int& r = a;  // r 就是 a，同一個東西
// r = 10;      // a 也變成 10
// ```
//
// - #strong[安全性]：宣告時就必須綁定，不能為空，不能改指向別人。
//
// #line(length: 100%, stroke: gray.lighten(50%))
// #v(1.5em)
//
//
//
// == A4. `&` 的雙重身分（最常搞混的點）
// <的雙重身分最常搞混的點>
// ```cpp
// int a = 5;
// int* p = &a;  // 取址運算子：取得 a 的地址
// int& r = a;   // 參照宣告符：r 是 a 的別名
// ```
//
// 同一個符號，位置不同，意思完全不同。
//
// #line(length: 100%, stroke: gray.lighten(50%))
// #v(1.5em)
//
//
//
// == A5. 總結
// <總結>
// #figure(
//   align(center)[#table(
//     columns: 5,
//     align: (left,left,center,center,center,),
//     table.header([概念], [你手上拿著什麼], [能改本人？], [效能], [可為空？],),
//     table.hline(),
//     [#strong[傳值]], [副本], [❌], [慢], [---],
//     [#strong[指標]], [地址], [✅], [快], [✅（危險）],
//     [#strong[參照]], [別名], [✅], [快], [❌（安全）],
//   )]
//   , kind: table
//   )
//
// === 那為什麼還需要參照？
// <那為什麼還需要參照>
// 指標能做的參照大多也能做，但：
//
// + #strong[語法乾淨]：用 `.` 就好，不用滿版 `*`
// + #strong[保證有效]：不能為空、不能懸空
// + #strong[支援鏈式呼叫]：回傳參照等於把「本人的控制權」直接傳下去，中間沒有任何複製
//
// #v(1.5em)
// #line(length: 100%)
// #v(1.5em)
//
//
//
// = B. 關鍵字 this
// 在 C++ 的物件導向程式設計中，`this` 是一個非常核心的概念。我們可以從它的「身分」以及加上 `*`（星號）之後的「行為」來拆解：
//
// == B1. `this` 是什麼？（它是「地址」）
// <this-是什麼它是地址>
// 當你在類別（Class）的成員函數內部時，`this`
// 是一個#strong[隱含的指標]。它儲存了#strong[目前正在執行這個函數的物件]在記憶體中的#strong[地址]。
//
// - #strong[比喻]：如果你是一間房子的「管家」（成員函數），`this`
//   就是你手上拿著的這間房子的「門牌地址」。
// - #strong[特性]：
//   - 它永遠指向「自己」。
//   - 它的型別是 `CSale*`（指向該類別的指標）。
//
// == B2. `*this` 是什麼？（它是「本人」）
// <this-是什麼它是本人>
// 當你在 `this` 前面加上
// `*`（解引用運算子，Dereference），意思就是：#strong[「順著這個地址進去，找到那個物件本人」]。
//
// - #strong[比喻]：這就像是你順著門牌地址推門進去，看到的不再是地址紙條，而是#strong[房子建築物本身]。
// - #strong[在程式中的意義]：
//   - 它的型別是 `CSale`（物件本身）。
//   - 當你的函數回傳型別是 #strong[參照（`CSale&`）] 時，你必須回傳
//     `*this`，代表「我把這個物件本人（而非地址）傳回去給呼叫者」。
//
// #line(length: 100%, stroke: gray.lighten(50%))
// #v(1.5em)
//
// == B3. 為什麼要用 `*this`？
// <為什麼要用-this>
// 我們用你的 `few()` 函數來做圖解對比：
//
// === 如果你回傳 `this` (沒加星號)
// <如果你回傳-this-沒加星號>
// 這會發生編譯錯誤。因為你的函數承諾要回傳一個「物件參照（本尊）」，但你卻丟出了一個「指標（地圖）」。這就像是快遞員說要送貨物（物件）給你，結果只給了你一張寫著倉庫地址的紙條（指標）。
//
// === 如果你回傳 `*this` (有加星號)
// <如果你回傳-this-有加星號>
// 這完全符合要求。你告訴程式：「請把#strong[我現在所在的這個物件]直接傳回去」。
//
// ```cpp
// CSale& few(CSale& other)
// {
//     if ((*this).sale < other.sale)
//     {
//         return *this; // 「我」比「你」小，所以傳回「我本人」
//     }
//     else
//     {
//         return other; // 「你」比「我」小，所以傳回「你本人」
//     }
// }
// ```
//
//
//
// #line(length: 100%, stroke: gray.lighten(50%))
// #v(1.5em)
//
//
//
// == B4. 總結
// <總結>
// - #strong[`this`]：地址（指標），用來找路。存取成員時用 `this->ID`。
// - #strong[`*this`]：物件（本尊），用來當作傳回值，代表物件自己。
//
// 這就是為什麼在你的 Problem 9c 中，為了滿足「傳回參照」的要求，必須寫成
// `return *this;` 的原因。
//
// #v(1.5em)
// #line(length: 100%)
// #v(1.5em)
//
//
//
// = C. Function with Pointer and Reference
// 以下用一個簡單的「更換姓名」範例，讓你一眼看出指標（Pointer）與引用（Reference）在語法上的差別：
//
// == C1. 使用指標 Pointer (\* 與 &)
// <使用指標-pointer-與>
// 這是傳統 C 語言風格，呼叫時必須明確「取址」，函數內必須明確「解引用」。
//
// ```cpp
// struct User {
//     string name;
// };
// // 參數用 * 接收地址void changeName(User* u) {
//     u->name = "Alice"; // 使用 -> 存取成員
// }
// int main() {
//     User person = {"Bob"};
//     // 呼叫時必須加 & 取得地址
//     changeName(&person);
// }
// ```
//
// == C2. 使用引用 Reference (&)
// <使用引用-reference>
// 這是 C++ 特有的語法，看起來像傳入一般變數，但實際上操作的是同一個物件。
//
// ```cpp
// struct User {
//     string name;
// };
// // 參數用 & 宣告為引用void changeName(User& u) {
//     u.name = "Alice";  // 使用 . 存取成員，像操作一般變數
// }
// int main() {
//     User person = {"Bob"};
//     // 呼叫時直接傳入物件，不需加符號
//     changeName(person);
// }
// ```
//
// == C3 快速對照表
// <快速對照表>
// #figure(
//   align(center)[#table(
//     columns: 3,
//     align: (auto,auto,auto,),
//     table.header([特性], [指標 Pointer (\*)], [引用 Reference (&)],),
//     table.hline(),
//     [定義方式], [User\* u], [User& u],
//     [呼叫方式], [func(&person) (需取址)], [func(person) (直接傳)],
//     [內部操作], [u-\>name (需解引用)], [u.name (直接用)],
//     [空值安全性], [可以是 nullptr (需檢查)], [不能為空 (較安全)],
//     [直觀程度], [像在操作「地址」], [像在操作「本體」的別名],
//   )]
//   , kind: table
//   )
//
// 📍 建議：在 C++
// 中，如果不需要處理「空值（NULL）」或「更換指向對象」，優先使用引用
// (&)，程式碼會更乾淨且安全。
