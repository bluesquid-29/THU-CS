// #import "@preview/codly:1.3.0": *
#import "@local/codly:1.3.1": *
#import "@preview/codly-languages:0.1.10": *
  #show: codly-init.with()
#import "@preview/tablem:0.3.0": tablem, three-line-table
#import "@preview/algorithmic:1.0.7"
  #import algorithmic: style-algorithm, algorithm-figure, algorithm
  #show: style-algorithm



#set page(
  paper: "a4",
  margin: (top: 0.8cm, bottom: 1.2cm, left: 0.8cm, right: 0.8cm),
  flipped: true, 
)
#set text(
  tracking: 0.2pt,
  // font: ("Libertinus Serif", "LXGW Neo XiHei"),
  font: ("Noto Serif", "Noto Sans CJK TC"),
  size: 12pt,
  lang: "zh",
  region: "tw",
)




#codly(number-format: none)
==  #text(red)[501] #h(0.25cm) #text(blue)[Black Box] #text(size: 12pt)[(easy)]
#table(
  columns: (1fr, 1fr),       
  column-gutter: 0em,        
  stroke: none,              
  align: top + left,         
  [
    #set par(first-line-indent: (amount: 2em, all: true ),)
    Our Black Box represents a primitive database. It can save an integer array and has a special $i$ variable. At the initial moment Black Box is empty and $i$ equals 0. This Black Box processes a sequence of commands (transactions). There are two types of transactions:

    - *ADD(x)*: put element $x$ into Black Box;
    - *GET*: increase $i$ by 1 and give an $i$-minimum out of all integers containing in the Black Box.
        
    Keep in mind that $i$-minimum is a number located at $i$-th place after Black Box elements sorting by non-descending.    
  ],
  table.vline(x: 1, stroke: gray),
  [
    #set par(first-line-indent: (amount: 2em, all: true ),)
    我們的 Black Box（黑盒子）代表一個原始的資料庫。它可以儲存一個整數陣列，並且包含一個特殊的變數 $i$ 。在初始狀態下，Black Box 是空的，且 $i$ 等於 0。這個 Black Box 會處理一系列的指令（交易）。共有兩種指令類型：#v(1.2em)

    - *ADD(x)*：將元素 $x$ 放進 Black Box 中。
    - *GET*：將 $i$ 的值加 1，並輸出當前 Black Box 內所有整數中，第 $i$ 小的數值。

    請注意，所謂的「第 $i$ 小的數值（$i$-minimum）」，是指將 Black Box 中的所有元素依非遞減（由小到大）順序排序後。    
  ]
)



