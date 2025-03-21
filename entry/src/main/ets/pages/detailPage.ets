import { router } from '@kit.ArkUI';
import { paramsType } from '../viewModel/routerParamsModel'
import { TaskModel } from '../viewModel/taskModel';

@Entry
@Component
struct DetailPage {
  @State message: string = 'Hello World';

  aboutToAppear(): void {
    let params = router.getParams()
    // params.value会报错，因为arkts类型约束较为严格，路由参数传过来参数只知道是Object类型并不知道里面的东西所以在获取value是会报错
    //所以需要通过断言的方式告诉编辑器传递的参数是什么类型。 通过paramsType 泛型的方式动态的传入类型告知路由参数的数据类型。所以params.value不会报错了
    console.log('params', JSON.stringify(params))
    console.log((params as paramsType<TaskModel>).value.id)
    this.message = (params as paramsType<TaskModel>).value.taskName
  }

  build() {
    RelativeContainer() {
      Text(this.message).alignRules({
        middle: { anchor: '__container__', align: HorizontalAlign.Center },
        center: { anchor: '__container__', align: VerticalAlign.Center }
      })
    }
  }
}