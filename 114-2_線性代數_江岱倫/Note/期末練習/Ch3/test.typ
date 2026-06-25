// 綜合優化版快顯通知方塊（新增自訂背景色功能）
#let alert(
  type: "note",       // note, tip, important, warning, caution, theorem, green, red, gold, lightgray
  title: auto,        // auto: 依類型顯示預設標籤; none: 隱藏標題橫列; "自訂文字": 顯示自訂標題
  fill: auto,         // auto: 使用類型的預設淡化色; 亦可傳入自訂顏色（如：rgb("#f2f2f2")）
  body
) = {
  // 整合所有顏色、圖示與預設標籤配置
  let conf = (
    note:       (color: rgb("#0969da"), icon: "ℹ️", label: "NOTE"),
    tip:        (color: rgb("#1a7f37"), icon: "💡", label: "TIP"),
    important:  (color: rgb("#8250df"), icon: "💬", label: "IMPORTANT"),
    warning:    (color: rgb("#9a6700"), icon: "⚠️", label: "WARNING"),
    caution:    (color: rgb("#cf222e"), icon: "🛑", label: "CAUTION"),
    theorem:    (color: rgb("#1a7f37"), icon: "",   label: "THEOREM"),
    green:      (color: rgb("#10b981"), icon: "✅", label: "SUCCESS"),
    red:        (color: rgb("#ef4444"), icon: "❌", label: "ERROR"),
    gold:       (color: rgb("#f59e0b"), icon: "⭐", label: "ATTENTION"),
    lightgray:  (color: rgb("#676e7b"), icon: "📝", label: "INFO"),
  )

  // 取得當前配置，若找不到 type 則預設為藍色 (note)
  let current = conf.at(type, default: conf.note)
  let color = current.color

  // 判斷背景顏色：若 fill 為 auto 則使用原本的淡化色，否則使用使用者傳入的顏色
  let bg-color = if fill == auto { color.lighten(93%) } else { fill }

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
        #v(6pt) // 有標題時才留間距
      ]
      
      // 內容區塊
      #text(fill: rgb("#24292f"))[#body] 
    ]
  )
}

// === 使用範例展示 ===

// 1. 使用自訂指定的灰底背景色（不給標題）
#alert(type: "note", title: none, fill: rgb("#f2f2f2"))[
  這是一個指定使用灰色背景（`#f2f2f2`）且沒有標題的通知區塊。
]

// 2. 使用預設自動生成的淡化背景色
#alert(type: "important")[
  這是一個使用預設自動計算淡化色（紫色底）並帶有預設標題的區塊。
]

// 3. 自訂背景色＋自訂標題
#alert(type: "tip", title: "自訂組合", fill: rgb("#fff9e6"))[
  綠色的邊框與圖示，搭配自訂的淡黃色背景（`#fff9e6`）。
]

#let vect(name) = $arrow(#h(1.4pt) name #h(1.4pt))$

$ vect(u) = arrow(u) $

$ vect(V) != arrow(V) $

$ vect(A B) approx arrow(A B)$