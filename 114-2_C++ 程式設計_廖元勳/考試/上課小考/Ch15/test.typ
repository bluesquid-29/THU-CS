#show raw.where(block: true): it => {
  let is-numbered = it.lang != none and it.lang.ends-with("-n")
  let clean-lang = if is-numbered { it.lang.slice(0, -2) } else { it.lang }

  block(
    fill: rgb("#f8f9fa"),
    inset: 12pt,
    radius: 4pt,
    stroke: 0.5pt + luma(200),
    width: 100%,
    {
      set text(size: 0.85em, font: "DejaVu Sans Mono")
      
      // 【核心關鍵 1】：不論有沒有行號，強制拔除內部所有單行 raw 的預設灰色背景
      // show raw.where(block: false): set text(background: none)
      
      // 提取行資料（嚴格遵守屬性存取規範）
      let lines = it.lines 
      
      if is-numbered {
        grid(
          columns: (2.2em, 1fr),
          column-gutter: 0.8em,
          row-gutter: 0.6em,
          ..lines.enumerate().map(((i, line)) => (
            align(right, text(fill: gray.darken(20%), size: 1em, font: "DejaVu Sans Mono")[#(i + 1)]),
            // 使用 block: false 阻斷無限遞迴
            raw(line.text, lang: clean-lang, block: false)
          )).flatten()
        )
      } else {
        // 【核心關鍵 2】：沒行號時，同樣使用 block: false 逐行輸出，徹底阻斷遞迴崩潰！
        // 用單一欄位的 grid 排版，並微調行距，視覺效果與原生完全一致
        grid(
          columns: (1fr,),
          row-gutter: 0.6em,
          ..lines.map(line => raw(line.text, lang: clean-lang, block: false))
        )
      }
    }
  )
}
#set heading(numbering: "1.")

= Overview <intro>
In this section, we discuss the basics.

Go back to the #link(<intro>)[Introduction + '55] for more details.
Alternatively, see @intro for the numbered reference.

// ==================== 測試範例 ====================
// 定義主題顏色
#let navy = rgb("#1e3d59")

// --- 頂部標頭區域 ---
#grid(
  // 三欄：左側（配平右側日期寬度）、中間（主標題自動伸展）、右側（日期方塊）
  columns: (11.5em, 1fr, 11.5em),
  align: horizon,
  
  // 1. 左側空心區塊：純粹用來讓中間標題完美置中
  none,
  
  // 2. 中間主標題
  align(center)[
    #text(size: 18pt, weight: "bold", fill: navy)[Ch15 小考 —— 運算子多載]\
    #v(0.2em)
    #text(size: 16pt, weight: "regular")[Problem 1]
  ],
  
  // 3. 右側日期
  align(right)[
    #grid(
      columns: (auto, auto),
      column-gutter: 0.6em,
      row-gutter: 0.7em,
      align: left + horizon,
      text(size: 11.5pt)[*日期：*],
      // 使用 rect 的 bottom stroke 來做完美的下底線
      rect(
        stroke: (bottom: 0.5pt + black), 
        inset: (bottom: 2pt, x: 2pt)
      )[
        #text(size: 11.5pt)[
          #datetime(year: 2026, month: 4, day: 30).display("[year]/[month]/[day]")
        ]
      ]
    )
  ]
)

// --- 分隔線 ---
#v(0.5em)
#line(length: 100%, stroke: 1.5pt + navy)
#v(1em)
// 1. 有行數測試 (cpp-n)
#raw("Point operator+(Point const& b)\n{\n    return Point(this->x + b.x, this->y + b.y);\n}", lang: "cpp-n", block: true)

#v(1em)

// 2. 沒行數測試 (cpp) -> 之前會在這裡崩潰，現在完美過關！
#raw("Point operator+(int const& b)\n{\n    return Point(this->x + b, this->y + b);\n}", lang: "cpp", block: true)

#table(
  columns: (0.9fr, 3fr),
  fill: (x, y) => if y == 0 { rgb("#E1F5FE") },
  [Operators], [Code example],
  
  [Increment/Decrement:\ `++` and `--`.],   
  [
    #grid(
      columns: (1fr, 1fr),
      gutter: 10pt,        // 加大間距讓程式碼有呼吸空間
      
      // 第一排：前置
      [
        ```cpp-n
        Point& operator++() 
        {
            this->x += 1;
            this->y += 1;
            return *this;
        }
        ```
      ],
      [
        ```cpp
        Point& operator--() 
        {
            this->x -= 1;
            this->y -= 1;
            return *this;
        }
        ```
      ],
      
      // 中間用一條乾淨的橫線切開，並加上間距
      grid.cell(colspan: 2)[
        #v(5pt)
        #line(length: 100%, stroke: 0.5pt + gray)
        #v(5pt)
      ],
      
      // 第二排：後置
      [
        ```cpp
        Point operator++(int)
        {
            Point temp = *this;
            this->x += 1;
            this->y += 1;
            return temp;
        }
        ```
      ],
      [
        ```cpp
        Point operator--(int)
        {
            Point temp = *this;
            this->x -= 1;
            this->y -= 1;
            return temp;
        }
        ```
      ]
    )
  ]
)

