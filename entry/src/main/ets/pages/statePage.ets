import { userClass } from '../viewModel/userModel'

@Entry
@Component
struct StatePage {
  //用@state装饰器定义的变量，代表组件内部的状态。只有变量发生变化，页面ui会进行重新渲染。
  //特点： 1.@state装饰的变量必须要有初始化。不能为空值
  //2.如果出现嵌套类型的数据结构，嵌套对象的属性变化，页面无法监测更新
  //3.标记为@state的变量默认都是私有变量，只能在组件中访问
  @State message: string = 'Hello World';
  @State user: userClass = new userClass(1, 'kuangXiaoSheng');
  //数组声明的两种方式
  @State userList: userClass[] = [new userClass(2, 'xiaXiaoWei'), new userClass(3, 'zhangXiaoYu')]
  //泛型的方式
  @State userList2: Array<userClass> = [new userClass(2, 'xiaXiaoWei'), new userClass(3, 'zhangXiaoYu')]

  //没有必要用@state修饰的就不用因为@state会更加的消耗性能
  build() {
    RelativeContainer() {
      Text(this.user.name)

    }
    .height('100%')
    .width('100%')
  }
}