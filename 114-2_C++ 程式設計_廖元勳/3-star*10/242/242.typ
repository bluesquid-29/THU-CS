// #import "@preview/codly:1.3.0": *
#import "@local/codly:1.3.1": *
#import "@preview/codly-languages:0.1.10": *
  #show: codly-init.with()
#import "@preview/tablem:0.3.0": tablem, three-line-table



#codly(number-format: none)
==  #text(red)[242] #h(0.25cm) #text(blue)[Stamps and Envelope Size] #text(size: 12pt)[(DP)]

#table(
  columns: (1fr, 1fr),       
  column-gutter: 0em,        
  stroke: none,              
  align: top + left,         
  [
    Philatelists have collected stamps since long before postal workers were disgruntled. An excess of stamps may be bad news to a country's postal service, but good news to those that collect the excess stamps. The postal service works to minimize the number of stamps needed to provide seamless postage coverage. To this end you have been asked to write a program to assist the postal service.

    Envelope size restricts the number of stamps that can be used on one envelope. For example, if 1 cent and 3 cent stamps are available and an envelope can accommodate 5 stamps, all postage from 1 to 13 cents can be "covered":

    #three-line-table[
      | *Postage* | *Number of 1¢ Stamps* | *Number of 3¢  Stamps* |
      | :-------: | :------------------: | :------------------: |
      |     1     |          1           |          0           |
      |     2     |          2           |          0           |
      |     3     |          0           |          1           |
      |     4     |          1           |          1           |
      |     5     |          2           |          1           |
      |     6     |          0           |          2           |
      |     7     |          1           |          2           |
      |     8     |          2           |          2           |
      |     9     |          0           |          3           |
      |    10     |          1           |          3           |
      |    11     |          2           |          3           |
      |    12     |          0           |          4           |
      |    13     |          1           |          4           |
    ]

    Although five 3 cent stamps yields an envelope with 15 cents postage, it is not possible to cover an envelope with 14 cents of stamps using at most five 1 and 3 cent stamps. Since the postal service wants maximal coverage without gaps, the maximal coverage is 13 cents.
  ],
  table.vline(x: 1, stroke: gray),
  [
    集郵家收集郵票的歷史，遠在郵政工人變得不滿之前就開始了。過剩的郵票對一個國家的郵政服務來說可能是壞消息，但對於收集這些過剩郵票的人來說卻是好消息 。郵政服務致力於將提供無縫郵資覆蓋所需的郵票數量減至最少 。為此，你被要求編寫一個程式來協助郵政服務 。#v(2.4em)

    信封的大小限制了單個信封上可以使用的郵票數量 。例如，如果可以使用 1 分和 3 分的郵票，且一個信封最多可容納 5 枚郵票，則可以「覆蓋」從 1 到 13 分的所有郵資 ：

    #three-line-table[
      | *郵資* | *1 分郵票數量* | *3 分郵票數量* |
      | :--: | :-------: | :-------: |
      |  1   |     1     |     0     |
      |  2   |     2     |     0     |
      |  3   |     0     |     1     |
      |  4   |     1     |     1     |
      |  5   |     2     |     1     |
      |  6   |     0     |     2     |
      |  7   |     1     |     2     |
      |  8   |     2     |     2     |
      |  9   |     0     |     3     |
      |  10  |     1     |     3     |
      |  11  |     2     |     3     |
      |  12  |     0     |     4     |
      |  13  |     1     |     4     |
    ]

    雖然五枚 3 分的郵票可以使信封達到 15 分的郵資，但使用最多五枚 1 分和 3 分的郵票是無法湊出 14 分郵資的 。由於郵政服務需要「無間斷（無空缺）」的最大覆蓋範圍，因此最大覆蓋面為 13 分 。#v(2.4em)
  ]
)



=== #text(red)[Input]
#table(
  columns: (1fr, 1fr),       
  column-gutter: 0em,        
  stroke: none,              
  align: top + left,         
  [
    The first line of each data set contains the integer $S$, representing the maximum of stamps that an envelope can accommodate. The second line contains the integer $N$, representing the number of sets of stamp denominations in the data set. Each of the next $N$ lines contains a set of stamp denominations. The first integer on each line is the number of denominations in the set, followed by a list of stamp denominations, in order from smallest to largest, with each denomination separated from the others by one or more spaces. There will be at most $S$ denominations on each of the $N$ lines. The maximum value of $S$ is 10, the largest stamp denomination is 100, the maximum value of $N$ is 10. 
    
    The input is terminated by a data set beginning with zero ($S$ is zero).
  ],
  table.vline(x: 1, stroke: gray),
  [
    每組測試資料的第一行包含一個整數 $S$，代表信封最多可容納的郵票數量 。第二行包含一個整數 $N$，代表該組測試資料中的郵票面額組合數量 。接下來的 $N$ 行中，每行包含一組郵票面額 。每行的第一個整數是該組合中的面額數量，後面跟著面額列表，按從小到大的順序排列，每個面額之間用一個或多個空格隔開 。這 $N$ 行中的每一行最多會有 $S$ 個面額 。$S$ 的最大值為 10，最大的郵票面額為 100，$N$ 的最大值為 10 。#v(6.0em)

    當輸入的測試資料以零開始（即 $S$ 為 0）時，代表輸入結束 。#v(1.2em)
  ]
)



