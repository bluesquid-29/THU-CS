// --- 基礎頁面設定 ---
#set page(paper: "a4", margin: 1in)
#set text(size: 11pt)

// --- 自定義：角色標籤與樣式 (修正高度且移除冒號) ---
#let role(name, color) = box(
  fill: color.lighten(80%),
  inset: (x: 4pt, y: 3pt),     // 增加高度，解決 box 太矮的問題
  radius: 2pt,
  stroke: color + 0.5pt,
  baseline: 20%,               // 修正垂直對齊偏移
  text(fill: color.darken(20%), weight: "bold", size: 0.9em, name)
)

// --- 模擬 #exam_item 的結構 (配音專案版) ---
#let script_item(time, content) = block(
  width: 100%,
  stroke: (left: 2pt + gray),
  inset: (left: 10pt, y: 8pt),
  [
    #text(weight: "bold", fill: blue.darken(30%))[#time] \
    #content
  ]
)

= Voiceover Script: The Shawshank Redemption
*Group Members: Andy, James, Roy*


// 角色分配表
#table(
  columns: (1fr, 2fr),
  inset: 10pt,
  align: horizon,
  [*Member*], [*Roles Assigned*],
  [Andy], [#role("Red", blue) Ellis Boyd Redding / #role("Head Bull", blue) Haig],
  [James], [#role("Red(Narrative)", orange) / #role("Captain", orange) Byron Hadley],
  [Roy], [#role("Warden", gray) Samuel Norton],
)

// 劇本本文

#script_item("0:24 ~ 1:04")[
  #role("Head Bull", blue) Man missing on Tier 2 Cell 245. \
  #role("Captain", orange) Dufresne. \
  #role("Head Bull", blue) Get your ass out here, boy. You're holding up the show. \
  #role("Head Bull", blue) Don't make me come down there. I'll thump your skull for you. \
  #role("Head Bull", blue) Damn it, Dufresne, you're putting me behind! I got a schedule to keep. You'd better be sick or dead in there, I shit you not! You hear me?\
  #role("Head Bull", blue) Oh my holy God.
]

#script_item("1:20 ~ 1:30")[
  #role("Warden", gray) I want every man on this block questioned. \
  #role("Warden", gray) Start with that friend of his. \
  #role("Captain", orange) Who? \
  #role("Warden", gray) Him! \
  #role("Captain", orange) Open 237 (two three seven).
]

#script_item("1:33 ~ 2:19")[
  #role("Warden", gray) What do you mean, he just wasn't here? Don't say that to me, Haig. Don't say that to me again. \
  #role("Head Bull", blue) But, sir, he wasn't. \
  #role("Warden", gray) I can see that, Haig! You think I'm blind? Is that what your're saying? Am I blind, Haig? \
  #role("Head Bull", blue) No, sir. \
  #role("Warden", gray) What about you? Are you blind? Tell me what this is. \
  #role("Captain", orange) Last night's count. \
  #role("Warden", gray) (Mm-hmm) You see Dufresne's name there? I sure do. See? Right here. Dufresne. \
  #role("Warden", gray) He was in his cell at lights out. It stands to reason he'd still be here in the morning. \
  #role("Warden", gray) I want him found. Not tomorrow, not after breakfast. Now! \
  #role("Head Bull", blue) Yes, sir! \
  #role("Head Bull", blue) Let's go, let's go! Move your butts! Move it!
]

#script_item("2:22 ~ 3:22")[
  #role("Captain", orange) Stand. \
  #role("Warden", gray) Well? \
  #role("Red", blue) Well, what? \
  #role("Warden", gray) I see you two all the time. You're thick as thieves, you are. \
  #role("Warden", gray) He must have said something. \
  #role("Red", blue) No, sir, Warden. Not a word. \
  #role("Warden", gray) Lord, it's a miracle! \
  #role("Warden", gray) A man up and vanished like a fart in the wind. Nothing left but... some damn rocks on a windowsill. And that cupcake on the wall. Let's ask her. Maybe she knows. What say there, Fuzzy Britches? Feel like talking? Ah.. I guess not. Why should she be any different? This is a conspiracy. That's what this is. One big... damn conspiracy! And everyone's in on it! Including her!
]

#script_item("3:54 ~ 4:25")[
  #role("Red(Narrative)", orange) In 1966, Andy Dufresne escaped from Shawshank Prison. \
  #role("Red(Narrative)", orange) All they found of him was a muddy set of prison clothes, a bar soap, and an old rock hammer damn near worn down to the nub. \
  #role("Red(Narrative)", orange) I remember thinking it would take a man 600 years to tunnel the wall with it. \
  #role("Red(Narrative)", orange) Only Andy did it in less than 20. \
]

// --- 程式碼行號渲染規範 (it.lines 規則) ---
#show raw.where(block: true): it => {
  block(fill: rgb("#f8f9fa"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(200), width: 100%, {
    let lines = it.lines
    grid(
      columns: (2.5em, 1fr),
      column-gutter: 0.8em,
      row-gutter: 0.5em,
      ..lines.enumerate().map(((i, line)) => (
        align(right, text(fill: gray.darken(20%), size: 0.8em, font: "DejaVu Sans Mono")[#(i + 1)]),
        line
      )).flatten()
    )
  })
}

