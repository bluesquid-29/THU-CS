#import "@preview/mannot:0.3.3": markhl
#import "@local/codly:1.3.1": *
#import "@preview/codly-languages:0.1.10": *
  #codly(
    languages: codly-languages,
    number-format: n => text(gray.darken(20%))[#n],
    zebra-fill: luma(250),
    display-name: true,  // 顯示語言名稱/圖示
  )
  #show: codly-init.with()
#import "mytool.typ": *
  #show: code-style
// ==========================================
// 0. 全域設定 (Page & Text Settings)
// ==========================================
// 0.1 頁面
#let current-chapter = state("current-chapter", "1")
#set page(
  paper: "a4",
  margin: (top: 0.8cm, bottom: 1.2cm, left: 0.8cm, right: 0.8cm),
  flipped: true,
  
  footer: context {
    set align(center)
    set text(size: 9pt, fill: gray)
    
    // 從智慧狀態中取出當前使用者指定的章節代號（可能是 "6" 或 "A"）
    let ch-name = current-chapter.at(here())
    let page-num = counter(page).at(here()).at(0)
    
    [第 #ch-name - #page-num 頁]
  }
)
#let new-chapter(name) = {
  current-chapter.update(name)
  counter(page).update(1)
}

// 0.2 排版
#set par(
  first-line-indent: (amount: 2em /* , all: true */),
  justify: true, 
  leading: 0.5em,
)
#set list(
  indent: 1em,      // Push the bullet symbol inward by 1em
  // body-indent: 0.5em // Space between symbol and text
)

// 0.3 字體（相關）
#set text(
  tracking: 0.2pt,
  // font: ("Libertinus Serif", "LXGW Neo XiHei"),
  font: ("Noto Serif", "Noto Sans CJK TC"),
  size: 12pt,
  lang: "zh",
  region: "tw",
)

// 0.4 標題
// #set heading(
//   numbering: "1.A.",
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
#show heading.where(level: 2): set text(size: 20pt)
#show heading.where(level: 3): set text(size: 16pt)

// 0.5 目錄
#show outline.entry: it => {
  block(below: 0.75em)[
    #set text(weight: if it.level == 1 { "bold" } else { "regular" })
    #it
  ]
}





// ==========================================
// 1. 報告表頭 (右上角資訊 + 置中標題)
// ==========================================
// 1.1 組別資訊
#place(top + right)[
  #box(width: 11.5em)[
    #set text(size: 11.5pt)
    #grid(
      columns: (auto, auto),
      column-gutter: 0.6em,
      row-gutter: 0.7em,
      align: left + horizon,

      [*日期*],
      [#underline(offset: 2pt)[#datetime(
        year: 2026,
        month: 6,
        day: 12,
      ).display()]],

      [*組員*], [#underline(offset: 2pt)[S14350338 許竣崴]],
      [], [#underline(offset: 2pt)[S14350344 周嘉心]],
      [*組別*], [#underline(offset: 2pt)[資工 1C 第 15 組]],
    )
  ]
]
#v(2.5em)

// 1.2 標題
#align(center)[
  #move(dx: -2.5cm)[
    #text(size: 22pt, weight: "bold", fill: navy)[實驗六：時脈產生器與移位暫存器]
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





// ==========================================
// 2. 做題章節
// ==========================================
#new-chapter("10027")
#include "10027/10027.typ"
#pagebreak()

#new-chapter("242")
#include "242/242.typ"
#pagebreak()

#new-chapter("501")
#include "501/501.typ"
#pagebreak()