==== #text(red)[Example]
#table(
  columns: (1fr, 1fr),       
  column-gutter: 0em,        
  stroke: none,              
  align: top + left,         
  [
    Let us examine a possible sequence of 11 transactions:

    #three-line-table[
      | *N* | *Transaction* | *i* | *Black Box contents after tran-saction* (elements are arranged by non-descending) | *Answer* |
      | :-- | :------------ | :-- | :--------------------------------------------------------------------------------- | :------- |
      | 1   | ADD(3)        | 0   | 3                                                                                  |          |
      | 2   | GET           | 1   | *3*                                                                                  | 3        |
      | 3   | ADD(1)        | 1   | 1, 3                                                                               |          |
      | 4   | GET           | 2   | 1, *3*                                                                               | 3        |
      | 5   | ADD(-4)       | 2   | -4, 1, 3                                                                           |          |
      | 6   | ADD(2)        | 2   | -4, 1, 2, 3                                                                        |          |
      | 7   | ADD(8)        | 2   | -4, 1, 2, 3, 8                                                                     |          |
      | 8   | ADD(-1000)    | 2   | -1000, -4, 1, 2, 3, 8                                                              |          |
      | 9   | GET           | 3   | -1000, -4, *1*, 2, 3, 8                                                              | 1        |
      | 10  | GET           | 4   | -1000, -4, 1, *2*, 3, 8                                                              | 2        |
      | 11  | ADD(2)        | 4   | -1000, -4, 1, 2, 2, 3, 8                                                           |          |
    ]

    #set par(first-line-indent: (amount: 2em, all: true ),)
    It is required to work out an efficient algorithm which treats a given sequence of transactions. The maximum number of ADD and GET transactions: 30000 of each type.

    Let us describe the sequence of transactions by two integer arrays:

    1. $A(1), A(2), ..., A(M)$: a sequence of elements which are being included into Black Box. $A$ values are integers not exceeding 2 000 000 000 by their absolute value, $M <= 30000$. For the Example we have $A = (3, 1, -4, 2, 8, -1000, 2)$.

    2. $u(1), u(2), ..., u(N)$: a sequence setting a number of elements which are being included into Black Box at the moment of first, second, and $N$-transaction GET. For the Example we have $u = (1, 2, 6, 6)$.
        
    The Black Box algorithm supposes that natural number sequence $u(1), u(2), ..., u(N)$ is sorted in non-descending order, $N <= M$ and for each $p$ ($1 <= p <= N$) an inequality $p <= u(p) <= M$ is valid. It follows from the fact that for the $p$-element of our $u$ sequence we perform a GET transaction giving $p$-minimum number from our $A(1), A(2), ..., A(u(p))$ sequence.
  ],
  table.vline(x: 1, stroke: gray),
  [
    讓我們來觀察一個包含 11 個指令的可能序列：

    #three-line-table[
      | *步驟 (N)* | *指令*       | *i 的值* | *執行指令後的 Black Box 內容* \ (元素已由小到大排序) | *輸出答案* |
      | :-------- | :---------- | :------ | :----------------------------------- | :------ |
      | 1   | ADD(3)        | 0   | 3                                                                                  |          |
      | 2   | GET           | 1   | *3*                                                                                  | 3        |
      | 3   | ADD(1)        | 1   | 1, 3                                                                               |          |
      | 4   | GET           | 2   | 1, *3*                                                                               | 3        |
      | 5   | ADD(-4)       | 2   | -4, 1, 3                                                                           |          |
      | 6   | ADD(2)        | 2   | -4, 1, 2, 3                                                                        |          |
      | 7   | ADD(8)        | 2   | -4, 1, 2, 3, 8                                                                     |          |
      | 8   | ADD(-1000)    | 2   | -1000, -4, 1, 2, 3, 8                                                              |          |
      | 9   | GET           | 3   | -1000, -4, *1*, 2, 3, 8                                                              | 1        |
      | 10  | GET           | 4   | -1000, -4, 1, *2*, 3, 8                                                              | 2        |
      | 11  | ADD(2)        | 4   | -1000, -4, 1, 2, 2, 3, 8                                                           |          |
    ]

    #set par(first-line-indent: (amount: 2em, all: true ),)
    本題要求設計一個高效的演算法來處理給定的指令序列。ADD 和 GET 指令的最大數量分別可達 30000 個。#v(1.2em)

    我們可以用兩個整數陣列來描述這一連串的指令：#v(1.2em)

    1. $A(1), A(2), ..., A(M)$：依序要被加入 Black Box 的元素序列。$A$ 中的數值皆為整數，其絕對值不超過 2,000,000,000，且 $M <= 30000$。以範例來說， $A = (3, 1, -4, 2, 8, -1000, 2)$。#v(1.2em)

    2. $u(1), u(2), ..., u(N)$：這個序列設定了在進行第 1 次、第 2 次 ... 直到第 $N$ 次 GET 指令時，Black Box 內「已經包含」了多少個來自陣列 $A$ 的元素。以範例來說， $u = (1, 2, 6, 6)$。#v(1.2em)
        
    Black Box 演算法假設正整數序列 $u(1), u(2), ..., u(N)$ 已按非遞減順序排序，且 $N <= M$，對於每個 $p$（$1 <= p <= N$），皆滿足不等式 $p <= u(p) <= M$。這是因為當我們處理序列 $u$ 中的第 $p$ 個元素時，我們會執行一次 GET 指令，並從目前的序列 $A(1), A(2), ..., A(u(p))$ 當中，找出第 $p$ 小的數字。
  ]
)



==== #text(red)[Input]
#table(
  columns: (1fr, 1fr),       
  column-gutter: 0em,        
  stroke: none,              
  align: top + left,         
  [
    The first line of the input is an integer $K$, then a blank line followed by $K$ datasets. There is a blank line between datasets.

    Input for each dataset contains (in given order): $M$, $N$, $A(1), A(2), ..., A(M)$, $u(1), u(2), ..., u(N)$. All numbers are divided by spaces and (or) carriage return characters.    
  ],
  table.vline(x: 1, stroke: gray),
  [
    輸入的第一行包含一個整數 $K$，代表測資的筆數。接著是一個空行，隨後是 $K$ 組資料集。每組資料集之間會有一個空行隔開。

    每組資料集的輸入內容依序為：$M$、$N$、$A(1), A(2), ..., A(M)$、$u(1), u(2), ..., u(N)$。所有數字均以空格及（或）換行符號分隔。    
  ]
)



