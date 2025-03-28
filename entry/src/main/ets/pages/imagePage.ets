@Entry
@Component
struct ImagePage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      //获取网络图片或者发送请求我们需要在 module.json5中声明网络请求权限
      //"requestPermissions": [
      //       {
      //         "name" : "ohos.permission.INTERNET"
      //       }
      //     ],
      //虽然新版本图片不声明也可以出来但是还是要声明
      Image('https://img0.baidu.com/it/u=2191392668,814349101&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1399')
        .height(300)
        .alt('图片')
        .objectFit(ImageFit.Contain) //ImageFit.Fill 充满有宽高的盒子会压缩图片 和css用法一样
      Image('https://img0.baidu.com/it/u=2191392668,814349101&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1399')
        .width(100)
        .height(200)
        .alt('图片')
        .objectFit(ImageFit.Fill)
        .border({
          width: 2,
          color: Color.Red
        }) //ImageFit.Fill 充满有宽高的盒子会压缩图片 和css用法一样
    }
  }
}