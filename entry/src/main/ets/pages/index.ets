// Index.ets
// 导入页面路由模块
import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import DataUtil from '../utils/DataFormt'

@Entry
@Component
struct Index {
  @State message: string = DataUtil.DataFormat(new Date)

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        // 添加按钮，以响应用户点击
        Button() {
          Text('修改时间')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .backgroundColor('#0D9FFB')
        .width('40%')
        .height('8%')
      }.justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
      .width('100%').height('80%').onClick(()=>{
        this.message = '2025-3-4'
        console.info(`Succeeded in clicking the 'Next' button.`)
        // 跳转到第二页
        router.pushUrl({ url: 'pages/Second' }).then(() => {
          console.info('Succeeded in jumping to the second page.')

        }).catch((err: BusinessError) => {
          console.error(`Failed to jump to the second page. Code is ${err.code}, message is ${err.message}`)
        })
      })
    }
    .height('100%')
  }
}