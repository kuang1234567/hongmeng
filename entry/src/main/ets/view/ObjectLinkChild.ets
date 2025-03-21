import { Student, Pet } from '../viewModel/observedModel'

@Component
export struct ObjectLinkChild {
  //在子组件中给@ObjectLink装饰的变量赋值
  @ObjectLink student: Student
  @Prop index: number

  build() {
    Column() {
      Text(`学生名字：${this.student.name}`).fontSize(30)
      Button('修改学生名字').onClick(() => {
        this.student.name = this.student.name + `${this.index}`
      })
    }
    .width('100%')
  }
}