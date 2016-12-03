//: Playground - noun: a place where people can play

import UIKit

enum Vehicle {
    case Car(windows: Int, wheels: Int)
    case Ship(windows: Int, funnels: Int, anchors: Int)
    case Plant(windows: Int, wheels: Int, wings: Int, engine: Int)
}

print(MemoryLayout<Vehicle>.size)

var aPlane: Vehicle = .Plant(windows: 1, wheels: 9, wings: 8, engine: 4)

//let bytePointer = withUnsafePointer(to: &aPlane) {
		