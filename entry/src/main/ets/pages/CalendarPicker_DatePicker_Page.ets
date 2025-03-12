@Extend(TextInput)
function inputStyle() {
  .backgroundColor(Color.Transparent)
  .placeholderColor($r('app.color.text_color'))
}

@Extend(Text)
function textStyle(size: number) {
  .fontColor($r('app.color.title_color')).fontSize(size)
}

@Entry
@Component
struct CalendarPicker_DatePicker_Page {
  @State message: string = 'Hello World';
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
        console.log('accept', value)
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
  openDatapicker = () => {
    TimePickerDialog.show({
      selected: this.selectedDate,
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
      }
    })
  }

  build() {
    Column({ space: 20 }) {
      Text('新建任务').fontSize(25).fontColor($r('app.color.text_color')).fontWeight(FontWeight.Bold)
      Column({ space: 10 }) {
        Text('标题').textStyle(16)
        TextInput({ placeholder: '请输入任务名字' }).inputStyle()
      }.bottomBorderStyle().alignItems(HorizontalAlign.Start)

      Column({ space: 10 }) {
        Text('日期').textStyle(16)
        TextInput({ placeholder: '请选择日期' })
          .inputStyle().onClick(this.openDatapicker)
      }.bottomBorderStyle().alignItems(HorizontalAlign.Start)

      Column({ space: 10 }) {
        Text('时间').textStyle(16)
        Row() {
          //开始时间
          Row() {
            Column() {
              TextInput({ placeholder: '请选择开始时间' })
                .inputStyle().onClick(this.openCalendarPicker)
            }.width('48%').alignItems(HorizontalAlign.Start)
          }.bottomBorderStyle()

          //结束时间
          Row() {
            Column() {
              TextInput({ placeholder: '请选择结束时间' })
                .inputStyle().onClick(this.openCalendarPicker)
            }.alignItems(HorizontalAlign.Start)
          }.width('48%').bottomBorderStyle()

        }.width('100%').justifyContent(FlexAlign.SpaceBetween)
      }.alignItems(HorizontalAlign.Start)

      Column({ space: 10 }) {
        Text('描述').textStyle(16)
        Row() {
          Row() {
            //当前单选框的所属群组名称，相同group的Radio只能有一个被选中。
            //自定义样式可以用contentModifier 详细看文档
            Radio({
              value: 'Radio1', group: 'radioGroup',
              indicatorType: RadioIndicatorType.DOT //选中样式
            }).checked(true).radioStyle({
              checkedBackgroundColor: Color.Pink
            }).onChange((isChecked: boolean) => {
              console.log('Radio1 status is ' + isChecked)
            })
            Text('个人任务').fontWeight(FontWeight.Bold)
          }

          Row() {
            Radio({
              value: 'Radio2', group: 'radioGroup'
            }).onChange((isChecked: boolean) => {
              console.log('Radio2 status is ' + isChecked)
            })
            Text('工作任务').fontWeight(FontWeight.Bold)
          }
        }.width('100%').justifyContent(FlexAlign.SpaceBetween)
      }.alignItems(HorizontalAlign.Start)
    }.width('100%').padding(10)
  }
}