/**
 * @description: 处理时间格式
 * @param {*} params timestamp:number 时间戳
 * @param {*} params format:string 时间格式 如 ‘yyyy-mm-dd’ ‘yyyy/mm/dd’
 * @return {Promise}
 */
interface Opt {
  yy: string;
  mm: string;
  dd: string;
  HH: string;
  MM: string;
  SS: string;
}

export function formatDate(timestamp: number, format: string = 'yyyy-mm-dd') {
  let res = ''
  try {
    //转化为日期对象
    const date = new Date(timestamp)
    //定义了日期字段
    const opt: Opt = {
      yy: date.getFullYear().toString(),
      mm: (date.getMonth() + 1).toString(),
      dd: date.getDate().toString(),
      HH: date.getHours().toString(),
      MM: date.getMinutes().toString(),
      SS: date.getSeconds().toString(),
    }
    //存放正则表达的要匹配的字段 y+的意思是正则有多个y
    const regKeys: Array<string> = ['y+', 'm+', 'd+', 'H+', 'M+', 'S+']
    for (let index = 0; index < regKeys.length; index++) {
      const regKey = regKeys[index]
      //构造正则表达对象 列：new RegExp('y+')
      const reg = new RegExp(regKey)
      let ret = reg.exec(format)
      if (ret) {
        switch (regKey) {
          case 'y+':
            format = format.replace(reg, ret.length !== 1 ? opt.yy : opt.yy.padStart(ret.length, '0'))
            break;
          case 'm+':
            format = format.replace(reg, ret.length !== 1 ? opt.mm : opt.mm.padStart(2, '0'))
            break;
          case 'd+':
            format = format.replace(reg, ret.length !== 1 ? opt.dd : opt.dd.padStart(2, '0'))
            break;
          case 'H+':
            format = format.replace(reg, ret.length !== 1 ? opt.HH : opt.HH.padStart(2, '0'))
            break;
          case 'M+':
            format = format.replace(reg, ret.length !== 1 ? opt.MM : opt.MM.padStart(2, '0'))
            break;
          case 'S+':
            format = format.replace(reg, ret.length !== 1 ? opt.SS : opt.SS.padStart(2, '0'))
            break;

          default:
            break;
        }
      }
    }
    res = format
  } catch (err) {
    console.log('err', err)
  }
  return res
}


/**
 * @description: 随机获取当前月的一个日期
 */
export function getRandomDateCurrentMonth() {
  let today = new Date()
  const year = today.getFullYear()
  let mouth = today.getMonth() + 1
  let minDay = 1
  let maxDay = new Date(year, mouth + 1, 0).getDate()
  let randomDay = Math.floor(Math.random() * (maxDay - minDay + 1)) + minDay
  return `${year}-${String(mouth).padStart(2, '0')}-${String(randomDay).padStart(2, '0')}`
}
