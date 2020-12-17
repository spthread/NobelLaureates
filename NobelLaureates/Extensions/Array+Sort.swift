//
//  Array+Sort.swift
//  NobelLaureates
//
//  Created by Surendra Patel on 17/12/20.
//

import Foundation

extension Array {
    
    public func quickSort<T: Comparable>(array: inout [T], low: Int, high: Int) {
        if low < high {
            let partition = partitionFunc(array: &array, low: low, high: high)
            quickSort(array: &array, low: low, high: partition - 1)
            quickSort(array: &array, low: partition + 1, high: high)
        }
    }
    
    private func partitionFunc<T: Comparable>(array: inout [T], low: Int, high: Int) -> Int {
        var i: Int = low
        let pivot = array[high]
        
        for j in low..<high {
            if array[j] <= pivot {
                array.swapAt(i, j)
                i += 1
            }
        }
        array.swapAt(i, high)
        return i
    }
}

