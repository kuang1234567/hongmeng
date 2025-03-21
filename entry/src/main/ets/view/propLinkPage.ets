import { TaskModel } from "../viewModel/taskModel"

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

@Extend(Text)
function TextTitleStyle(size: number) {
  .fontSize(size).fontColor('#0c0b3e').fontWeight(FontWeight.Bold)
}

@Component
export struct Statistics {
  //@Prop只能再@Compnent组件使用，不能再@entry组件中使用
  //@Prop来定义变量，可以默认部初始化。用来代表接受外部数据
  //@Prop来定义数据，可以进行修改。但试只能影响本组件，无法同步给夫组件
  @Prop title: string = ''
  //@Link只能再@Compnent组件使用，不能再@entry组件中使用
  //@Link来定义变量，不能默认初始化数据  需要初始化数据的话在生命周期中进行赋值
  //@Link来定义数据，可以进行修改。不管父组件还是子组件数据都是同步变化 实现双向数据流
  @Link taskList: Array<TaskModel>

  //计算各项任务的值
  computeStatusCount(status: string) {
    let count = this.taskList.reduce((sum: number, item: TaskModel) => {
      if (item.taskStatus === status) {
        sum += 1
      }
      return sum
    }, 0)
    return count
  }

  build() {
    Column() {
      Text(this.title).TextTitleStyle(26).margin({ bottom: 10 })
      Row() {
        Column() {
          Column() {
            Image($r('app.media.app_icon')).width(70)
            Text(`已完成`).TextTitleStyle(18)
            Text(`${this.computeStatusCount('done')}任务`).fontSize(16)
          }.ColumnTtiemtyle('100%', '55%', '#85c9e5')

          Column() {
            Image($r('app.media.app_icon')).width(40)
            Text(`等待中`).TextTitleStyle(18)
            Text(`${this.computeStatusCount('doing')}任务`).fontSize(16)
          }.ColumnTtiemtyle('100%', '40%', '#e78685')
        }.width('49%').height('100%').justifyContent(FlexAlign.SpaceBetween)

        Column() {
          Column() {
            Image($r('app.media.app_icon')).width(40)
            Text(`未完成`).TextTitleStyle(18)
            Text(`${this.computeStatusCount('undone')}任务`).fontSize(16)
          }.ColumnTtiemtyle('100%', '40%', '#717ce7')

          Column() {
            Image($r('app.media.app_icon')).width(70)
            Text(`未来任务`).TextTitleStyle(18)
            Text(`${this.computeStatusCount('future')}任务`).fontSize(16)
          }.ColumnTtiemtyle('100%', '55%', '#a7e9ba')

        }.width('49%').height('100%').justifyContent(FlexAlign.SpaceBetween)
      }.width('100%').height(300).justifyContent(FlexAlign.SpaceBetween)
    }.alignItems(HorizontalAlign.Start)
  }
}