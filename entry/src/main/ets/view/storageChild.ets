@Component
export struct StorageChild {
  @LocalStorageProp('PropA') PropA: number = 1
  @LocalStorageLink('PropA') PropALink: number = 1

  build() {
    Column() {
      Text('storage子组件')
      Text(this.PropA.toString()).fontSize(30).fontColor(Color.Green)
      Text(this.PropALink.toString()).fontSize(30).fontColor(Color.Red).onClick(() => {
        this.PropALink += 1
      })
    }
    .height('100%')
    .width('100%')
  }
}