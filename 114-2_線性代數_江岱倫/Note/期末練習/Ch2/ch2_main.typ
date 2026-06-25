#import "@preview/mannot:0.3.3": markhl
#import "mytool.typ": *

// ==========================================
// 0. 全域設定 (Page & Text Settings)
// ==========================================
// 0.1 頁面
#set page(
  paper: "a4",
  margin: (top: 0.8cm, bottom: 0.8cm, left: 0.8cm, right: 0.8cm),
  footer: context [
    #set align(center)
    #set text(size: 9pt, fill: gray)
    第 #counter(page).display() 頁 / 共 #counter(page).final().at(0) 頁
  ],
)
#set text(font: ("Noto Serif", "Noto Sans CJK TC"), lang: "zh", size: 11pt)


#show outline.entry: it => {
  v(0.5em)
  it
}

#callout(type: "def", title: "轉置矩陣 transpose matrix", fill: "default")[
  #let blue-diagonal = (paint: rgb("268bd2"), thickness: 1.2pt, dash: (4pt, 3pt))
  給定一個 $m times n$ 階的矩陣 $A$，其轉置矩陣會被記為 $A^(t)$，這是一個 $n times m$ 階的矩陣。若以元素表示，原矩陣的元素 $a_(i j)$ 在轉置矩陣 $A^(t)$ 中會對應到 $a_(j i)$ 的位置。

  $A =$
  #context {
    let m = $mat(delim: "[", 1, markhl(2), markhl(3); 4, 5, markhl(6)) $
    let size = measure(m)
    
    // 決定線要從邊界往外延伸多少（你可以自由改這個值，數值越大線越長）
    let pad = 4pt 
    
    box(m + place(top + left, 
      // 透過 dx, dy 決定線從「左上角」外面多少距離開始畫
      dx: 5pt - pad, 
      dy: -2pt - pad, 
      line(
        start: (0pt, 0pt), 
        // 終點：寬度與高度各自加上兩倍的 pad，這樣兩端延伸的長度會完全對稱平衡
        end: (size.width - 20pt + (pad * 2), size.height + 4pt + (pad * 2)), 
        stroke: blue-diagonal
      )
    ))
  }
  $quad arrow.r.long.double quad A^t = $
  #context {
    let m = $mat(delim: "[", 1, 4; markhl(2), 5; markhl(3), markhl(6);)$
    let size = measure(m)
    
    // 決定線要從邊界往外延伸多少（你可以自由改這個值，數值越大線越長）
    let pad = 4pt 
    
    box(m + place(top + left, 
      // 透過 dx, dy 決定線從「左上角」外面多少距離開始畫
      dx: 5pt - pad, 
      dy: -2pt - pad, 
      line(
        start: (0pt, 0pt), 
        // 終點：寬度與高度各自加上兩倍的 pad，這樣兩端延伸的長度會完全對稱平衡
        end: (size.width - 0pt + (pad * 2), size.height + 4pt + (pad * 2)), 
        stroke: blue-diagonal
      )
    ))
  }
  #callout(type: "def", title: "對稱矩陣 symmetric matrix", fill: "default")[
    對稱矩陣是一個等於自身轉置的*方陣*。$A = A^T$ 。即對所有索引 $i, j$，滿足：$a_(i j) = a_(j i)$

    *例子：*

    $display(mat(delim: "[", 1, 2, 3; 2, 5, 4; 3, 4, 6))$
    主對角線（main diagonal）兩側的元素互為鏡像。  
  ]
]

#callout(type: "theorem", title: "Theorem 2.4 轉置矩陣性質", fill: "default")[
  + $(A + B)^t = A^t + B^t$
  + $(c A)^t = c A^t$
  + $(A B)^t = B^t A ^ t$
  + $(A^t)^t = A$ 
]


#callout(type: "def", title: "合成轉換 Composition of Transformations", fill: "default")[
  #image("composition_transformation.png", width: 90%)
]