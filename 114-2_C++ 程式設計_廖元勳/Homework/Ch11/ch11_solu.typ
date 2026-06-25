//##############################
// 0. 全域設定
//##############################

#set page(
  paper: "a4",
  margin: 0.5cm,
  flipped: true // 橫向排版
)

#set text(font: ("Noto Serif", "Noto Sans CJK TC"), size: 12pt, lang: "zh")

// 設定程式碼 Tab 與 字體大小
#set raw(tab-size: 4)
#show raw: set text(size: 12pt)

// 目錄樣式設定
#show outline.entry: it => {
  v(0.5em)
  it
}

//##############################
// 1. 實際內容
//##############################

#align(center)[
  #text(size: 22pt, weight: "bold")[260420 C++ 作業] \
  #text(size: 16pt, weight: "regular")[Ch11 結構與其它資料型態]
]

// 插入目錄
#v(1em)
#outline(title: [目錄], indent: 2em)
#v(2em)

#let question(title, result_img, code_file) = {
//   每題強制換頁
//   pagebreak(weak: true)

  v(0.5em)
  heading(level: 2, title) // 使用函數式的寫法在 Script 模式中更穩定
  v(1em)

  // 2. 再放圖片（題目與結果）
  align(center)[
    #figure(
      image(result_img, width: 75%),
    )
  ]

  show raw.where(block: true): it => {
    block(
      fill: rgb("#f8f9fa"),
      inset: 12pt,
      radius: 4pt,
      stroke: 0.5pt + luma(200),
      width: 100%,
      {
        let lines = it.lines
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
      }
    )
  }
  raw(read(code_file), lang: "cpp", block: true)
}



// --- 填寫內容 ---
#heading(level: 2, [其他文章])
在 `union` 裡面，所有成員都共享相同的內存，所以設置一個成員會影響所有成員。這可以用來節省內存，但這意味著你一次只能使用其中一個成員，並且使用一個會使其他成員失效。總的來說，這不太理想，並且可能導致各種各樣的錯誤。

#rect(
  fill: rgb("#f0f0f0"),
  inset: 10pt,
  radius: 4pt,
  stroke: none,
  raw("union {\n  int a;\n  int b;\n}", lang: "c")
)

如果我更改 `a`，`b` 也會更改。

我們早就過了需要數內存的年代，所以現在的 `unions` 通常保留用於處理一些非常具體的低級數據打包問題。總的來說，除非你真的知道你需要使用它們，否則不要使用它們。

#link("https://reddit.com")[#text(fill: blue)[Reddit: C - Is it better to use struct or union? When should I use which?]]



#question(
  "Question 2",
  "Q11-2.png",
  "Q11-2.cpp"
)

#question(
  "Question 7",
  "Q11-7.png",
  "Q11-7.cpp"
)

#question(
  "Question 9",
  "Q11-9.png",
  "Q11-9.cpp"
)