#table(
  columns: (1fr, 3fr),
  fill: (x, y) => if y == 0 { rgb("#E1F5FE") },
  [Operators], [Code example],
  
  [Increment/Decrement:\ `++` and `--`.],   
  
  // 核心：將這一格的內襯拔除
  table.cell(inset: 0pt)[
    #grid(
      columns: (1fr, 1fr),
      // 改由內部 grid 的 cell 補回上下左右的間距，確保橫線能衝出去，但文字不會撞牆
      inset: 10pt, 
      
      [左上區塊], [右上區塊],
      
      // 這條線會完全無視外層邊界，達成 100% 貼邊
      grid.hline(stroke: 0.5pt + gray),
      
      [左下區塊], [右下區塊]
    )
  ]
)

#table(
  columns: (1fr, 3fr),
  fill: (x, y) => if y == 0 { rgb("#E1F5FE") },
  
  // 1. 表頭
  [Operators], [Code example],
  
  // 2. 第一欄內容
  [Increment/Decrement:\ `++` and `--`.],   
  
  // 3. 第二欄：完全貼邊的組合單元格
  table.cell(inset: 0pt)[
    #table(
      columns: (1fr, 1fr),
      stroke: none, // 關閉預設全邊框，改用手動控制
      
      // 上排組
      [左上內容], [右上內容],
      
      // 中間完全貼邊的無縫橫線
      table.hline(stroke: 0.5pt + gray),
      
      // 下排組
      [左下內容], [右下內容]
    )
  ]
)

#table(
  columns: (1fr, 3fr),
  fill: (x, y) => if y == 0 { rgb("#E1F5FE") },
  align: (col, row) => if col == 0 { horizon } else { top },
  
  [Operators], [Code example],

  // ==================== 範例 1：右邊需要切 4 格 (2x2) 且橫線貼邊 ====================
  [
    Increment/Decrement:\
    `++` and `--`
  ],
  table.cell(inset: 0pt)[ // 關鍵 1：拔除外框內襯
    #grid(
      columns: (1fr, 1fr),
      inset: 10pt,        // 關鍵 2：由內部 grid 補回程式碼的舒適間距
      
      [左上程式碼], [右上程式碼],
      
      grid.hline(stroke: 0.5pt + gray), // 完美貼邊橫線
      grid.vline(start: 1, stroke: 5pt + gray),
      [左下程式碼], [右下程式碼]
    )
  ],

  // ==================== 範例 2：右邊只需要簡單切左右 2 格 ====================
  [
    Binary Operators:\
    `+` and `-`
  ],
  table.cell(inset: 0pt)[
    #grid(
      columns: (1fr, 1fr),
      inset: 10pt,
      [加法程式碼], [減法程式碼] // 不需要橫線，直接放兩格
    )
  ],

  // ==================== 範例 3：右邊只有 1 個單純的程式碼 ====================
  [
    Assignment:\
    `=`
  ],
  table.cell(inset: 0pt)[
    #grid(
      columns: (1fr,),
      inset: 10pt,
      [單一程式碼區塊] // 就算只有一個，套用同一個 grid 格式也會高度一致
    )
  ]
)

#table(
  columns: (1fr, 3fr),
  fill: (x, y) => if y == 0 { rgb("#E1F5FE") },
  align: (col, row) => if col == 0 { horizon } else { top },
  
  [Operators], [Code example],

  [
    Increment/Decrement:\
    `++` and `--`
  ],
  table.cell(inset: 0pt)[ // 關鍵 1：外層清除內襯
    #grid(
      columns: (1fr, 1fr),
      inset: 10pt,        // 關鍵 2：內部補回文字間距
      
      // 【新增直邊線】：在第 1 欄後面畫一條直落到底、完美貼邊的直線
      grid.vline(start: 1, stroke: 5pt + gray),
      
      [左上程式碼], [右上程式碼],
      
      // 【橫邊線】：完美貼邊橫線
      grid.hline(stroke: 0.5pt + gray),
      
      [左下程式碼], [右下程式碼]
    )
  ]
)

