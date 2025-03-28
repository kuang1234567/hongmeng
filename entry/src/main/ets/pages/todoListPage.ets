import { AddTask } from '../view/addTask';
import { TaskProgress } from '../view/TaskProgress'

@Entry
@Component
struct TodoListPage {
  build() {
    Column() {
      TaskProgress()
      AddTask()
    }
    .width('100%').height('100%').backgroundColor('#ecf4fe').padding(15)
  }
}