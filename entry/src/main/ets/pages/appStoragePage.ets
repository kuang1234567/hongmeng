//应用级存储 appStorage
//创建的存储是应用全局的储存，在整个应用都可以获取
//
@Entry
@Component
struct AppStoragePage {
  //监测整个应用有没有PropA，如果没有就创建一个。 不用像localStorage那样创建一个储存于entry进行绑定
  //@StorageProp,StorageLink与@LocalStorageProp，@LocalStorageLink用法基本一致
  @StorageProp('PropA') PropA: number = 0
  @StorageLink('PropA') PropALink: number = 1

  build() {
    Column() {
      Text(this.PropA.toString()).fontSize(30).fontColor(Color.Brown)

      Text(this.PropALink.toString()).fontSize(30).fontColor(Color.Pink).onClick(() => {
        this.PropALink += 1
      })
    }.height('100%')
    .width('100%')
  }
}