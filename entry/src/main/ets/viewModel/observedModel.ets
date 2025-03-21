//宠物 使用@Observed装饰class会改变class原始的原型链，@Observed和其他类装饰器装饰同一个class可能会带来问题
@Observed
export class Pet {
  id: string
  name: string

  constructor(id: string, name: string) {
    this.id = id
    this.name = name
  }
}

//学生
@Observed
export class Student {
  id: string
  name: string
  pet: Pet

  constructor(id: string, name: string, pet: Pet) {
    this.id = id
    this.name = name
    this.pet = pet
  }
}

@Observed
export class ObjectClass extends Array<Student> {
}