import { TodoModel } from "../viewModel/todoModel"

@Component
export struct TaskProgress {
  @StorageLink('taskList') taskList: TodoModel[] = []

  aboutToDisappear(): void {

  }

  computedDoneCount() {
    let count = this.taskList.reduce((sum: number, item: TodoModel) => {
      if (item.todoStatus) {
        sum += 1
      }
      return sum
    }, 0)
    return count
  }

  build() {
    Row({ space: 25 }) {
      Text('任务进度:').fontSize(34).fontWeight(FontWeight.Bold)
      Stack() {
        Progress({ value: this.computedDoneCount(), total: this.taskList.length, type: ProgressType.Ring })
          .width(100)
          .color('#2c71b3')
          .style({
            strokeWidth: 10,
            enableScanEffect: true,
          })
        Row({ space: 5 }) {
          Text(this.computedDoneCount().toString()).fontSize(24).fontColor('#5d5892')
          Text(`/`).fontSize(24)
          Text(this.taskList.length.toString()).fontSize(24)
        }
      }

    }
    .width('100%')
    .height(130)
    .backgroundColor(Color.White)
    .borderRadius(15)
    .justifyContent(FlexAlign.Center)
    .shadow({
      radius: 10,
      color: Color.Gray,
      offsetX: 0,
      offsetY: 10
    })
    .margin({ bottom: 30 })
  }
}