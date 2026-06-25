#set page(
  paper: "a4",
  margin: (top: 0.8cm, bottom: 0.8cm, left: 0.8cm, right: 0.8cm),
  footer: context [
    #set align(center)
    #set text(size: 9pt, fill: gray)
    第 #counter(page).display() 頁 / 共 #counter(page).final().at(0) 頁
  ],
)

// 目錄樣式設定
#show outline.entry: it => {
  v(1.0em)
  it
}

#outline(title: "題解目錄", indent: 1em)
#v(1em)

#let exam_item(question, body) = {
  block(width: 100%, inset: 10pt, [
    #question \
    #v(0.5em)
    #body
  ])
}

#exam_item(
  [#heading(level: 1, numbering: none)[*1a.* $integral_0^1 1 / x^(1/3) dif x$]],
  [
    #grid(
      columns: (1fr),
      stroke: 0.5pt + black,
      inset: 10pt,
      fill: (x, y) => if y == 0 or y == 2 { rgb("#E1F5FE") },
      [ 定積分化簡 ],
      [ #v(10em) ],
      [ 瑕積分定義 ],
      [ #v(10em) ]
    )
  ]
)

#v(1em)
#line(length: 100%, stroke: 0.5pt + gray)
#v(1em)

#pagebreak()
#exam_item(
  [#heading(level: 1, numbering: none)[*1b.* $integral_(-infinity)^(infinity) (2x) / (x^2 + 4)^(1/3) dif x$]],
  [
    #grid(
      columns: (1fr),
      stroke: 0.5pt + black,
      inset: 10pt,
      fill: (x, y) => if y == 0 or y == 2 { rgb("#E1F5FE") },
      [ 定積分化簡 ],
      [ #v(10em) ],
      [ 瑕積分定義 ],
      [ #v(10em) ]
    )
  ]
)

#v(1em)
#line(length: 100%, stroke: 0.5pt + gray)
#v(1em)

#exam_item(
  [#heading(level: 1, numbering: none)[*2.* 找級數 $sum_(n=1)^infinity ln (n+1) / n$ 的 $n$ 項部分和式子並依此求級數和。]],
  [
    #grid(
      columns: (1fr),
      stroke: 0.5pt + black,
      inset: 10pt,
      fill: (x, y) => if y == 0 { rgb("#E1F5FE") },
      [ 部分和 $S_n$ 與極限 ],
      [ #v(12em) ] // 留白供手寫
    )
  ]
)

#v(1em)
#line(length: 100%, stroke: 0.5pt + gray)
#v(1em)

#pagebreak()
#exam_item(
  [#heading(level: 1, numbering: none)[*3.* $sum_(n=1)^infinity ( (1 - 3/n)^(n^2) e^n ) / (3n^3)$ 試判級數收斂或發散。]],
  [
    #grid(
      columns: (1fr),
      stroke: 0.5pt + black,
      inset: 10pt,
      fill: (x, y) => if y == 0 { rgb("#E1F5FE") },
      [ (Root Test / Ratio Test) ],
      [ #v(15em) ] // 留白供手寫
    )

    #v(1em)
    *Python 程式碼驗證 (SymPy)*
    #show raw.where(block: true): it => {
      block(
        fill: rgb("#f8f9fa"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(200), width: 100%,
        {
          let lines = it.lines
          grid(
            columns: (2.5em, 1fr), column-gutter: 0.8em, row-gutter: 0.5em,
            ..lines.enumerate().map(((i, line)) => (
              align(right, text(fill: gray.darken(20%), size: 0.9em, font: "DejaVu Sans Mono")[#(i + 1)]),
              align(left, line)
            )).flatten()
          )
        }
      )
    }

    ```python
    import sympy

    n = sympy.symbols('n', integer=True, positive=True)
    a_n = ((1 - 3/n)**(n**2) * sympy.exp(n)) / (3 * n**3)

    # 使用 Root Test 進行極限判斷
    root_limit = sympy.limit(a_n**(1/n), n, sympy.oo)

    print(f"Root Test Limit: {root_limit}")
    if root_limit < 1:
        print("Convergent")
    else:
        print("Divergent or Inconclusive")
    ```
  ]
)

#v(1em)
#line(length: 100%, stroke: 0.5pt + gray)
#v(1em)

// 題目 4
#exam_item(
  [#heading(level: 1, numbering: none)[*4.* $integral tan^2 x sec^3 x dif x$]],
  [
    #set align(center)
    $ &integral tan^2 x sec^3 x dif x \
    =& integral (sec^2 x - 1) sec^3 x dif x \
    =& integral (sec^5 x - sec^3 x) dif x \
    =& integral sec^5 x dif x - integral sec^3 x dif x quad #text(fill: blue, "分開討論 ①, ②") $

    #v(0.5em)

    #grid(
      columns: (1fr, 1fr),
      stroke: 0.5pt + black,
      inset: 8pt,
      fill: (x, y) => if y == 0 { rgb("#E1F5FE") },
      align: horizon + center,
      [$ integral sec^3 x dif x $], [$ integral sec^5 x dif x $],
      align(left)[
        $
        I_3 &= integral sec^3 x dif x \
        &= sec x tan x - integral sec x tan^2 x dif x \
        &= sec x tan x - integral sec x (sec^2 x - 1) dif x \
        &= sec x tan x - I_3 + integral sec x dif x \
        2 I_3 &= sec x tan x + ln |sec x + tan x| \
        I_3 &= 1/2 (sec x tan x + ln |sec x + tan x|)
        $
      ],
      align(left)[
        $
        I_5 &= integral sec^5 x dif x \
        &= sec^3 x tan x - integral tan x dot 3 sec^2 x (sec x tan x) dif x \
        &= sec^3 x tan x - 3 integral sec^3 x (sec^2 x - 1) dif x \
        &= sec^3 x tan x - 3 I_5 + 3 I_3 \
        4 I_5 &= sec^3 x tan x + 3 I_3 \
        I_5 &= 1/4 sec^3 x tan x + 3/4 I_3
        $
      ]
    )

    #v(0.5em)

    $ =& (1/4 sec^3 x tan x + 3/4 I_3) - I_3 \
      =& 1/4 sec^3 x tan x - 1/4 I_3 \
      =& 1/4 sec^3 x tan x - 1/4 [ 1/2 (sec x tan x + ln |sec x + tan x|) ] + C \
      =& 1/4 sec^3 x tan x - 1/8 sec x tan x - 1/8 ln |sec x + tan x| + C $
  ]
)

#v(1em)
#line(length: 100%, stroke: 0.5pt + gray)
#v(1em)

// 題目 5
#exam_item(
  [#heading(level: 1, numbering: none)[*5.* $integral cos^4 x dif x$]],
  [
    #set align(center)
    $ &integral cos^4 x dif x \
    =& integral (cos^2 x)^2 dif x \
    =& integral ( (1 + cos 2x) / 2 )^2 dif x \
    =& 1/4 integral (1 + 2cos 2x + cos^2 2x) dif x $

    #v(0.5em)

    #grid(
      columns: (1fr),
      stroke: 0.5pt + black,
      inset: 8pt,
      fill: (x, y) => if y == 0 { rgb("#E1F5FE") },
      align: horizon + center,
      [ 降次討論：$cos^2 2x$ ],
      align(left)[
        $
        cos^2 2x &= (1 + cos 4x) / 2 \
        integral cos^2 2x dif x &= integral (1 + cos 4x) / 2 dif x \
        &= 1/2 x + 1/8 sin 4x
        $
      ]
    )

    #v(0.5em)

    $ =& 1/4 [ integral 1 dif x + 2 integral cos 2x dif x + integral cos^2 2x dif x ] \
      =& 1/4 [ x + sin 2x + (1/2 x + 1/8 sin 4x) ] + C \
      =& 1/4 [ 3/2 x + sin 2x + 1/8 sin 4x ] + C \
      =& 3/8 x + 1/4 sin 2x + 1/32 sin 4x + C $
  ]
)

#v(1em)
#line(length: 100%, stroke: 0.5pt + gray)
#v(1em)

#exam_item(
  [#heading(level: 1, numbering: none)[*6.* $integral (16 - x^3) / ((x - 2)^2 (x^2 + 4)) dif x$]],
  [
    #set align(center)
    $ (16 - x^3) / ((x - 2)^2 (x^2 + 4)) &= A / (x - 2) + B / (x - 2)^2 + (C x + D) / (x^2 + 4) \
    "⇒" 16 - x^3 &= (x - 2)(x^2 + 4)A + (x^2 + 4)B + (x - 2)^2 (C x + D) \
    &= (x^3 - 2x^2 + 4x - 8)A + (x^2 + 4)B + (x^3 - 4x^2 + 4x)C + (x^2 - 4x + 4)D $

    #v(1em)

    // 第一組：處理前兩欄
    #grid(
      columns: (auto, auto, auto, auto, auto, auto, auto, auto),
      gutter: 0.5em,
      align: horizon,
      $ mat(1, 0, 1, 0, |, -1; -2, 1, -4, 1, |, 0; 4, 0, 4, -4, |, 0; -8, 4, 0, 4, |, 16) $,
      $"→"$,
      $ mat(1, 0, 1, 0, |, -1; -2, 1, -4, 1, |, 0; 1, 0, 1, -1, |, 0; -2, 1, 0, 1, |, 4) $,
      $"→"$,
      $ mat(1, 0, 1, 0, |, -1; 0, 1, -2, 1, |, -2; 0, 0, 0, -1, |, 1; 0, 1, 2, 1, |, 2) $,
      $"→"$,
      $ mat(1, 0, 1, 0, |, -1; 0, 1, -2, 1, |, -2; 0, 0, 0, -1, |, 1; 0, 0, 4, 0, |, 4) $,
      $"→"$
    )

    #v(1em)

    // 第二組：處理後兩欄與最終結果
    #grid(
      columns: (auto, auto, auto, auto, auto),
      gutter: 0.5em,
      align: horizon,
      $ mat(1, 0, 1, 0, |, -1; 0, 1, -2, 1, |, -2; 0, 0, 1, 0, |, 1; 0, 0, 0, -1, |, 1) $,
      $"→"$,
      $ mat(1, 0, 0, 0, |, -2; 0, 1, 0, 1, |, 0; 0, 0, 1, 0, |, 1; 0, 0, 0, 1, |, -1) $,
      $"→"$,
      $ mat(1, 0, 0, 0, |, -2; 0, 1, 0, 0, |, 1; 0, 0, 1, 0, |, 1; 0, 0, 0, 1, |, -1) $,
    )

    #v(1em)

    $ "經高斯消去法得：" cases(A = -2, B = 1, C = 1, D = -1) $

    #v(1.5em)

    #block(width: 100%, stroke: 0.5pt + black, inset: 10pt, fill: rgb("#E1F5FE"), [
      *將A, B, C, D 代回積分計算*
      #set align(left)
      $ integral ( ( -2 ) / (x - 2) + 1 / (x - 2)^2 + ( x - 1 ) / (x^2 + 4) ) dif x $

      #v(0.3em)
      將分式拆解：
      $ &= -2 integral 1 / (x - 2) dif x + integral (x - 2)^(-2) dif x + integral x / (x^2 + 4) dif x - integral 1 / (x^2 + 4) dif x \
        &= -2 ln |x - 2| + ( (x - 2)^(-1) ) / (-1) + 1/2 integral (dif (x^2 + 4)) / (x^2 + 4) - integral 1 / (x^2 + 2^2) dif x \
        &= -2 ln |x - 2| - 1 / (x - 2) + 1/2 ln (x^2 + 4) - 1/2 arctan(x / 2) + C $
    ])

    #v(1.5em)

    #set align(left)
    *Python 程式碼驗證 (SymPy)*

    #show raw.where(block: true): it => {
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
              align(left, line) // 確保程式碼內容靠左對齊
            )).flatten()
          )
        }
      )
    }

    ```python
    import sympy

    x = sympy.symbols('x')
    f = (16 - x**3) / ((x - 2)**2 * (x**2 + 4))

    # 計算部分分式
    partial_fractions = sympy.apart(f)
    # 計算積分
    integral_result = sympy.integrate(f, x)

    print(f"Partial Fractions: {partial_fractions}")
    print(f"Integral: {integral_result}")
    ```

    #v(0.5em)
    *Output:*
    #show raw.where(block: true): it => block(fill: luma(245), inset: 8pt, radius: 4pt, width: 100%, it)
    ```text
    Partial Fractions: (x - 1)/(x**2 + 4) - 2/(x - 2) + (x - 2)**(-2)
    Integral: -2*log(x - 2) + log(x**2 + 4)/2 - atan(x/2)/2 - 1/(x - 2)
    ```
  ]
)

