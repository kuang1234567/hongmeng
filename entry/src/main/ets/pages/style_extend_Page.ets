// @Styles
// function columnStyle() {
//   .border({
//     width: { bottom: "2" }, color: '#cccbd4'
//   })
// }

//@Extend 通常用于抽取公用组件的公共样式，必须要作用到组件，并且可以传值，继beat2版本必须声明在外部，可以抽取字体等样式 

@Extend(TextInput)
function allInputStyle() {
  .backgroundColor(Color.Transparent)
  .placeholderColor($r('app.color.text_color'))
}

@Extend(Text)
function allTextStyle(size: number) {
  .fontColor($r('app.color.title_color')).fontSize(size)
}

@Entry
@Component
struct Style_extend_Page {
  @State message: string = 'Hello World';

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

  build() {
    Column({ space: 20 }) {
      Text('新建任务').fontSize(25).fontColor($r('app.color.text_color')).fontWeight(FontWeight.Bold)
      Column({ space: 10 }) {
        Text('标题').allTextStyle(16)
        TextInput({ placeholder: '请输入任务名字' }).allInputStyle()
      }.bottomBorderStyle().alignItems(HorizontalAlign.Start)

      Column({ space: 10 }) {
        Text('日期').allTextStyle(16)
        TextInput({ placeholder: '请选择日期' })
          .allInputStyle()
      }.bottomBorderStyle().alignItems(HorizontalAlign.Start)

      Column({ space: 10 }) {
        Text('时间').allTextStyle(16)
        Row() {
          //开始时间
          Row() {
            Column() {
              TextInput({ placeholder: '请选择开始时间' })
                .allInputStyle()
            }.width('48%').alignItems(HorizontalAlign.Start)
          }.bottomBorderStyle()

          //结束时间
          Row() {
            Column() {
              TextInput({ placeholder: '请选择结束时间' })
                .allInputStyle()
            }.alignItems(HorizontalAlign.Start)
          }.width('48%').bottomBorderStyle()

        }.width('100%').justifyContent(FlexAlign.SpaceBetween)
      }.alignItems(HorizontalAlign.Start)

      Column({ space: 10 }) {
        Text('描述').allTextStyle(16)
        TextInput({ placeholder: '请输入任务详情' })
          .allInputStyle()
      }.bottomBorderStyle().alignItems(HorizontalAlign.Start)
    }.width('100%').padding(10)
  }
}