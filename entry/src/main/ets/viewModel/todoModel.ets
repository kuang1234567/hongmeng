@Observed
export class TodoModel {
  todoName: string
  todoStatus: boolean

  constructor(todoName: string, todoStatus: boolean) {
    this.todoName = todoName
    this.todoStatus = todoStatus
  }

  initData() {
    let arr: TodoModel[] = []
    for (let index = 0; index < 1; index++) {
      arr.push(new TodoModel(`需要去做的任务${index + 1}`, false))
    }
    return arr
  }
}

export default new TodoModel(`初始化数据`, false)
