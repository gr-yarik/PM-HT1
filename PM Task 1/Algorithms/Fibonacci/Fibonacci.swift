//
//  Fibonacci.swift
//  PM Task 1
//
//  Created by Yaroslav Hrytsun on 10.12.2020.
//

import Foundation

enum Fibonacci {
    
    static func calculate(till n : Int, completionHandler: ((Result<[BInt], PMMessage>) -> Void)) {
        if n == 0 {
            completionHandler(.failure(.zeroNumber))
            return
        }
        if n > 80 {
            completionHandler(.failure(.tooLargeFibonacci))
            return
        }
        completionHandler(.success(getResultArray(n)))
        
    }
    
    
    private static func getResultArray(_ n: Int) -> [BInt] {
        if n == 1 {
            return [0, 1]
        }
        
        var array: [BInt] = [0, 1]
        
        for i in 1..<n-1 {
            let next = array[i] + array[i-1]
            array.append(next)
        }
        return array
    }
}
