import { formatDate, transformHoursAndMinutes } from '../utils/formatData'
import { router } from '@kit.ArkUI';
import { TaskModel } from '../viewModel/taskModel'

@Extend(TextInput)
function inputStyle() {
  .backgroundColor(Color.Transparent)
  .placeholderColor($r('app.color.text_color'))
}

@Extend(Text)
function textStyle(size: number) {
  .fontColor($r('app.color.title_color')).fontSize(size)
}

@Extend(Text)
function textTabStyle(bacColor: string, tabActive: number, tabIndex: number) {
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
  .border({ width: 2, color: tabActive == tabIndex ? Color.Red : Color.White })
}

@Entry
@Component
struct CalendarPicker_DatePicker_Page {
  @State tabActive: number = 0
  @State taskObj: TaskModel = new TaskModel(``, ``, '', ``, ``, ``, 1, 1)
  @StorageLink('taskList') taskList: TaskModel[] = []
  private selectedDate: Date = new Date()

  //@styles 抽取公共样式 注意：通常只抽取column 和 row 上面的公共属性，如width，height，border等，fontSize等字体样式和对齐样式不支持抽取，会报错
  //因为有些组件上面并没有字体等属性。
  //可以声明在文件内部也可以声明在文件外部 (如上注释写法) 只能声明在当前文件不支持引入
  //不可以传递参数
  @Styles
  bottomBorderStyle() {
    .border({
      width: { bottom: "2" }, color: '#cccbd4'
    })
  }

  /**
   * @description: 打开日历选择器
   */
  openCalendarPicker = () => {
    CalendarPickerDialog.show({
      selected: this.selectedDate,
      onAccept: (value) => {
        //点击确认
        this.taskObj.taskTime = formatDate(value.getTime(), 'yyyy-mm-dd')
      },
      onChange: (value) => {
        //选择改变之后
        console.log('change', value)
      },
      onCancel: () => {
        //取消
        console.log('cancel')
      },
      onDidAppear: () => {
        //弹窗弹出时的事件回调   onDidDisappear是弹出窗消失回调
        console.log('DidAppear')
      }
    })
  }
  /**
   * @description: 打开时间选择器
   */
  openDatePicker = (type: string) => {
    TimePickerDialog.show({
      // selected: this.selectedDate, //选择当前时间
      useMilitaryTime: true,
      disappearTextStyle: {
        //设置所有选项中最上和最下两个选项的文本颜色、字号、字体粗细
        color: Color.Red,
        font: {
          size: '14fp',
          weight: FontWeight.Regular
        }

      },
      textStyle: {
        //设置所有选项中除了最上、最下及选中项以外的文本颜色、字号、字体粗细。
        color: Color.Green,
        font: {
          size: '30fp',
          weight: FontWeight.Regular
        }
      },
      selectedTextStyle: {
        //设置选中项的文本颜色、字号、字体粗细
        color: Color.Blue,
      },
      onAccept: (value) => {
        console.log('accept', JSON.stringify(value))
        let hour = transformHoursAndMinutes(value.hour)
        let minute = transformHoursAndMinutes(value.minute)
        if (type == 'begin') {
          this.taskObj.taskBeginDate = `${hour}:${minute}`
        } else {
          this.taskObj.taskEndDate = `${hour}:${minute}`
        }

      }
    })
  }

