@Entry
@Component
struct RelativecontainerPage2 {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Column() {
        Text('1').fontColor(Color.White).height(100)
      }.width(100).height(100).backgroundColor(Color.Black).id('row1')

      //RelativeContainer默认是已父盒子作为参考盒子，
      // 如果想要别的盒子做为参考需要再这个盒子上加上id这个属性，方便获取到这个盒子。

      Column() {
        Text('2').fontColor(Color.White).height(100)
      }.width(100).height(100).backgroundColor(Color.Black).alignRules({
        left: { anchor: 'row1', align: HorizontalAlign.End },
        top: { anchor: 'row1', align: VerticalAlign.Bottom }
      })

      //如果参考的盒子太小，达不到所需效果可以通过offset来调整其位置

      Column() {
        Text('3').fontColor(Color.White).height(100)
      }
      .width(100)
      .height(100)
      .backgroundColor(Color.Black)
      .alignRules({
        left: { anchor: 'row1', align: HorizontalAlign.End }
      })
      .offset({
        x: 100,
        y: 0
      })
    }
    .height('300')
    .width('300').border({
      width: 1,
      color: Color.Red
    })
  }
}