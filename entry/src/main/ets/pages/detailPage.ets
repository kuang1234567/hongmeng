import { router } from '@kit.ArkUI';
import { paramsType } from '../viewModel/routerParamsModel'
import { TaskModel } from '../viewModel/taskModel';

@Extend(Column)
function ColumnItemStyle() {
  .width('49%')
  .height(80)
  //angle: 线性渐变的起始角度。0点方向顺时针旋转为正向角度。默认值：180，角度为字符串时仅支持类型deg，grad，rad，trun。
  //
  // direction: 线性渐变的方向，设置angle后不生效。默认值：GradientDirection.Bottom
  //
  // colors: 指定某百分比位置处的渐变色颜色,设置非法颜色直接跳过。
  //
  // repeating: 为渐变的颜色重复着色。默认值：false
  //还有角度渐变和经向渐变 可查看https://blog.csdn.net/harmonyClassRoom/article/details/144316515
  .linearGradient({
    angle: 180, //默认显示颜色的时候，按照180度的角度渲染
    colors: [['#ee8888', 0.0], ['#ffbc6262', 1.0]] //二维数组中第一个颜色值，第二个代表颜色范围
  })
  .borderRadius(15)
  .padding({ left: 15 })
  .alignItems(HorizontalAlign.Start)
  .justifyContent(FlexAlign.Center)
}

@Extend(Text)
function textTabStyle(bacColor: string) {
  .fontColor('#ffffff')
  .backgroundColor(bacColor)
  .borderRadius(5)
  .padding({
    top: 3,
    right: 15,
    left: 15,
    bottom: 3
  })
  .margin({ right: 20 })
}

@Entry
@Component
struct DetailPage {
  @State taskDetail: TaskModel | null = null //利用联合类型来声明不用去new TaskModel
  @StorageLink('taskList') taskList: Array<TaskModel> = []

  aboutToAppear(): void {
    let params = router.getParams()
    // params.value会报错，因为arkts类型约束较为严格，路由参数传过来参数只知道是Object类型并不知道里面的东西所以在获取value是会报错
    //所以需要通过断言的方式告诉编辑器传递的参数是什么类型。 通过paramsType 泛型的方式动态的传入类型告知路由参数的数据类型。所以params.value不会报错了
    console.log('params', JSON.stringify(params))
    console.log((params as paramsType<TaskModel>).value.id)
    let obj = params as paramsType<TaskModel>
    this.taskDetail = obj.value
  }

  build() {
    Column({ space: 10 }) {
      Row() {
        Text('返回').padding(10).backgroundColor('#ffffff').borderRadius(10).onClick(() => {
          //router.back() //如果这里用router.back()的话会有bug再次点击进来修改并没有变，因为记录了之前的页面传过来的参数还是之前的对象
          router.pushUrl({
            url: "pages/project_task_Page"
          })
        })
        Text('任务详情').fontSize(20).fontColor($r('app.color.text_color')).fontWeight(FontWeight.Bold)
      }.width('100%').justifyContent(FlexAlign.SpaceBetween)

      Text(`${this.taskDetail?.taskName}`).fontSize(20).fontColor('#28314d').fontWeight(FontWeight.Bold)
      Text('生活类型').fontSize(16).fontColor($r('app.color.title_color'))
      Row() {
        Column({ space: 10 }) {
          Text('开始时间').fontSize(20).fontColor('rgba(255,255,255,0.5)')
          Text(`${this.taskDetail?.taskBeginDate}`).fontSize(20).fontColor(Color.White).fontWeight(FontWeight.Bold)
        }.ColumnItemStyle()

        Column({ space: 10 }) {
          Text('结束时间').fontSize(20).fontColor('rgba(255,255,255,0.5)')
          Text(`${this.taskDetail?.taskEndDate}`).fontSize(20).fontColor(Color.White).fontWeight(FontWeight.Bold)
        }.ColumnItemStyle()
      }.width('100%').justifyContent(FlexAlign.SpaceBetween)

      Text('任务状态').fontSize(20).fontColor('#28314d').fontWeight(FontWeight.Bold)
      Toggle({ type: ToggleType.Switch, isOn: this.taskDetail?.taskStatus == 'done' })
        .selectedColor('#ed8687')
        .onChange((isOn: boolean) => {
          this.taskDetail = (this.taskDetail as TaskModel)
          let index = this.taskList.findIndex((item) => {
            return this.taskDetail?.id == item.id
          })
          console.log('index', index)
          if (isOn) {
            // 需要执行的操作
            this.taskDetail.taskStatus = 'done'
            this.taskList.splice(index, 1, this.taskDetail)
          } else {
            this.taskDetail.taskStatus = 'doing'
            this.taskList.splice(index, 1, this.taskDetail)
          }
        })
      Text(`未完成，滑动修改状态`)
      Text('任务标签').fontSize(20).fontColor('#28314d').fontWeight(FontWeight.Bold)
      Row() {
        if (this.taskDetail?.taskTitle == 1) {
          Text('工作')
            .textTabStyle('#982227')
        } else if (this.taskDetail?.taskTitle == 2) {
          Text('学习')
            .textTabStyle('#629755')
        } else {
          Text('娱乐')
            .textTabStyle('#6897bb')
        }
      }.justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#eef0f2')
    .padding(10)
    .alignItems(HorizontalAlign.Start)
  }
}