#table(
  columns: (1fr, 3fr),
  fill: (x, y) => if y == 0 { rgb("#E1F5FE") },
  align: (col, row) => if col == 0 { horizon } else { top },
  
  [Operators], [Code example],

  [
    Increment/Decrement:\
    `++` and `--`
  ],
  table.cell(inset: 0pt)[ 
    #table(
      columns: (1fr, 1fr),
      inset: 10pt,
      stroke: none, // 先關閉預設外框
      
      // 【完美直分隔線】：精準放在第 1 欄後面（即兩欄正中間）
      table.vline(x: 1, stroke: 0.5pt + gray),
      
      [左上程式碼], [右上程式碼],
      
      // 【完美橫分隔線】
      table.hline(stroke: 0.5pt + gray),
      
      [左下程式碼], [右下程式碼]
    )
  ]
)

#table(
  columns: (1fr, 3fr),
  fill: (x, y) => if y == 0 { rgb("#E1F5FE") },
  align: (col, row) => if col == 0 { horizon } else { top },
  stroke: 0.5pt + luma(150),
  
  // 表頭
  [*Smart Pointer Type*], [*Implementation & Lifecycle Code Examples*],

  // ==================== 複雜場景 1：右邊完全不需要切割 (單一區塊) ====================
  [
    *std::unique_ptr*\
    獨佔所有權，禁止複製，僅能移動。
  ],
  table.cell(inset: 0pt)[
    #grid(
      columns: (1fr,),
      inset: 12pt,
      [
        ```cpp
        // 建立與轉移所有權
        auto p1 = std::make_unique<Point>(10, 20);
        // auto p2 = p1; // 編譯錯誤！禁止複製
        auto p3 = std::move(p1); // 正確：轉移所有權，此時 p1 變為 nullptr
        p3->print();
        ```
      ]
    )
  ],

  // ==================== 複雜場景 2：超複雜 4 格十字交叉貼邊 (2x2) ====================
  [
    *std::shared_ptr*\
    共享所有權，內部維護 Reference Count。
  ],
  table.cell(inset: 0pt)[
    #table(
      columns: (1fr, 1fr),
      inset: 12pt,
      stroke: none, // 關閉子表格外框，全靠十字貼邊線
      
      // 繪製正中央的十字分隔線
      table.vline(x: 1, stroke: 0.5pt + gray.lighten(30%)),
      table.hline(stroke: 0.5pt + gray.lighten(30%)),
      
      // [左上] 標準建構與計數
      [
        ```cpp-n
        // 1. 初始化與共享
        auto s1 = std::make_shared<Point>(1, 2);
        auto s2 = s1; // 複製成功
        // Reference Count 變為 2
        std::cout << s1.use_count(); 
        ```
      ],
      // [右上] 執行期動態轉移
      [
        ```cpp
        // 2. 指標控制權轉移
        std::shared_ptr<Point> s3;
        s3 = std::move(s2); 
        // 此時 s2 釋放，但計數仍為 2 (s1, s3)
        assert(s2 == nullptr);
        ```
      ],
      // [左下] 搭配 weak_ptr 解開循環引用
      [
        ```cpp
        // 3. 弱引用打破循環
        std::weak_ptr<Point> w_ptr = s1;
        if (auto observed = w_ptr.lock()) {
            // 安全鎖定成功，暫時提權
            observed->print();
        }
        ```
      ],
      // [右下] 自訂刪除器 (Custom Deleter)
      [
        ```cpp
        // 4. 高級釋放邏輯
        std::shared_ptr<FILE> file_ptr(
            fopen("log.txt", "r"), 
            [](FILE* f) { if(f) fclose(f); }
        );
        // 離開 scope 自動呼叫 lambda 關閉檔案
        ```
      ]
    )
  ],

  // ==================== 複雜場景 3：右邊只需要水平切兩排 (1x2) ====================
  [
    *std::weak_ptr*\
    不影響計數的旁觀者指標。
  ],
  table.cell(inset: 0pt)[
    #table(
      columns: (1fr,),
      inset: 12pt,
      stroke: none,
      table.hline(stroke: 0.5pt + gray.lighten(30%)),
      
      [
        ```cpp
        // 1. 檢查觀察對象是否還活著
        if (w_ptr.expired()) {
            std::cout << "Object is dead!\n";
        }
        ```
      ],
      [
        ```cpp
        // 2. 強制觀察 (若已死亡則噴出 bad_weak_ptr 異常)
        try {
            std::shared_ptr<Point> shared = std::shared_ptr<Point>(w_ptr);
        } catch (const std::bad_weak_ptr& e) {
            // 捕捉懸空指標引發的異常
        }
        ```
      ]
    )
  ]
)


#set page(paper: "a4", margin: 2cm)
#set text(font: ("Liberation Serif", "Noto Sans CJK TC"), lang: "zh", region: "TW")

