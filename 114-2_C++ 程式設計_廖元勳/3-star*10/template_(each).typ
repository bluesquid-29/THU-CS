// #import "@preview/codly:1.3.0": *
#import "@local/codly:1.3.1": *
#import "@preview/codly-languages:0.1.10": *
  #show: codly-init.with()
#import "@preview/tablem:0.3.0": tablem, three-line-table
#import "@preview/algorithmic:1.0.7"
  #import algorithmic: style-algorithm, algorithm-figure, algorithm
  #show: style-algorithm



#set page(
  paper: "a4",
  margin: (top: 0.8cm, bottom: 1.2cm, left: 0.8cm, right: 0.8cm),
  flipped: true, 
)
#set text(
  tracking: 0.2pt,
  // font: ("Libertinus Serif", "LXGW Neo XiHei"),
  font: ("Noto Serif", "Noto Sans CJK TC"),
  size: 12pt,
  lang: "zh",
  region: "tw",
)

#codly(number-format: none)
==  #text(red)[XXXXX] #h(0.25cm) #text(blue)[Hello world] #text(size: 12pt)[(easy)]

#table(
  columns: (1fr, 1fr),       
  column-gutter: 0em,        
  stroke: none,              
  align: top + left,         
  [
    
  ],
  table.vline(x: 1, stroke: gray),
  [
    
  ]
)



==== #text(red)[Input]
#table(
  columns: (1fr, 1fr),       
  column-gutter: 0em,        
  stroke: none,              
  align: top + left,         
  [
    
  ],
  table.vline(x: 1, stroke: gray),
  [
    
  ]
)



==== #text(red)[Output]
#table(
  columns: (1fr, 1fr),       
  column-gutter: 0em,        
  stroke: none,              
  align: top + left,         
  [
    
  ],
  table.vline(x: 1, stroke: gray),
  [
    
  ]
)



#table(
  columns: (1fr, 1fr),       
  column-gutter: 0em,        
  stroke: none,              
  align: top + left,         
  [
    ==== #text(red)[Sample Input]
    
  ],
  table.vline(x: 1, stroke: gray),
  [
    ==== #text(red)[Sample Output]
    
  ]
)

#line(length: 100%, stroke: 1pt + gray)
#pagebreak()

#codly(number-format: n => text(gray.darken(20%))[#n],)
#set par(first-line-indent: (amount: 0em,))


