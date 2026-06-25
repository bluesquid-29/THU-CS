#let vect(name) = $arrow(#h(1.4pt) name #h(1.4pt))$
#let callout(
  type: "note",       // note, tip, important, warning, caution, theorem, green, red, gold, lightgray
  title: auto,        // auto: 依類型顯示預設標籤; none: 隱藏標題橫列; "自訂文字": 顯示自訂標題
  fill: "default",    // auto: 使用類型的預設淡化色; 亦可傳入自訂顏色（如：rgb("#f2f2f2")）
  body
) = {
  // 整合所有顏色、圖示與預設標籤配置
  let conf = (
    note:       (color: rgb("#0969da"), icon: "ℹ️", label: "NOTE"),
    tip:        (color: rgb("#1a7f37"), icon: "💡", label: "TIP"),
    important:  (color: rgb("#8250df"), icon: "💬", label: "IMPORTANT"),
    warning:    (color: rgb("#9a6700"), icon: "⚠️", label: "WARNING"),
    caution:    (color: rgb("#cf222e"), icon: "🛑", label: "CAUTION"),
    green:      (color: rgb("#10b981"), icon: "✅", label: "SUCCESS"),
    red:        (color: rgb("#ef4444"), icon: "❌", label: "ERROR"),
    gold:       (color: rgb("#f59e0b"), icon: "⭐", label: "ATTENTION"),
    lightgray:  (color: rgb("#676e7b"), icon: "📝", label: "INFO"),

    theorem:    (color: rgb("#e07000"), icon: "",   label: "THEOREM"),
    def:        (color: rgb("#006080"), icon: "",   label: "Definition"),
    remark:     (color: rgb("#700070"), icon: "",   label: "Remark"),
    example:    (color: rgb("#008000"), icon: "",   label: "Example"),
  )

  // 取得當前配置，若找不到 type 則預設為藍色 (note)
  let current = conf.at(type, default: conf.note)
  let color = current.color

  // 判斷背景顏色：若 fill 為 auto 則使用原本的淡化色，否則使用使用者傳入的顏色
  let bg-color = if fill == auto {
    color.lighten(93%)
  } else if fill == "default" {
    rgb("#f2f2f2")
  } else {
    fill
  }

  block(
    fill: bg-color,
    stroke: (left: 4.5pt + color),
    inset: (x: 12pt, y: 10pt),
    width: 100%,
    radius: (right: 3pt),
    spacing: 12pt,
    [
      // 判斷是否需要渲染標題列
      #if title != none [
        #let display-title = if title == auto { current.label } else { title }
        #text(fill: color, weight: "bold", size: 0.95em)[
          #if current.icon != "" [ #current.icon #h(4pt) ]
          #display-title
        ]
        #v(0pt) // 有標題時才留間距
      ]

      // 內容區塊
      #text(fill: rgb("#24292f"))[#body]
    ]
  )
}

#show raw.where(block: false): it => {
  box(
    fill: luma(245),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,         // 圓角
    text(fill: rgb("#000000"), it)
  )
}
