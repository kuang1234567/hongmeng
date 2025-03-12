@Entry
@Component
struct RelativecontianerPage {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Column() {
        Text('1').fontColor(Color.White).height(100)
      }.width(100).height(100).backgroundColor(Color.Black)
      .alignRules({
        left: { anchor: '__container__', align: HorizontalAlign.Start },
        top: { anchor: '__container__', align: VerticalAlign.Top }
      })

      Column() {
        Text('2').fontColor(Color.White).height(100)
      }.width(100).height(100).backgroundColor(Color.Black)
      .alignRules({
        right: { anchor: '__container__', align: HorizontalAlign.End },
        top: { anchor: '__container__', align: VerticalAlign.Top }
      })

      Column() {
        Text('3').fontColor(Color.White).height(100)
      }.width(100).height(100).backgroundColor(Color.Black)
      .alignRules({
        middle: { anchor: '__container__', align: HorizontalAlign.Center },
        center: { anchor: '__container__', align: VerticalAlign.Center }
      })

      Column() {
        Text('4').fontColor(Color.White).height(100)
      }.width(100).height(100).backgroundColor(Color.Black)
      .alignRules({
        left: { anchor: '__container__', align: HorizontalAlign.Start }, bottom: {
          anchor: '__container__', align: VerticalAlign.Bottom
        }
      })

      Column() {
        Text('5').fontColor(Color.White).height(100)
      }.width(100).height(100).backgroundColor(Color.Black)
      .alignRules({
        right: { anchor: '__container__', align: HorizontalAlign.End }, bottom: {
          anchor: '__container__', align: VerticalAlign.Bottom
        }
      })
    }
    .height('300')
    .width('300').border({
      width: 1,
      color: Color.Red
    })
  }
}