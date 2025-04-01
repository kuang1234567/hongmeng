//Grid布局主要用于一些较规则的布局。日历，计算器这种布局。 并且可以响应式，可以用于多端适配。
@Entry
@Component
struct GridPage {
  @State gridList: Array<string> = ['1', '2', '3', '4', '5', '6', '7', '8']
  @State numbers2: String[] = ['0', '1', '2', '3', '4', '5']
  scroller: Scroller = new Scroller()
  private layoutOptions1: GridLayoutOptions = {
    regularSize: [1, 1], // 只支持[1, 1]
    irregularIndexes: [0, 3], // 索引为0和 n 的GridItem占用一行
  }
  private layoutOptions3: GridLayoutOptions = {
    regularSize: [1, 1],
    onGetRectByIndex: (index: number) => {
      if (index == 0) {
        return [0, 0, 1, 1]
        //GridItem的位置及大小[rowStart,columnStart,rowSpan,columnSpan]。其中rowStart为行起始位置，columnStart为列起始位置，无单位。
        //rowSpan为GridItem占用的行数，columnSpan为GridItem占用的列数，无单位。
      } else if (index == 1) {
        return [0, 1, 2, 2]
      } else if (index == 2) {
        return [0, 3, 3, 3]
      } else if (index == 3) {
        return [3, 0, 3, 3]
      } else if (index == 4) {
        return [4, 3, 2, 2]
      } else {
        return [5, 5, 1, 1]
      }
    }
  }

  build() {
    Column() {
      Grid() {
        ForEach(this.gridList, (item: string, index) => {
          GridItem() {
            Text(`旅行${item}`).fontColor(Color.White)
          }.backgroundColor(Color.Blue)
        }, (item: string) => item)
      }
      .rowsTemplate('1fr 1fr') // rowsTemplate 行分成几行有多少个就是多少行
      .columnsTemplate('1fr 2fr 1fr') //1fr 的意思是占有多少份
      .rowsGap(10) //行的间距
      .columnsGap(10) //例的间距
      .width('100%')
      .height(180)
      .border({ width: 1, style: BorderStyle.Solid, color: Color.Red })

      //如果rowsTemplate和columnsTemplate只设置一个的话只有在设置的方向才会平分，另一个方向上只能由内容撑开。如果给GridItem设置宽多出的部分
      //会自动产生滚动条

      //// 不使用scroll，需要undefined占位
      Grid() {
        ForEach(this.gridList, (item: string, index) => {
          GridItem() {
            Text(`旅行${item}`).fontColor(Color.White)
          }.backgroundColor(Color.Blue).width('50%')
        }, (item: string) => item)
      }
      .rowsTemplate('1fr 1fr')
      .rowsGap(10) //行的间距
      .columnsGap(10) //例的间距
      .scrollBar(BarState.Off)
      .width('100%')
      .height(180)
      .border({ width: 1, style: BorderStyle.Solid, color: Color.Red })


      Grid(undefined, this.layoutOptions3) {
        ForEach(this.numbers2, (day: string) => {
          GridItem() {
            Text(day)
              .fontSize(16)
              .backgroundColor(0xF9CF93)
              .width('100%')
              .height("100%")
              .textAlign(TextAlign.Center)
          }
          .height("100%")
          .width('100%')
        }, (day: string) => day)
      }
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
      .columnsGap(10)
      .rowsGap(10)
      .width('90%')
      .backgroundColor(0xFAEEE0)
      .height(300)
    }
    .height('100%')
    .width('100%')
  }
}