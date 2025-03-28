import { LengthMetrics } from '@kit.ArkUI';

@Entry
@Component
struct FlexPage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      //Flex主轴不设置是默认充满  FlexDirection.Row 横着排列 ， wrap: FlexWrap.Wrap 允许换行 wrap: FlexWrap.NoWrap
      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
        Text('1').width('20%').height(50).backgroundColor(0xF5DEB3)
        Text('2').width('20%').height(50).backgroundColor(0xD2B48C)
        Text('3').width('20%').height(50).backgroundColor(0xF5DEB3)
        Text('4').width('20%').height(50).backgroundColor(0xD2B48C)
        Text('5').width('20%').height(50).backgroundColor(0xF5DEB3)
        Text('6').width('20%').height(50).backgroundColor(0xD2B48C)
      }.backgroundColor(Color.Red).padding(20).margin({ top: 10 })

      //FlexDirection.RowReverse 子组件在容器主轴上反向行布局  FlexAlign.SpaceBetween 和web一样  alignItems: ItemAlign.Start
      Flex({
        direction: FlexDirection.RowReverse,
        justifyContent: FlexAlign.SpaceBetween,
        alignItems: ItemAlign.Start
      }) {
        //flexGrow 弹性空间 会将剩余空间按比例分配到对应的盒子  //flexShrink 压缩空间 放不下时各盒子压缩的比例 flexShrink(0)则不压缩
        Text('1').width('20%').height(50).backgroundColor(0xF5DEB3).flexGrow(1)
        Text('2').width('20%').height(50).backgroundColor(0xD2B48C).flexGrow(1)
        Text('3').width('20%').height(50).backgroundColor(0xF5DEB3)
        Text('4').width('20%').height(50).backgroundColor(0xD2B48C)
      }.backgroundColor(Color.Red).padding(20).margin({ top: 10 })

      // FlexDirection.Column 竖着排列
      Flex({ direction: FlexDirection.Column }) {
        Text('1').width('100%').height(40).backgroundColor(0xF5DEB3)
        Text('2').width('100%').height(40).backgroundColor(0xD2B48C)
        Text('3').width('100%').height(40).backgroundColor(0xF5DEB3)
        Text('4').width('100%').height(40).backgroundColor(0xD2B48C)
      }
      .height(160)
      .backgroundColor(Color.Red)
      .padding(20)
      .margin({ top: 10 })

      //space: { main: LengthMetrics.px(50), cross: LengthMetrics.px(50) } 设置主轴和侧轴元素间的间距
      //Flex布局设置width为 'auto' 可以让宽度自适应
      Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.px(50), cross: LengthMetrics.px(50) } }) { // 子组件多行布局
        Text('1').width('40%').height(50).backgroundColor(0xF5DEB3)
        Text('2').width('40%').height(50).backgroundColor(0xD2B48C)
        Text('3').width('40%').height(50).backgroundColor(0xD2B48C)
        Text('4').width('40%').height(50).backgroundColor(0xD2B48C)
      }
      .width("auto")
      .padding(10)
      .backgroundColor(0xAFEEEE)
    }
  }
}