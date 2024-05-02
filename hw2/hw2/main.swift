//
//  main.swift
//  hw2
//
//  Created by Catarina Polakowsky on 22.04.2024.
//

import Foundation

var array = ThreadSafeArrayImp<Int>()
var array2 = [Int]()

let group = DispatchGroup()

DispatchQueue.global().async(group: group) {
    for element in 0...9 {
        array.append(element)
    }
}

DispatchQueue.global().async(group: group) {
    for element in 10...99 {
        array.append(element)
    }
}


DispatchQueue.global().async(group: group) {
    for element in 0...9 {
        array2.append(element)
    }
}
//
//DispatchQueue.global().async(group: group) {
//    for element in 10...99 {
//        array2.append(element)
//    }
//}

group.wait()

//array.remove(at: 102)

print("Thread Safe Array: \(array.count)")
print("Second Array: \(array2.count)")

//print(array)
