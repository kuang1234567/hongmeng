//页面存储
//LocalStorage： 代表页面级别的存储，可以理解为LocalStorage就是内存数据库。可以往里面存储数据
//LocalStorage和AppStorage都是内存级别的存储方案。唯一不同的在于作用范围
//LocalStorage解决问题：
//1.在同一个不同EntryAbility中多个页面可以实现数据共享。不同EntryAbility无法实现数据共享。（需要用到AppStorage）
//2.实现一个页面定义存储的数据，在其他的子组件中都可以共享这个内存的数据


import { StorageChild } from '../view/storageChild'
import { router } from '@kit.ArkUI';


//两种实列化LocalStorage的方法
// 创建新实例并使用给定对象初始化数据
// let para: Record<string, number> = { 'PropA': 0 } //Record是泛型用于定义一个对象，<string, number>的意思是键为string，值为number
// let storage: LocalStorage = new LocalStorage(para)

//实例化一个对象 并设置存储数据
let storage: LocalStorage = new LocalStorage()
storage.setOrCreate('PropA', 0)

// 通过getShared接口获取在EntryAbility上声明的LocalStorage状态存储实现多页面共享，但这个效果预览器上看不了只能在模拟器或者真机上面查看，通常这种需求会用appStorage
// let storage: LocalStorage = LocalStorage.getShared()

//绑定LocalStorage数据存储
@Entry(storage)
@Component
struct StorageLocalstoragePage {
  //@LocalStorageProp必须要给初始值，但是如果内存中PropA已经存在值则会已本地存储值为准，如果初始化没有给值取不到值才会拿@LocalStorageProp初始值
  //@LocalStorageProp装饰的变量与LocalStorage中给定属性建立单向同步关系 不能修存储的值
  @LocalStorageProp('PropA') PropA: number = 1
  //@LocalStorageLink必须要给初始值，但是如果内存中PropA已经存在值则会已本地存储值为准，如果初始化没有给值取不到值才会拿@LocalStorageProp初始值
  //@LocalStorageLink装饰的变量与LocalStorage中给定属性建立双向同步关系 能够修存储的值
  @LocalStorageLink('PropA') PropALink: number = 1
  //应用级存储
  @StorageLink('PropA') appPropALink: number = 0

  build() {
    Column() {
      Text('storage父组件')
      Text(this.PropA.toString()).fontSize(30).onClick(() => {
        //这样修改虽然当前视图会改变但是PropA是@LocalStorageProp申明不能修改内存中的值，改的只是当前页面this.PropA的值，所以子组件的值没变
        this.PropA = 1
      })
      Text(this.PropALink.toString()).fontSize(30).fontColor(Color.Red).onClick(() => {
        //修改之后不管父组件还是子组件中的PropA全部发生修改说明内存中的值发生了修改
        this.PropALink += 1
      })
      Text('应用级存储')
      Text(this.appPropALink.toString()).fontSize(40).fontColor(Color.Orange).onClick(() => {
        this.appPropALink += 2
        router.pushUrl({
          url: "pages/appStoragePage"
        })
      })
      StorageChild()
    }
    .height('100%')
    .width('100%')
  }
}