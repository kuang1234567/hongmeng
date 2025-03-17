import { formatDate } from '../utils/formatData'

enum taskStatusENum {
  DONE = 'done',
  UNDONE = 'undone',
  DOING = 'doing',
  FUTURE = 'future'
}

export class TaskModel {
  //每个任务的编号
  id: string = ''
  //每个任务的名字
  taskName: string = ''
  //每个任务日期
  taskTime: string = ''
  //任务详情
  taskMsg: string = ''
  //任务开始时间
  taskBeginDate: string = ''
  //任务结束时间
  taskEndDate: string = ''
  //任务类型 1：生活类型 2：工作类型
  taskType: number = 1
  //任务的标签 生活 学习 娱乐
  taskTitle: number = 1
  //任务的状态： done完成 undone 未完成 doing 正在进行 future 未来任务
  taskStatus: string = ''

  constructor(id: string, taskName: string, taskTime: string, taskMsg: string, taskBeginDate: string,
    taskEndDate: string, taskType: number, taskTitle: number) {
    this.id = id
    this.taskName = taskName
    this.taskTime = taskTime
    this.taskMsg = taskMsg
    this.taskBeginDate = taskBeginDate
    this.taskEndDate = taskEndDate
    this.taskType = taskType
    this.taskTitle = taskTitle
    this.updateTaskStatus()
  }

  /**
   * @description: 处理任务状态
   */
  updateTaskStatus() {
    //相同格式的日期字符串可以直接比较
    let currentTime = formatDate(new Date().getTime(), 'yyyy-mm-dd')

    if (this.taskTime > currentTime) {
      this.taskStatus = taskStatusENum.FUTURE
    } else if (this.taskTime == currentTime) {
      this.taskStatus = taskStatusENum.DOING
    } else if (this.taskTime < currentTime) {
      this.taskStatus = taskStatusENum.UNDONE
    }
  }
}

/**
 * @description: 模拟数据
 */

class createTaskModel {
  private taskList: TaskModel[] = []

  initData() {
    for (let index = 0; index < 20; index++) {
      let task =
        new TaskModel(`${index + 1}`, `计划要完成的任务${index + 1}`, `2025-7-26`, `这是任务的详情${index + 1}`,
          `09:00`, `12:00`, 1, 1,)
      this.taskList.push(task)
    }

    return this.taskList
  }
}

export default new createTaskModel()