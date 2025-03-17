export class DataFormat {
  DataFormat(value: Date) {
    const year = value.getFullYear()
    const month = value.getMonth() + 1
    const day = value.getDate()
    return `${year}-${month}-${day}`
  }
}

export default  new DataFormat()