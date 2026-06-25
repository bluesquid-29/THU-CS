// ==========================================
// 0. 全域設定 (Page & Text Settings)
// ==========================================
// 0.0 import
#import "@preview/treet:1.0.0": *
#import "@preview/tdtr:0.5.5" : *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *
#show: codly-init.with()

#codly(languages: codly-languages)
#codly(
  number-format: n => text(gray.darken(20%))[#n],
  zebra-fill: luma(250),
)

// 0.1 頁面
#set page(
  paper: "a4",
  margin: (top: 0.8cm, bottom: 1.6cm, left: 0.5cm, right: 0.5cm),
  footer: context [
    #set align(center)
    #set text(size: 9pt, fill: gray)
    第 #counter(page).display() 頁 / 共 #counter(page).final().at(0) 頁
  ],
)
#set raw(tab-size: 4)

// 修正後的嵌入頁面
#page(paper: "a4", margin: 0pt)[
  // 1. 用 place 讓 90% 大小的 PDF 完美在畫布正中央居中
  #place(center + horizon)[
    #image("10003.pdf", page: 1, width: 100%, height: 100%)
  ]
  
  // 2. 如果你希望這一頁的頁尾「稍微往上飄一點」，不要貼死在最底邊，可以這樣加：
  #place(bottom + center, dy: -1.2cm)[
    #context [
      #set text(size: 9pt, fill: gray)
      第 #counter(page).display() 頁 / 共 #counter(page).final().at(0) 頁
    ]
  ]
]

// #codly(
//   display-name: true,  // 顯示語言名稱/圖示
// //   display-icons: true, // 顯示圖示
// )

// // 3. 測試 C++ 程式碼區塊
// ```cpp
// #include <iostream>

// int main() {
//     std::cout << "Hello, Typst!" << std::endl;
//     return 0;
// }
// ```

// #import "@preview/algorithmic:1.0.7"
// #import algorithmic: style-algorithm, algorithm-figure
// #show: style-algorithm
// #algorithm-figure(
//   "Binary Search",
//   vstroke: .5pt + luma(200),
//   {
//     import algorithmic: *
//     Procedure(
//       "Binary-Search",
//       ("A", "n", "v"),
//       {
//         Comment[Initialize the search range]
//         Assign[$l$][$1$]
//         Assign[$r$][$n$]
//         LineBreak
//         While(
//           $l <= r$,
//           {
//             Assign([mid], FnInline[floor][$(l + r) / 2$])
//             IfElseChain(
//               $A ["mid"] < v$,
//               {
//                 Assign[$l$][$"mid" + 1$]
//               },
//               [$A ["mid"] > v$],
//               {
//                 Assign[$r$][$"mid" - 1$]
//               },
//               Return[mid],
//             )
//           },
//         )
//         Return[*null*]
//       },
//     )
//   }
// )
// 
// 
#import "@preview/algorithmic:1.0.7"
#import algorithmic: style-algorithm, algorithm-figure
#show: style-algorithm

#grid(
  columns: (0.78fr, 1fr),
  gutter: 5pt,
  [
    #algorithm-figure(
      "Rod Cutting (recursion)",
      vstroke: .5pt + luma(200),
      {
        import algorithmic: *
        Procedure(
          "Solve",
          ("l", "r"),
          {
            Comment[#text(fill: purple)[Case 1: no cuts can be made in between]]
            If(
              $r - l <= 1$,
              {
                Return[$0$]
              }
            )
            LineBreak
            
            Comment[#text(fill: purple)[State transition]]
            Assign[$"least"$][$oo$]
            Assign[$"length"$][$"cuts"[r] - "cuts"[l]$]
            LineBreak
            
            For(
              $k in [l + 1, r - 1]$,
              {
                Assign[$"cost"$][$"length" + text("Solve")(l, k) + text("Solve")(k, r)$]
                Assign[$"least"$][$min("least", "cost")$]
              }
            )
            LineBreak
            

            Return[$"least"$]
          },
        )
      }
    )

  ],
  [
    #raw(
      read("Rod Cutting (resursion).cpp"), 
      lang: "cpp", 
      block: true
    )
  ],
)




#algorithm-figure(
  "Rod Cutting DP (Memoization)",
  vstroke: .5pt + luma(200),
  {
    import algorithmic: *
    Procedure(
      "Solve",
      ("l", "r"),
      {
        Comment[#text(fill: purple)[Base case: no cuts can be made in between]]
        If(
          $r - l <= 1$,
          {
            Return[$0$]
          }
        )
        LineBreak
        
        Comment[Memoization check]
        If(
          $"memo"[l][r] != -1$,
          {
            Return[$"memo"[l][r]$]
          }
        )
        LineBreak
        
        Comment[State transition]
        Assign[$"least"$][$oo$]
        Assign[$"segment_length"$][$"cuts"[r] - "cuts"[l]$]
        LineBreak
        
        For(
          $k <- l + 1 " to " r - 1$,
          {
            Assign[$"cost"$][$"segment_length" + text("Solve")(l, k) + text("Solve")(k, r)$]
            Assign[$"least"$][$min("least", "cost")$]
          }
        )
        LineBreak
        
        Comment[Save to memo and return]
        Assign[$"memo"[l][r]$][$"least"$]
        Return[$"least"$]
      },
    )
  }
)