==== #text(red)[Output]
#table(
  columns: (1fr, 1fr),       
  column-gutter: 0em,        
  stroke: none,              
  align: top + left,         
  [
    For each dataset, write to the output Black Box answers sequence for a given sequence of transactions. Write only a number per line in the output.

    Print a blank line between datasets.
  ],
  table.vline(x: 1, stroke: gray),
  [
    對於每筆測資，請輸出 Black Box 針對給定指令序列所產生的答案序列。每行只輸出一個數字。#v(1.2em)

    每組資料集的輸出之間請列印一個空行。    
  ]
)



#table(
  columns: (1fr, 1fr),       
  column-gutter: 0em,        
  stroke: none,              
  align: top + left,         
  [
    ==== #text(red)[Sample Input]
    ```
    1

    7 4
    3 1 -4 2 8 -1000 2
    1 2 6 6
    ```
    
  ],
  table.vline(x: 1, stroke: gray),
  [
    ==== #text(red)[Sample Output]
    ```
    3
    3
    1
    2
    ```
  ]
)
#line(length: 100%, stroke: 1pt + gray)
#pagebreak()

#codly(number-format: n => text(gray.darken(20%))[#n],)
#set par(first-line-indent: (amount: 0em,))

== Solution
=== 1. 按照題意模擬 (brute force)
#grid(
  columns: (3fr, 5fr), // Two equal columns
  gutter: 1em,         // Space between the tables
  [
    右圖是釐清 I/O 的手寫筆記。

    假設：
    - 空黑箱是 `box[] = {}`
    - 題目給的特殊變數 $i$
    - a 是 `box[]` 的 index
    #algorithm-figure(
      "黑箱模擬（按照題意）",
      vstroke: .5pt + luma(200),
      {
        import algorithmic: *
        Procedure(
          "Solve",
          (),
          {
            // 1. 初始化資料
            Assign[$"box"$][${}$]
            Assign[$a$][$1$]
            Assign[$i$][$0$]
            
            // 2. 依序處理 N 次 GET 操作
            For(
              $n in [1, N]$,
              {
                // ADD 操作：補滿元素到滿足 u[r] 為止
                While(
                  $"size"("box") < u[n]$,
                  {
                    // 將 A[a_idx] 推入黑盒子
                    Assign[$"box"$][$"box" + A[a]$]
                    Assign[$a$][$a + 1$]
                  }
                )
                
                // GET 操作：i 變數加 1 並排序
                Assign[$i$][$i + 1$]
                Assign[$"box"$][$"Sort"("box")$]
                // 輸出當前第 i 小的元素
                Return[$"box"[i]$]
              }
            )
          }
        )
      }
    )
  ],
  [
    #image("explain.png", width: 100%)
  ]
)



#grid(
  columns: (1fr, 2fr),
  gutter: 1em,
  [
    ==== 分析時間複雜度：
        
    每次 *GET* 操作都要跑一次 `Sort()` 。黑盒子最多有 M 個元素，排序一次要 $O(M log M)$。總共跑 N 次 *GET*，所以總時間是 $O(N dot M log M)$ 。實際檢測時，會 #text(fill: rgb("#B6B62E"))[TLE]。

    此程式碼的優點是方便理解題目。  
  ],
  [
    ==== 關鍵程式碼
    ```cpp
    vector<int> box;   // 我們的黑盒子
    int a = 0;         // 目前加到 A 陣列的第幾個元素
    int i = 0;         // 題目的 i 變數，記錄這是第幾次 GET

    // 依序處理 N 次 GET 操作
    for (int n = 0; n < N; n++) 
    {
        while (box.size() < u[n])     // 1. ADD 操作：把元素加到符合 u[n] 指定的數量為止
        {
            box.push_back(A[a]);
            a++;
        }
        i++;                          // 2. GET 操作：i 變數加 1
        sort(box.begin(), box.end()); // 3. 暴力排序：直接對目前的黑盒子進行由小到大排序
        cout << box[i - 1] << "\n";   // 4. Output 第 i 小的元素（索引從 0 開始，所以是 i－1）
    }	
    ```  
  ]
)




==== Code image
#image("codeimage1.png", width: 80%)

=== 2. 按照題意模擬 (brute force)
