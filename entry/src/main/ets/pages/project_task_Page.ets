import { remoteDevice } from '@kit.NearLinkKit';

@Entry
@Component
struct Project_task_Page {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Text('你好,小王').fontSize(30).fontColor('#0c0b3e').fontWeight(FontWeight.Bold)
      Text('让每天的工作效率提高').fontSize(16).fontColor('#5c5e5f')
    }.width('100%').height('100%').backgroundColor(Color.Red)
  }
}