#tidy-tree-graph(compact: true)[
  - $integral_0^infinity e^(-x) dif x = 1$
    - `int main() { return 0; }`
      - Hello
        - This
        - Continue
        - Hello World
      - This
    - _literally_
      - Like
    - *day*
      - tomorrow $1$
]

#tidy-tree-graph(compact: true)[
      - Solve(0, 5) \ #text(size: 0.8em, fill: gray)[(len: 10)]
        - #text(fill: rgb("#1d4ed8"))[*Solve(0, 1)*] \ #text(size: 0.8em, fill: rgb("#1d4ed8"))[(Base Case)]
          - Solve(1, 5) \ #text(size: 0.8em, fill: gray)[(len: 6)]
        - Solve(0, 2) \ #text(size: 0.8em, fill: gray)[(len: 5)]
          - #box(fill: rgb("#fee2e2"), inset: 3pt, radius: 2pt)[#text(fill: rgb("#b91c1c"))[*Solve(2, 5)*]] \ #text(size: 0.8em, fill: rgb("#b91c1c"))[(Duplicate)]
        - Solve(0, 3) \ #text(size: 0.8em, fill: gray)[(len: 7)]
          - Solve(3, 5) \ #text(size: 0.8em, fill: gray)[(len: 3)]
        - Solve(0, 4) \ #text(size: 0.8em, fill: gray)[(len: 8)]
          - #text(fill: rgb("#1d4ed8"))[*Solve(4, 5)*] \ #text(size: 0.8em, fill: rgb("#1d4ed8"))[(Base Case)]
    ]

     #tree-list(
        marker: text(blue)[├── ],
        last-marker: text(blue)[└── ],
        indent: text(gray.lighten(30%))[│#h(1.2em)],
        empty-indent: h(1.8em),
        marker-font: "DejaVu Sans Mono",
      )[
        - *Solve(0, 5)* #text(fill: gray, size: 0.9em)[[長度: 10]]
          - *Solve(0, 1)* #text(fill: teal, size: 0.9em)[(Base Case: 0)]
          - *Solve(1, 5)* #text(fill: gray, size: 0.9em)[[長度: 6]]
            - *Solve(1, 2)* #text(fill: teal, size: 0.9em)[(Base Case: 0)]
            - #box(fill: rgb("#fee2e2"), inset: (x: 4pt, y: 2pt), radius: 2pt)[*Solve(2, 5)*] #text(fill: red, size: 0.9em)[(重複子問題)]
              - *Solve(2, 3)* #text(fill: teal, size: 0.9em)[(Base Case: 0)]
              - #box(fill: rgb("#fee2e2"), inset: (x: 4pt, y: 2pt), radius: 2pt)[*Solve(3, 5)*] #text(fill: red, size: 0.9em)[(重複子問題)]
          - *Solve(0, 2)* #text(fill: gray, size: 0.9em)[[長度: 5]]
            - *Solve(0, 1)* #text(fill: teal, size: 0.9em)[(Base Case: 0)]
            - *Solve(1, 2)* #text(fill: teal, size: 0.9em)[(Base Case: 0)]
          - #box(fill: rgb("#fee2e2"), inset: (x: 4pt, y: 2pt), radius: 2pt)[*Solve(2, 5)*] #text(fill: red, size: 0.9em)[(重複子問題)]
            - *Solve(2, 3)* #text(fill: teal, size: 0.9em)[(Base Case: 0)]
            - #box(fill: rgb("#fee2e2"), inset: (x: 4pt, y: 2pt), radius: 2pt)[*Solve(3, 5)*] #text(fill: red, size: 0.9em)[(重複子問題)]
          - *Solve(0, 3)* #text(fill: gray, size: 0.9em)[[長度: 7]]
            - *Solve(0, 1)* #text(fill: teal, size: 0.9em)[(Base Case: 0)]
            - #box(fill: rgb("#fee2e2"), inset: (x: 4pt, y: 2pt), radius: 2pt)[*Solve(3, 5)*] #text(fill: red, size: 0.9em)[(重複子問題)]
      ]

#text(red, tree-list(
  marker: text(blue)[├── ],
  last-marker: text(aqua)[└── ],
  indent: text(teal)[│#h(1.5em)],
  empty-indent: h(2em),
)[
  - 1
    - 1.1
      - 1.1.1
    - 1.2
      - 1.2.1
      - 1.2.2
        - 1.2.2.1
  - 2
  - 3
    - 3.1
      - 3.1.1
    - 3.2
])
