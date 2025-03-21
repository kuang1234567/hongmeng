import { TaskModel } from '../viewModel/taskModel'
import { router } from '@kit.ArkUI';

@Extend(Text)
function TextTitleStyle(size: number) {
  .fontSize(size).fontColor('#0c0b3e').fontWeight(FontWeight.Bold)
}

@Component
export struct TodayTask {
  scroller: Scroller = new Scroller()
  @Prop taskList: TaskModel[]

  build() {
    Scroll(this.scroller) {
      Column() {
        ForEach(this.taskList, (item: TaskModel, index: number) => {
          Column({ space: 10 }) {
            Row() {
              Image($r('app.media.app_icon')).width(30).height(20).margin({ right: 20 })
              Text(`${item.taskName}`).TextTitleStyle(16)
            }.width('100%')

            Text(`${item.taskBeginDate}-${item.taskEndDate}`).fontColor('#787878')
            Button(item.taskTitle == 1 ? '工作' : item.taskTitle == 2 ?
              '学习' : '娱乐').width(80).height(25).backgroundColor('#9a2323')
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .backgroundColor(Color.White)
          .borderRadius(15)
          .padding(10)
          .margin({ bottom: 10 })
          .onClick(() => {
            router.pushUrl({
              url: "pages/detailPage",
              params: { value: item }
            })
          })
        }, (item: TaskModel) => item.id)
      }
    }.scrollBar(BarState.Off).edgeEffect(EdgeEffect.Spring).width('100%').height(230)
  }
}