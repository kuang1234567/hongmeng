import { formatDate } from '../utils/formatData'
import createTaskData, { TaskModel } from '../viewModel/taskModel'
import { Statistics } from '../view/propLinkPage'
import { TodayTask } from '../view/ForEach'
//路由通信
//在鸿蒙中有两种方案
//1.Navigation： 这种方案是目前官方推荐使用，但是这种方案涵盖的内容比较多。底部tabbar，顶部菜单，返回等等。集合了页面中各种跳转,返回，菜单等功能。
//2.router路由：router路由类似于以前vue或者react框架中提供的路由对象。在代码中调用他的api来实现路由的跳转，返回，参数的传递。 使用于多模块之间的页面切换。
//router提供了两种路由跳转方法： 1.pushUrl：代表跳转页面的时候，将老的地址和新的地址都加入到页面执行栈中。可以实现跳转后记录信息，可以返回到指定的页面。
//                          2.replaceUrl：代表替换当前这个页面的地址。直接覆盖访问地址。无法记录历史。无法返回跳转之前的页面
//router的模式：
//1.Standard：多实例模式，按pushUrl来跳转，每次跳转路径都会放在执行栈中，不会管执行栈中是否存在同样的路由路径。
//2.single：单实例模式，按pushUrl来跳转，每次跳转的路径都会放在执行栈，如果下次访问同一个路径，默认将执行栈中存在的路径放在栈顶。执行栈中同样的路径之后值存在一个。
import { router } from '@kit.ArkUI';

@Extend(Text)
function TextTitleStyle(size: number) {
  .fontSize(size).fontColor('#0c0b3e').fontWeight(FontWeight.Bold)
}

@Entry
@Component
struct Project_task_Page {
  @StorageLink('taskList') taskList: Array<TaskModel> = []

  /**
   * @description: 获取今日任务
   */
  getTodayTaskList() {
    let today = formatDate(new Date().getTime(), 'yyyy-mm-dd')
    let arr = this.taskList.filter((item) => {
      return item.taskTime == today
    })
    return arr
  }

  aboutToAppear(): void {
    //模拟假数据
    this.taskList = createTaskData.initData()
  }

  build() {
    RelativeContainer() {
      Column() {
        Text('你好,小王').margin({ bottom: 15 }).TextTitleStyle(30)
        Text('让每天的工作效率提高').fontSize(16).fontColor('#5c5e5f').margin({ bottom: 15 })
        Statistics({ title: '我的计划', taskList: this.taskList })
        Row() {
          Text('今日任务').TextTitleStyle(26)
          Text('查看更多').fontSize(16).fontColor('#0c0b3e')
        }
        .width('100%')
        .margin({ top: 15, bottom: 15 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Bottom)

        TodayTask({ taskList: this.getTodayTaskList() })

      }
      .width('100%')
      .height('100%')
      .padding(10)
      .backgroundColor('#eef0f2')
      .alignItems(HorizontalAlign.Start)

      //添加按钮
      Stack() {
        Column().width(50).height(50).backgroundColor('#4f55c4').borderRadius('50%')
        Text('+').fontSize(40).fontWeight(FontWeight.Bold).fontColor(Color.White)
      }.alignRules({
        right: { anchor: '__container__', align: HorizontalAlign.End },
        bottom: { anchor: '__container__', align: VerticalAlign.Bottom }
      }).offset({ x: -20, y: -20 }).onClick(() => {
        router.pushUrl({
          url: 'pages/CalendarPicker_DatePicker_Page'
        }, router.RouterMode.Standard, (err) => {
          if (err) {
            console.log('跳转报错', err)
          }
        })
        // router.replaceUrl({
        //   url: 'pages/CalendarPicker_DatePicker_Page'
        // })
      })
    }
  }
}