// 1. 全域版面與字型設定
#set page(
  paper: "a4",
  margin: (x: 2cm, top: 2.5cm, bottom: 2.5cm)
)
// 題目原始風格使用 Times New Roman 系列字型
#set text(
  // font: "Times New Roman", 
  size: 11pt, 
  lang: "en"
)

// 設定段落排版：取消首行縮排、設定段落間距
#set par(justify: true, leading: 0.65em, first-line-indent: 2em)
// #show par: set block(spacing: 1.2em)

// 2. 標頭區域 (UVa 經典樣式)


    #text(size: 18pt, weight: "bold")[
      #text(red)[10096] 
      #h(0.25cm) 
      #text(blue)[The Richest Man of the Universe]
    ]
    // #v(0.2em)



// #v(0.8em)
#line(length: 100%, stroke: 0.5pt + black)
#v(0.5em)

// 3. 題目內文
Today I am going to tell you the story of the Richest Man of the Universe. He lives in planet Archadia that is 200 light years away from the Earth. A parallel human civilization exists in that planet. His name is Charge Doors. A strange name to us but if you are very intelligent you find the significance of his name. [cite: 3, 4, 5, 6]

He graduated (probably) from a University which is now the best in the Universe for Medical Study (You may wonder why you dont know this University. It is because the news is broadcasted from Archadia and you will know it 200 years later!) Though he is a very brilliant programmer, in his student life he spent much of his time in a Virus Research Lab for some unknown reasons (maybe his friends know). [cite: 7]

He worked there with a kind of Virus called "Archadian Bascillae". These viruses are circular in shape. They can do two operations: fission and fusion. Fission occurs in breeding season and fusion occurs during hostile season. [cite: 8, 9]

In breeding season each virus is kept in a rectangular transparent box. After fission two viruses of equal size and shape (circular of course) is created. After fission they maintain maximum possible distance between them in the box. Given the radius of the initial virus and the size of the box it was kept in you will have to determine the maximum distance possible between the centers of the two viruses. [cite: 10, 11, 12, 13]

// 插入圖片預留位置（原圖 Fig 1）
#align(center)[
  #rect(width: 8em, height: 6em, stroke: 0.5pt + gray)[
    #align(center + horizon)[Fig 1 / Fig 2]
  ]
]

During fusion two viruses merges but this merging is not complete. Some portion of one virus overlaps some portion of the other virus. The thickness of their common portion is doubled but thickness in all other portion remains the same (This incident is like two rigid disks stick to each other with the help of glue). The thing to note here is that all the single viruses are of equal thickness though their size may vary. You will have to determine the area covered by these semi-merged viruses. [cite: 16, 17, 18, 19, 20]

You have to solve this problem, as you are about to give an interview to his large software company. For some odd reasons he asks everyone to solve this problem. [cite: 21, 22]

// 4. 輸入/輸出 區塊標題樣式
#let section-heading(title) = {
  v(1.5em)
  text(size: 13pt, weight: "bold")[#title]
  v(0.5em)
}

#section-heading("Input")
First line of the input file contains an integer $N$ that indicates how many sets of inputs are there. Next $N$ lines contains $N$ sets of inputs. [cite: 24, 25]

Every input begins with a character $C$ whose value is either 'S' (for fission) or 'M' (for fusion). For fission, next there will be three real numbers, 'L' (length of the rectangular box), 'W' (width of the rectangular box) and $R$ (radius of the virus to make fission). For fusion after character 'M' there will be three real numbers, $R_1$ (radius of the first virus), $R_2$ (radius of the second virus) and $d$ (the distance between these two viruses and $d >= max(R_1, R_2)$). [cite: 26, 27, 28]

No numerical value in the input will be negative and also there value will not exceed 2000. [cite: 29]

#section-heading("Output")
For each line of input you will have to print one or two lines of output. [cite: 32]

For fission type input you will have to print the maximum possible distance between the centers of the two viruses according to the sample output format. If there is not enough space for fission in the rectangular box print the line 'Not enough space for fission.' Fission is impossible if the viruses cannot remain separated (not overlapped) in the box at any possible position. If fission is impossible then there is no need to print the maximum possible distance. [cite: 34, 35, 36, 37]

For fusion type of input you have to print the compaction ratio of the virus according to the sample output. Compaction Ratio is defined as: [cite: 38, 39]

$$ text("Compaction Ratio") = frac("Surface area covered by the merged virus", "Area covered by first virus before merging" + "Area covered by second virus before merging") $$ [cite: 40, 41]

When the printed compaction ratio is '1.0000' you will have to print in the next line 'No compaction has occurred.' Another important thing is that when no merging has occurred you will have to print the compaction ratio as '1.0000' and in the next line you will have to print, 'No compaction has occurred.' [cite: 41, 42]

Print a blank line after the output for each set of input. [cite: 43]

#v(1.5em)

// 5. 範例輸入與輸出對照表 (使用無邊框 table 並排呈現)
#table(
  columns: (1fr, 1fr),
  stroke: none,
  fill: none,
  gutter: 2em,
  [
    #text(weight: "bold")[Sample Input]
    #v(0.5em)
    #rect(width: 100%, stroke: 0.5pt + black, inset: 8pt)[
      // #set text(font: "Courier New", size: 10pt)
      4 \
      S 10.1 10.1 1 \
      M 5 5 8 \
      S 10 5 20 \
      M 5 5 15
    ]
  ],
  [
    #text(weight: "bold")[Sample Output]
    #v(0.5em)
    #rect(width: 100%, stroke: 0.5pt + black, inset: 8pt)[
      // #set text(font: "Courier New", size: 10pt)
      12.2836 \
      0.9480 \
      Not enough space for fission. \
      1.0000 \
      No compaction has occurred.
    ]
  ]
)