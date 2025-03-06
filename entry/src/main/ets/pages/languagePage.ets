@Entry
@Component
struct LanguagePage {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Column() {
        Text($r('app.string.title')).fontColor($r('app.color.test_color'))
        TextInput({ placeholder: $r('app.string.inputPlaceholder') })
        Image($r('app.media.app_icon')).width('50')
        Text('系统颜色').fontColor($r('sys.color.warning'))
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor('red')
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    }
    .height('100%')
    .width('100%')
  }
}