import { Student, Pet, ObjectClass } from '../viewModel/observedModel'
import { ObjectLinkChild } from '../view/ObjectLinkChild'

@Entry
@Component
struct ObservedObjectLinkPage {
  //在鸿蒙开发中@State装饰的变量，一旦变量发生改变页面更新。但仅能观察到第一层的变化，遇到复杂数据结构，数据更新会有差别。
  @State student: Student = new Student('001', '小王八', new Pet('1', '金毛'))
  @State schoolStudentList: Student[] =
    [new Student('002', '小贝贝', new Pet('1', '拉布拉多')), new Student('003', '小笔笔', new Pet('1', '哈士奇')),]

  build() {
    Column() {
      Text(`${JSON.stringify(this.student)}`)
      //修改学生名字页面会更新，因为学生的名字只在第一层
      Text(`学生名字：${this.student.name}`).fontSize(30)
      Button('修改学生的名字').onClick(() => {
        this.student.name = '小王把'
      })
      //修改宠物名字页面不会发生改变，因为宠物是对象里面套的对象，修改鸿蒙监听不到。需要用到@Obserbed和@OobjectLink来实现深度监听
      Text(`学生宠物名字：${this.student.pet.name}`).fontSize(30)
      Button('修改学生宠物的名字').onClick(() => {
        this.student.pet.name = '泰迪'
      })
      //使用@Observed装饰class会改变class原始的原型链，@Observed和其他类装饰器装饰同一个class可能会带来问题
      //嵌套对象的解决： 在Pet类上加上@Observed，@ObjectLink放在组件中定义数据，因为@ObjectLink无法在@entey组件中使用
      EditPetName({ pet: this.student.pet })
      //数据对象的解决: 在Sturent类上加@Observed
      Text(`${JSON.stringify(this.schoolStudentList)}`)
      ForEach(this.schoolStudentList, (item: Student, index) => {
        ObjectLinkChild({ student: item, index: index })
      }, (item: Student) => {
        return item.id
      })
    }
    .height('100%')
    .width('100%')
  }
}

@Component
struct EditPetName {
  //@ObjectLink放在组件中定义数据, 并且只会影响子组件数据试图更新，父组件的试图不会更新
  @ObjectLink pet: Pet

  build() {
    Column() {
      Text(`学生宠物名字：${this.pet.name}`).fontSize(30).fontColor(Color.Red)
      Button('修改学生宠物的名字').onClick(() => {
        this.pet.name = '泰迪'
      })
    }
  }
}