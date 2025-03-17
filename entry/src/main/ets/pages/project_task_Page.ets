import { formatDate } from '../utils/formatData'
import createTaskData from '../viewModel/taskModel'

@Extend(Text)
function TextTitleStyle(size: number) {
  .fontSize(size).fontColor('#0c0b3e').fontWeight(FontWeight.Bold)
}

@Extend(Column)
function ColumnTtiemtyle(itemWidth: string, itemHeight: string, itemColor: string) {
  .width(itemWidth)
  .height(itemHeight)
  .alignItems(HorizontalAlign.Start)
  .backgroundColor(itemColor)
  .borderRadius(20)
  .justifyContent(FlexAlign.SpaceAround)
  .padding(10)
}

@Entry
@Component
struct Project_task_Page {
  // @State message: string = 'Hello World';
  scroller: Scroller = new Scroller()
  private taskArr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

  aboutToAppear(): void {
    //模拟假数据
    console.log('TaskList', JSON.stringify(createTaskData.initData()))
  }

  build() {
    Column() {
      Text('你好,小王').margin({ bottom: 15 }).TextTitleStyle(30)
      Text('让每天的工作效率提高').fontSize(16).fontColor('#5c5e5f').margin({ bottom: 15 })
      Text('我的计划').TextTitleStyle(26)
      Row() {
        Column() {
          Column() {
            Image($r('app.media.app_icon')).width(70)
            Text(`已完成`).TextTitleStyle(18)
            Text(`${0}任务`).fontSize(16)
          }.ColumnTtiemtyle('100%', '55%', '#85c9e5')

          Column() {
            Image($r('app.media.app_icon')).width(40)
            Text(`等待中`).TextTitleStyle(18)
            Text(`${0}任务`).fontSize(16)
          }.ColumnTtiemtyle('100%', '40%', '#e78685')
        }.width('49%').height('100%').justifyContent(FlexAlign.SpaceBetween)

        Column() {
          Column() {
            Image($r('app.media.app_icon')).width(40)
            Text(`未完成`).TextTitleStyle(18)
            Text(`${0}任务`).fontSize(16)
          }.ColumnTtiemtyle('100%', '40%', '#717ce7')

          Column() {
            Image($r('app.media.app_icon')).width(70)
            Text(`未来任务`).TextTitleStyle(18)
            Text(`${0}任务`).fontSize(16)
          }.ColumnTtiemtyle('100%', '55%', '#a7e9ba')

        }.width('49%').height('100%').justifyContent(FlexAlign.SpaceBetween)
      }.width('100%').height(300).justifyContent(FlexAlign.SpaceBetween)

      Row() {
        Text('今日任务').TextTitleStyle(26)
        Text('查看更多').fontSize(16).fontColor('#0c0b3e')
      }
      .width('100%')
      .margin({ top: 15, bottom: 15 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Bottom)

      Scroll(this.scroller) {
        Column() {
          ForEach(this.taskArr, (item: number) => {
            Column({ space: 10 }) {
              Row() {
                Image($r('app.media.app_icon')).width(30).height(20).margin({ right: 20 })
                Text('完成HarmonyOS第一阶段项目').TextTitleStyle(16)
              }.width('100%')

              Text(`9:00-12:00`).fontColor('#787878')
              Button('生活').width(80).height(25).backgroundColor('#9a2323')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .backgroundColor(Color.White)
            .borderRadius(15)
            .padding(10)
            .margin({ bottom: 10 })
          }, (item: string) => item)
        }
      }.scrollBar(BarState.Off).edgeEffect(EdgeEffect.Spring).width('100%').height(230)

    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundColor('#eef0f2')
    .alignItems(HorizontalAlign.Start)
  }
}