//: [Previous](@previous)

import Foundation
class Pet {}
class Cat: Pet {}
class Dog: Pet {}

// 在Swift中我们可以重载同样名字的方法，只需要保证参数的类型不同
func printPet(_ pet: Pet) {
    print("Pet")
}

func printPet(_ cat: Cat) {
    print("Cat")
}

func printPet(_ dog: Dog) {
    print("Dog")
}

printPet(Cat())
printPet(Dog())
printPet(Pet())

func printThem(_ pet: Pet, _ cat: Cat) {
    printPet(pet)
    printPet(cat)
}

printThem(Dog(), Cat())//Pet Cat, 由此可以看出Swift默认情况下并不采用动态派发，因此方法的调用只能在编译时期决定
func printThem_2(_ pet: Pet, _ cat: Cat) {
    if let aCat = pet as? Cat {
        printPet(aCat)
    } else if let aDog = pet as? Dog {
        printPet(aDog)
    }
    printPet(cat)
}
printThem_2(Dog(), Cat())   // Dog Cat

//: [Next](@next)
