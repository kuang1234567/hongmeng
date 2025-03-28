@Entry
@Component
struct ProviderConsumePage {
  @Provide msg: string = 'honmenyOS'

  build() {
    Column() {
      Text('父组件').fontSize(30).fontColor(Color.Blue)
      Text(this.msg).fontSize(30)
      Button('修改父组件msg').onClick(() => {
        this.msg = 'hongMen'
      })
      Child()
    }
  }
}

@Component
struct Child {
  //@consume装饰器在定义过程中无需初始化。值必须来自与@Provider装饰器
  //@conSume获取数据有两种写法，@consume 变量名，@consume（'变量名'）
  //@conSume和@Link具有双向数据更新的特点 不管那个组件中值修改所有用到这个值的组件都会修改

  //鸿蒙开发中组件如何进行通信：
  //@Prop的方式可以实现父子组件的单项数据更新
  //@Link可以实现父子组件的双向数据更新
  //@Provider和@conSume可以实现跨组件之间的通信
  //Localstorage和appStorage来实现页面数据共享
  @Consume msg: string

  build() {
    Column() {
      Text('子组件').fontSize(30).fontColor(Color.Red)
      Text(this.msg).fontSize(30)
      Button('修改子组件msg').onClick(() => {
        this.msg = 'hongMen'
      })
      Sun()
    }
  }
}

@Component
struct Sun {
  @Consume msg: string

  build() {
    Column() {
      Text('孙组件').fontSize(30).fontColor(Color.Green)
      Text(this.msg).fontSize(30)
      Button('修改孙组件msg').onClick(() => {
        this.msg = 'hongMen'
      })
      GrandSun()
    }
  }
}

@Component
struct GrandSun {
  @Consume msg: string

  build() {
    Column() {
      Text('曾孙组件').fontSize(30).fontColor(Color.Green)
      Text(this.msg).fontSize(30)
      Button('修改曾孙组件msg').onClick(() => {
        this.msg = 'hongMen'
      })
    }
  }
}