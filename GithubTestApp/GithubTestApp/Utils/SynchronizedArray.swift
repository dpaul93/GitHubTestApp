//
//  SynchronizedArray.swift
//  GithubTestApp
//
//  Created by Pavlo Deynega on 29.06.17.
//  Copyright © 2017 Pavlo Deynega. All rights reserved.
//

import Foundation

class SynchronizedArray<Element> {
    private var semaphore = DispatchSemaphore(value: 1)
    private var array = [Element]()
    
    var all: [Element] {
        _ = semaphore.wait(timeout: .distantFuture)
        let items = array
        semaphore.signal()
        return items
    }
    
    var count: Int {
        _ = semaphore.wait(timeout: .distantFuture)
        let count = array.count
        semaphore.signal()
        return count
    }
    
    func append(element: Element) {
        _ = semaphore.wait(timeout: .distantFuture)
        array.append(element)
        semaphore.signal()
    }
    
    func append(collection: [Element]) {
        _ = semaphore.wait(timeout: .distantFuture)
        array.append(contentsOf: collection)
        semaphore.signal()
    }
    
    func removeAll() {
        _ = semaphore.wait(timeout: .distantFuture)
        array.removeAll()
        semaphore.signal()
    }
    
    subscript(index: Int) -> Element? {
        get {
            var result: Element?
            _ = semaphore.wait(timeout: .distantFuture)
            guard self.array.startIndex..<self.array.endIndex ~= index else { return nil }
            result = array[index]
            semaphore.signal()
            
            return result
        }
        set {
            guard let newValue = newValue else { return }
            _ = semaphore.wait(timeout: .distantFuture)
            array[index] = newValue
            semaphore.signal()
        }
    }
}
