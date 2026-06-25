//##############################
// 0. 全域設定
//##############################

#set page(
  paper: "a4",
  margin: 0.5cm,
)

// 關鍵：將段落間距與行距全部設為 0
#set par(leading: 0pt, spacing: 0pt)
#set block(spacing: 0pt)

//##############################
// 1. 實際內容
//##############################

// 標題（如果還想要的話，不想要就刪掉）
#align(center)[
  #text(size: 20pt, weight: "bold")[C++ ch9 指定作業]
  #v(1em)
]

// 這裡直接列出圖片，不要包在任何 block 或 figure 裡面
// 因為預設情況下，每張圖片會被視為一個獨立段落，
// 我們剛才已經把段落間距 (spacing) 設為 0 了。

#image("q9-9_prob.jpg", width: 100%)
#image("q9-14_prob.jpg", width: 100%)
#image("q9-17_prob.jpg", width: 100%)
#image("q9-18_prob.jpg", width: 100%)