#table(
  // 基礎網格：總寬度 12 等分
  columns: (1fr,) * 12,
  align: center + horizon,
  stroke: 0.5pt + black,
  
  // ==========================================
  // 第一階段：頂部標題列 (高度：3 網格)
  // ==========================================
  table.cell(colspan: 4, rowspan: 3)[/* TODO: 標題 1 */],
  table.cell(colspan: 8, rowspan: 3)[/* TODO: 標題 2 */],

  // ==========================================
  // 第二階段：上半部 (對應圖片一的局部細節)
  // ==========================================
  // 左側大欄位開始 (寬 4, 高 12)
  table.cell(colspan: 4, rowspan: 12)[/* TODO: 左側上區塊 */],
  
  // 右側第一層：三個並排欄位 (寬度分別為 3, 3, 2，高度皆為 6)
  table.cell(colspan: 3, rowspan: 6)[/* TODO: 右上 1 */],
  table.cell(colspan: 3, rowspan: 6)[/* TODO: 右上 2 */],
  table.cell(colspan: 2, rowspan: 6)[/* TODO: 右上 3 */],

  // 右側第二層 (第 10 網格高)：不規則切分 (左 5 寬高 3、右 3 寬高 6)
  table.cell(colspan: 5, rowspan: 3)[/* TODO: 右中左 (圖一左側凸出區) */],
  table.cell(colspan: 3, rowspan: 6)[/* TODO: 右中右 (圖一右側高格) */],

  // 右側第三層 (第 13 網格高)：橫向長條 (寬 5，高 3)
  table.cell(colspan: 5, rowspan: 3)[/* TODO: 右中下橫條 */],

  // ==========================================
  // 第三階段：下半部 (對應圖片二的局部細節)
  // ==========================================
  // 左側下大欄位開始 (寬 4, 高 12)
  table.cell(colspan: 4, rowspan: 12)[/* TODO: 左側下區塊 */],

  // 右側第四層：左 3 寬高 6、右 5 寬高 4
  table.cell(colspan: 3, rowspan: 6)[/* TODO: 右下上左 */],
  table.cell(colspan: 5, rowspan: 4)[/* TODO: 右下上右 */],

  // 右側第五層：右側下方的大區塊 (寬 5, 高 8)
  table.cell(colspan: 5, rowspan: 8)[/* TODO: 右下底右大格 */],

  // 右側第六層：左側下方的區塊 (寬 3, 高 6)
  table.cell(colspan: 3, rowspan: 6)[/* TODO: 右下底左 */],
)

#table(
  // 定義 3 欄：第 1 欄給標題，後 2 欄給並排的程式碼
  columns: (0.9fr, 1.5fr, 1.5fr),
  
  // 自動填滿第一列（Header）的背景色
  fill: (x, y) => if y == 0 { rgb("#E1F5FE") },
  
  // --- 第一列：Header (使用 colspan 將後兩欄合併) ---
  [Operators], 
  table.cell(colspan: 2)[Code example for `object p1`],

  // --- 第二列：前置/後置 增減運算子 ---
  // 左側標題跨 2 行（因為下方還有一組後置運算子）
  table.cell(rowspan: 2, align: horizon)[Increment/Decrement:\ `++` and `--`.],   
  
  // 前置運算子 (並排)
  [
    ```cpp-n
    Point& operator++() 
    {
        this->x += 1;
        this->y += 1;
        
        return *this;
    }
    ```
  ],
  [
    ```cpp
    Point& operator--() 
    {
        this->x -= 1;
        this->y -= 1;
        
        return *this;
    }
    ```
  ],

  // 後置運算子 (並排，會自動換行並靠右邊兩欄對齊)
  [
    ```cpp
    Point operator++(int)
    {
        Point temp = *this;
        
        this->x += 1;
        this->y += 1;
        
        return temp;
    }
    ```
  ],
  [
    ```cpp
    Point operator--(int)
    {
        Point temp = *this;
        
        this->x -= 1;
        this->y -= 1;
        
        return temp;
    }
    ```
  ],

  // --- 第三列：原本分隔線下方的獨立組別 ---
  // 左側新標題
  table.cell(align: horizon)[/* TODO: 新標題 */],
  // 右側兩欄並排程式碼
  [
    ```cpp
    Point operator++(int)
    {
        Point temp = *this;
        
        this->x += 1;
        this->y += 1;
        
        return temp;
    }
    ```
  ],
  [
    ```cpp
    Point operator--(int)
    {
        Point temp = *this;
        
        this->x -= 1;
        this->y -= 1;
        
        return temp;
    }
    ```
  ]
)