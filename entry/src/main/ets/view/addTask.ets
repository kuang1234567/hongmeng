import InitData, { TodoModel } from "../viewModel/todoModel"


@Extend(Row)
function RowStyle() {
  .width('100%')
  .height(65)
  .padding({ left: 10, right: 10 })
  .margin({ bottom: 10 })
  .borderRadius(15)
  .backgroundColor(Color.White)
  .shadow({
    radius: 10,
    color: Color.Gray,
    offsetX: 0,
    offsetY: 10
  })
  .justifyContent(FlexAlign.SpaceBetween)
}

@Component
export struct AddTask {
  scroller: Scroller = new Scroller() //滚动控制器
  @StorageLink('taskList') taskList: TodoModel[] = []

  aboutToAppear(): void {
    this.taskList = InitData.initData()
  }

  build() {
    Column() {
      Button('添加任务').width('60%').margin({ bottom: 30 }).onClick(() => {
        this.taskList.push(new TodoModel(`需要去做的任务${this.taskList.length + 1}`, false))
      })
      Scroll(this.scroller) {
        Column() {
          ForEach(this.taskList, (item: TodoModel, index: number) => {
            Row() {
              AddTaskChild({ item: item, index: index })
            }.RowStyle()
          })
        }
      }
      .height(450)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }.width('100%')

  }
}

@Component
struct AddTaskChild {
  @ObjectLink item: TodoModel
  @StorageLink('taskList') taskList: TodoModel[] = []
  @Prop index: number

  build() {
    Row() {
      Text(`${this.item.todoName}`).fontSize(18).fontWeight(FontWeight.Bold)
      Checkbox({ name: 'checkbox1', group: 'checkboxGroup' })
        .select(this.item.todoStatus)
        .selectedColor('#2c71b4')
        .shape(CheckBoxShape.ROUNDED_SQUARE)
        .onChange((value: boolean) => {
          this.item.todoStatus = value
          this.taskList.splice(this.index, 1, this.item)
        })
    }.width('100%').justifyContent(FlexAlign.SpaceBetween)
  }
}