@Entry
@Component
struct StckPage {
  @State message: string = 'Hello World';

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll() {
        Column() {
          //层叠布局
          Stack({ alignContent: Alignment.TopStart }) {
            Column().width(300).height(300).backgroundColor(Color.Blue)
            Column().width(200).height(200).backgroundColor(Color.Red)
            Column().width(100).height(100).backgroundColor(Color.Green)
          }
        }.width('100%').height('200%').backgroundColor(Color.Black)
      }.scrollBar(BarState.On).scrollBarWidth(20).scrollBarColor('#ffffff')

      Stack() {
        Column().width(80).height(80).backgroundColor(Color.Red)
        Column().width(50).height(50).backgroundColor(Color.Blue)
      }.margin({
        bottom: 20,
        right: 20
      })
    }

  }
}