  build() {
    Column({ space: 20 }) {
      Text('新建任务').fontSize(25).fontColor($r('app.color.text_color')).fontWeight(FontWeight.Bold)
      Column({ space: 10 }) {
        Text('标题').textStyle(16)
        //鸿蒙开发也满足mvvm的思想 $$为双向绑定 绑定的值改变会影响页面试图（view） 试图改变也会影响数据模型（viewModel）
        TextInput({ placeholder: '请输入任务名字', text: $$this.taskObj.taskName }).inputStyle()
      }.bottomBorderStyle().alignItems(HorizontalAlign.Start)

      Column({ space: 10 }) {
        Text('日期').textStyle(16)
        TextInput({ placeholder: '请选择日期', text: $$this.taskObj.taskTime })
          .focusable(false)
          .inputStyle().onClick(this.openCalendarPicker)
      }.bottomBorderStyle().alignItems(HorizontalAlign.Start)

      Column({ space: 10 }) {
        Text('时间').textStyle(16)
        Row() {
          //开始时间
          Row() {
            Column() {
              TextInput({ placeholder: '请选择开始时间', text: $$this.taskObj.taskBeginDate })
                .focusable(false)
                .inputStyle().onClick(() => this.openDatePicker('begin'))
            }.width('48%').alignItems(HorizontalAlign.Start)
          }.bottomBorderStyle()

          //结束时间
          Row() {
            Column() {
              TextInput({ placeholder: '请选择结束时间', text: $$this.taskObj.taskEndDate }).focusable(false)
                .inputStyle().onClick(() => this.openDatePicker('end'))
            }.alignItems(HorizontalAlign.Start)
          }.width('48%').bottomBorderStyle()

        }.width('100%').justifyContent(FlexAlign.SpaceBetween)
      }.alignItems(HorizontalAlign.Start)

      Column({ space: 10 }) {
        Text('详情').textStyle(16)
        //鸿蒙开发也满足mvvm的思想 $$为双向绑定 绑定的值改变会影响页面试图（view） 试图改变也会影响数据模型（viewModel）
        TextInput({ placeholder: '请输入任务详情', text: $$this.taskObj.taskMsg }).inputStyle()
      }.bottomBorderStyle().alignItems(HorizontalAlign.Start)

      Column({ space: 10 }) {
        Text('描述').textStyle(16)
        Row() {
          Row() {
            //当前单选框的所属群组名称，相同group的Radio只能有一个被选中。
            //自定义样式可以用contentModifier 详细看文档
            Radio({
              value: 'Radio1', group: 'radioGroup',
              indicatorType: RadioIndicatorType.DOT //选中样式
            }).checked(this.taskObj.taskType === 1 ? true : false).radioStyle({
              checkedBackgroundColor: Color.Pink
            }).onChange((isChecked: boolean) => {
              console.log('Radio1 status is ' + isChecked)
              if (isChecked) {
                this.taskObj.taskType = 1
              }
            })
            Text('个人任务').fontWeight(FontWeight.Bold)
          }

          Row() {
            Radio({
              value: 'Radio2', group: 'radioGroup'
            }).onChange((isChecked: boolean) => {
              console.log('Radio2 status is ' + isChecked)
              if (isChecked) {
                this.taskObj.taskType = 2
              }
            })
            Text('工作任务').fontWeight(FontWeight.Bold)
          }
        }.width('100%').justifyContent(FlexAlign.SpaceBetween)
      }.alignItems(HorizontalAlign.Start)

      Column({ space: 10 }) {
        Text('标签').textStyle(16)
        Row() {
          Text('工作')
            .textTabStyle('#982227', this.tabActive, 1)
            .onClick(() => {
              this.tabActive = 1
              this.taskObj.taskTitle = 1
            })
          Text('学习')
            .textTabStyle('#629755', this.tabActive, 2).onClick(() => {
            this.tabActive = 2
            this.taskObj.taskTitle = 2
          })
          Text('娱乐')
            .textTabStyle('#6897bb', this.tabActive, 3)
            .onClick(() => {
              this.tabActive = 3
              this.taskObj.taskTitle = 3
            })
        }.justifyContent(FlexAlign.SpaceBetween)
      }.width('100%').alignItems(HorizontalAlign.Start)

      Button('创建任务', {
        type: ButtonType.Normal
      }).width(200).borderRadius(10).backgroundColor('#121451').onClick(() => {
        this.taskObj.id = new Date().getTime().toString()
        console.log('taskonbj', JSON.stringify(this.taskObj))
        this.taskList.push(this.taskObj)
        router.pushUrl({
          url: "pages/project_task_Page"
        })
      })
    }.width('100%').padding(10)
  }
}