=== #text(red)[Output]
#table(
  columns: (1fr, 1fr),       
  column-gutter: 0em,        
  stroke: none,              
  align: top + left,         
  [
    Output one line for each data set giving the maximal no-gap coverage followed by the stamp denominations that yield that coverage in the following format:

    #codly(
      highlight-inset: (x: 0pt, y: 0em),
      highlights: (
      (line: 1, start: 17, end: 21, fill: red,  inset: 2pt, radius: 0pt ),
      (line: 1, start: 27, end: 39, fill: red,  inset: 2pt, radius: 0pt ),      
    ))
    ```
    max coverage = <value>: < denominations >
    ```

    #set par(first-line-indent: (amount: 2em, all: true ),)
    If more than one set of denominations in a set yields the same maximal no-gap coverage, the set with the fewest number of denominations should be printed (this saves on stamp printing costs). If two sets with the same number of denominations yield the same maximal no-gap coverage, then the set with the lower maximum stamp denomination should be printed. For example, if five stamps fit on an envelope, then stamp sets of 1, 4, 12, 21 and 1, 5, 12, 28 both yield maximal no-gap coverage of 71 cents. The first set would be printed because both sets have the same number of denominations but the first set's largest denomination (21) is lower than that of the second set (28). If multiple sets in a sequence yield the same maximal no-gap coverage, have the same number of denominations, and have equal largest denominations, then print the set with the lower second-maximum stamp denomination, and so on.

  ],
  table.vline(x: 1, stroke: gray),
  [
    對於每組測試資料，請輸出一行，給出最大的無間斷覆蓋範圍，隨後是以以下格式輸出產生該覆蓋範圍的郵票面額 ：#v(1.2em)

    #codly(
      highlight-inset: (x: 0pt, y: 0em),
      highlights: (
      (line: 1, start: 17, end: 21, fill: red,  inset: 2pt, radius: 0pt ),
      (line: 1, start: 27, end: 39, fill: red,  inset: 2pt, radius: 0pt ),      
    ))
    ```
    max coverage = <value>: < denominations >
    ```

    #set par(first-line-indent: (amount: 2em, all: true ),)
    如果一組資料中有多個面額組合都能產生相同的最大無間斷覆蓋範圍，則應列印出*面額數量最少*的組合（這可以節省郵票印刷成本） 。如果兩個具有相同面額數量的組合產生了相同的最大無間斷覆蓋範圍，則應列印出*最大面額較小*的組合 。例如，如果信封上可以貼五枚郵票，那麼面額組合 {1, 4, 12, 21} 和 {1, 5, 12, 28} 都能產生 71 分的最大無間斷覆蓋範圍 。此時應列印第一個組合，因為兩個組合的面額數量相同，但第一個組合的最大面額（21）低於第二個組合的最大面額（28） 。如果序列中的多個組合產生相同的最大無間斷覆蓋範圍、具有相同的面額數量，且最大面額也相同，則列印出*次大面額較小*的組合，依此類推 。#v(7.2em)
  ]
)



#table(
  columns: (1fr, 1fr),       
  column-gutter: 0em,        
  stroke: none,              
  align: top + left,         
  [
    === #text(red)[Sample Input]
    ```
    5
    2
    4 1 4 12 21
    4 1 5 12 28
    10
    2
    5 1 7 16 31 88
    5 1 15 52 67 99
    6
    2
    3 1 5 8
    4 1 5 7 8
    0
    ```
    
  ],
  table.vline(x: 1, stroke: gray),
  [
    === #text(red)[Sample Output]
    ```
    max coverage =  71:  1  4 12 21
    max coverage = 409:  1  7 16 31 88
    max coverage =  48:  1  5  7  8
    ```
    
  ]
)



#line(length: 100%, stroke: 1pt + gray)
#codly(number-format: n => text(gray.darken(20%))[#n],)