#v(1em)
#line(length: 100%, stroke: 0.5pt + gray)
#v(1em)

#exam_item(
  [#heading(level: 1, numbering: none)[*7, 8.* 三角代換對照：$integral sqrt(1-x^2) / x dif x$ 與 $integral sqrt(1+x^2) / x dif x$]],
  [
    #v(0.5em)

    // 使用 grid 進行左右對照排版
    #grid(
      columns: (1fr, 1fr),
      stroke: (x, y) => if x == 0 and y == 1 { (right: 0.5pt + blue) }, // 中間分隔線
      inset: 10pt,
      align: top + center,
      // 第一列：題目標題（帶淺藍色背景）
      fill: (x, y) => if y == 0 { rgb("#E1F5FE") },
      [$ integral sqrt(1-x^2) / x dif x $],
      [$ integral sqrt(1+x^2) / x dif x $],

      // 第二列：解法過程
      align(left)[
        令 $x = sin theta, dif x = cos theta dif theta$
        $ &= integral (cos theta) / (sin theta) (cos theta dif theta) \
          &= integral (cos^2 theta) / (sin theta) dif theta \
          &= integral (1 - sin^2 theta) / (sin theta) dif theta \
          &= integral (csc theta - sin theta) dif theta \
          &= ln |csc theta - cot theta| + cos theta + C \
          &= ln | (1-sqrt(1-x^2)) / x | + sqrt(1-x^2) + C $
      ],
      align(left)[
        令 $x = tan theta, dif x = sec^2 theta dif theta$
        $ &= integral (sec theta) / (tan theta) (sec^2 theta dif theta) \
          &= integral 1 / (cos theta) dot (cos theta) / (sin theta) dot sec^2 theta dif theta \
          &= integral (sec^2 theta) / (sin theta) dif theta \
          &= integral (1 + tan^2 theta) / (sin theta) dif theta \
          &= integral (csc theta + sec theta tan theta) dif theta \
          &= ln |csc theta - cot theta| + sec theta + C \
          &= ln | (sqrt(1+x^2)-1) / x | + sqrt(1+x^2) + C $
      ]
    )
  ]
)
