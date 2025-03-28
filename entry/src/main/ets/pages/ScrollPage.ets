// xxx.ets
import { curves } from '@kit.ArkUI'

@Entry
@Component
struct ScrollExample {
  scroller: Scroller = new Scroller() //滚动控制器
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Scroll(this.scroller) {
        Column() {
          ForEach(this.arr, (item: number) => {
            Text(item.toString())
              .width('90%')
              .height(150)
              .backgroundColor(0xFFFFFF)
              .borderRadius(15)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .margin({ top: 10 })
          }, (item: string) => item)
        }.width('100%')
      }
      .align(Alignment.Top) //滚动内容的对齐方式
      .scrollable(ScrollDirection.Vertical) // 滚动方向纵向
      .scrollBar(BarState.On) // 滚动条常驻显示 显示为On ，不显示为Off
      .scrollBarColor(Color.Gray) // 滚动条颜色
      .scrollBarWidth(10) // 滚动条宽度
      .friction(0.6) //摩擦系数 越小滚动的越快
      .edgeEffect(EdgeEffect.Spring) //滚动到边缘位置的效果
      .onWillScroll((xOffset: number, yOffset: number, scrollState: ScrollState) => {
        //即将滚动时触发的事件 其中的xOffset yOffset是根据摩擦系数力量等计算预估的值
        // console.info(xOffset + ' ' + yOffset)
      })
      .onDidScroll((xOffset: number, yOffset: number, scrollState: ScrollState) => {
        //滚动时触发 其中的xOffset yOffset是真实滚动的距离
        console.info('Did', xOffset + ' ' + yOffset)
      })
      .onScrollEdge((side: Edge) => {
        //滚动到边缘触发 滚动到底
        console.info('To the edge')
      })
      .onScrollStop(() => {
        //滚动停止触发
        console.info('Scroll Stop')
      })

      Button('scroll 150')
        .height('5%')
        .onClick(() => { // 点击后下滑指定距离150.0vp
          this.scroller.scrollBy(0, 150)
        })
        .margin({ top: 10, left: 20 })
      Button('scroll 100')
        .height('5%')
        .onClick(() => { // 点击后滑动到指定位置，即下滑100.0vp的距离
          const yOffset: number = this.scroller.currentOffset().yOffset; //获取当前的滚动距离
          this.scroller.scrollTo({ xOffset: 0, yOffset: yOffset + 100 })
        })
        .margin({ top: 60, left: 20 })
      Button('scroll 100')
        .height('5%')
        .onClick(() => { // 点击后滑动到指定位置，即下滑100.0vp的距离，滑动过程配置有动画
          let curve = curves.interpolatingSpring(10, 1, 228, 30) //创建一个阶梯曲线
          const yOffset: number = this.scroller.currentOffset().yOffset;
          this.scroller.scrollTo({ xOffset: 0, yOffset: yOffset + 100, animation: { duration: 1000, curve: curve } })
        })
        .margin({ top: 110, left: 20 })
      Button('back top')
        .height('5%')
        .onClick(() => { // 点击后回到顶部
          this.scroller.scrollEdge(Edge.Top)
        })
        .margin({ top: 160, left: 20 })
      Button('next page')
        .height('5%')
        .onClick(() => { // 点击后滑到下一页
          this.scroller.scrollPage({ next: true })
        })
        .margin({ top: 210, left: 20 })
      Button('fling -3000')
        .height('5%')
        .onClick(() => { // 点击后触发初始速度为-3000vp/s的惯性滚动
          this.scroller.fling(-3000)
        })
        .margin({ top: 260, left: 20 })
      Button('scroll to bottom 700')
        .height('5%')
        .onClick(() => { // 点击后滑到下边缘，速度值是700vp/s
          this.scroller.scrollEdge(Edge.Bottom, { velocity: 700 })
        })
        .margin({ top: 310, left: 20 })
    }.width('100%').height('100%').backgroundColor(0xDCDCDC)
  }
}