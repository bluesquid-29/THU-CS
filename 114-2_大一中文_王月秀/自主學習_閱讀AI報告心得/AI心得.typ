// ==========================================
// 0. 全域設定 (Page & Text Settings)
// ==========================================
// 0.1 頁面
#set page(
  paper: "a4",
  margin: (top: 0.8cm, bottom: 1.2cm, left: 0.8cm, right: 0.8cm),
  footer: context [
    #set align(center)
    #set text(size: 9pt, fill: gray)
    第 #counter(page).display() 頁 / 共 #counter(page).final().at(0) 頁
  ],
)

// 0.2 字體
#set text(
  font: ("Noto Serif", "Noto Sans CJK TC"),
  size: 12pt,
  lang: "zh",
)

// 0.3 標題
// #set heading(
  // numbering: "1.A.",
// )
#show heading: it => {
  if it.level == 1 {
    v(0.25em) // 第一層上方間距較大
    it
    v(0.25em) // 第一層下方間距
  } else {
    v(0.1em) // 第二層以上間距較小
    it
    v(0.1em)
  }
}

// 0.4 目錄
#show outline.entry: it => {
  v(0.5em)
  it
}

// 0.5 quote
#set quote(block: true)
#show quote.where(block: true): it => rect(
  fill: rgb("f0f4f8"),  
  stroke: none,
  radius: 4pt,  // Rounded corners
  width: 100%,
  inset: 1em,
  it
)





// ==========================================
// 1. 報告表頭 (右上角資訊 + 置中標題)
// ==========================================
// 1.1 組別資訊
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
        [許竣崴],
        [*授課老師：*],
        [王月秀],
        [*撰寫日期：*],
        [#underline(offset: 2pt)[#datetime(
          year: 2026,
          month: 6,
          day: 14,
        ).display()]],

      )
    ]
  ]
]
#v(2.5em)

// 1.2 標題
#align(center)[
  #move(dx: -2.5cm)[
    #text(size: 22pt, weight: "bold", fill: navy)[三份AI優良作業心得]
  ]
  #v(0.5em)
  #line(length: 100%, stroke: 1.5pt + navy)
]

// 1.3 自動目錄 + 灰線
#outline(title: [目錄], indent: 1.5em)
#v(1em)
#line(length: 100%, stroke: 1pt + gray)
#v(1em)
#pagebreak()





= S14330105 廖柏妍
== 「理性製圖，感性編織」
#quote()[
  我的專業養成開始於對灑輯與效率的追求，如AutoCAD工程圖學的精確製圖與Flowgorithm的程式邏輯建構都是我大一上學期的專業課程。
]
妙了，我的資工系目前還沒聽過 Flowgorithm ，今天又認識新軟體了。

#quote[
  我的長期愛好鉤針編繡，正是我修煉耐心與結構感的實際經驗。鉤織毛線與繪製工程圖在本質上有著特別的相似：每一針的交織與每一條線的標註，都容不下絲毫偏差。
]
這個口號很難想像它的關聯，但是我認為的共同點都是需要細心。






= S14310209 曾筠珊
她準備了報告擋，標題頁的中國山水風很震撼（這是她選擇的照片，然後 AI 依照此風格更正）。注意小細節：每一頁左上角都有「東海」的印章。

== 製作歷程與心得反思
#quote[
...我看那個進度條快嚇死了，還好只用到了 98%，順利地做完了\~
]
如果要計費的話，那 AI 就會罷工。

#quote[
  這是我第一次成功製作出屬於我自己的網站，而且是按照我自己所喜歡的風格來呈現，當做完的頁面完完整整的出現在我面前，我整個人成就感直接爆棚...
]
AI 的藝術天份，絕對超乎普通人想像。


#v(1em)
#line(length: 100%, stroke: 2pt + black)
#v(1em)
= S14310209 林家均
她準備了 html， 與報告擋。兩者的排版都樸實無華，第一印象十分舒服。以下討論她的每個報告部份：

== (a) 完整頁面及個別區塊說明
用表格簡明扼要的說明如何閱讀此 html。值得學習與模仿：

- 導覽列
- Hero 區
- 關於我
- 能力與特質
- 工作經歷
- 未來規劃
- 工具與語言
- 興趣愛好
- 金句區
- 聯絡方式

== (b) 製作歷程報告
看得出來她很認真想要建立個人品牌。求職時很注重自己的行銷能力。她凸顯了自己很熱衷於化學材料科系，尤其計畫大二就進入實驗室。


== (e) 製作心得反思
#quote[
  AI 工具的應用能力，在未來可能比很多傳統技能更重要。
]
AI 大幅加速入門的時間，且能讓使用者快速看到成果。

#quote[
  AI 問了很多我平常不會主動思考的問題：英文程度如何？有沒有具體計畫？未來想往哪裡走?
]
這是很重要的訣竅，先叫 AI 詢問多則問題，才能讓它精確生成使用者的需求。 