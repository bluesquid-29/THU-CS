//##############################
// 0. 全域設定
//##############################

#set page(
  paper: "a4",
  margin: 0.5cm,
  flipped: true // 橫向排版
)

#set text(font: ("Noto Serif", "Noto Sans CJK TC"), size: 11pt, lang: "zh")

// 設定程式碼 Tab 與 字體大小
#set raw(tab-size: 4)
#show raw: set text(size: 13pt)

// 目錄樣式設定
#show outline.entry: it => {
  v(0.5em)
  it
}

//##############################
// 1. 實際內容
//##############################

#align(center)[
  #text(size: 22pt, weight: "bold")[260330 C++ 作業] \
  #text(size: 16pt, weight: "regular")[Ch9 Pointer]
]

// 插入目錄
#v(1em)
#outline(title: [目錄], indent: 2em)
#v(2em)
#let question(title, q_img, result_img, code_file) = {
  // 每題強制換頁
//   pagebreak(weak: true)

  v(0.5em)
  heading(level: 2, title) // 使用函數式的寫法在 Script 模式中更穩定
  v(1em)

  // 1. 先放程式碼區塊 (13pt)
  block(
    fill: rgb("#f8f9fa"),
    inset: 15pt,
    radius: 4pt,
    stroke: 0.5pt + gray,
    width: 100%,
    breakable: true,
    raw(read(code_file), lang: "cpp")
  )

  v(2em)

  // 2. 再放圖片（題目與結果）
  align(center)[
    #figure(
      image(q_img, width: 100%),
//       caption: [題目內容]
    )
    #v(2em)
    #figure(
      image(result_img, width: 70%),
//       caption: [執行結果]
    )
  ]
}

// --- 填寫內容 ---

#question(
  "Question 9",
  "q9-9_prob.jpg",
  "q9-9.png",
  "q9-9.cpp"
)

#question(
  "Question 14",
  "q9-14_prob.jpg",
  "q9-14.png",
  "q9-14.cpp"
)

#question(
  "Question 17",
  "q9-17_prob.jpg",
  "q9-17.png",
  "q9-17.cpp"
)

#question(
  "Question 18",
  "q9-18_prob.jpg",
  "q9-18.png",
  "q9-18.cpp"
)
