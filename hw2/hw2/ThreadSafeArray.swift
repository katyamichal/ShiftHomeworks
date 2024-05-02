//
//  ThreadSafeArray.swift
//  hw2
//
//  Created by Catarina Polakowsky on 22.04.2024.
//

import Foundation

protocol ThreadSafeArray {
    
    associatedtype Element: Equatable
    
    var count: Int { get }
    var isEmpty: Bool { get }
  
    
    func append(_ elemrnt: Element)
    func remove(at index: Int)
    func contains(_ element: Element) -> Bool
    
  
    subscript(index: Int) -> Element? { get }
}


final class ThreadSafeArrayImp<Element: Equatable>: ThreadSafeArray {
    
   private var array: [Element] = []
   private let arrayQueue = DispatchQueue(label: "ThreadSafeQueue", attributes: .concurrent)
    
   public var count: Int {
       return arrayQueue.sync { self.array.count }
   }
   
   public var isEmpty: Bool {
       return arrayQueue.sync { self.array.isEmpty }
   }
   
   public func append(_ element: Element) {
       arrayQueue.async(flags: .barrier) {
           self.array.append(element)
       }
   }
   
   public func remove(at index: Int) {
       arrayQueue.async(flags: .barrier) {
           guard self.array.count > index else {
               return print("Index out of Range")
           }
           self.array.remove(at: index)
       }
   }
    
    public func contains(_ element: Element) -> Bool where Element: Equatable {
        return arrayQueue.sync { self.array.contains(element) }
    }
    
    
    subscript(index: Int) -> Element? {
        get {
            var element: Element? = nil
            arrayQueue.sync {
                guard self.array.indices.contains(index) else {return}
                element = self.array[index]
            }
            return element
        }
    }
}

extension ThreadSafeArrayImp: CustomDebugStringConvertible {
   public var debugDescription: String {
       "[\(array.map {"\($0)"}.joined(separator: ", "))]"
   }
}
