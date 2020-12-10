//
//  Factorial.swift
//  PM Task 1
//
//  Created by Yaroslav Hrytsun on 08.12.2020.
//

import Foundation

enum AlgorithmType: String, CaseIterable {
    case recursive
    case iterative
}

enum Factorial {
    
    static func calculate(factorialOf n : Int, algorithmType: AlgorithmType, completionHandler: ((Result<BInt, PMMessage>) -> Void)) {
        if n > 999 {
            completionHandler(.failure(.tooLargeFactorial))
            return
        }
        switch algorithmType {
        case .iterative:
            completionHandler(.success(iterative(n: n)))
        case .recursive:
            completionHandler(.success(recursive(n: BInt(n))))
        }
    }
    
    
    private static func iterative(n: Int) -> BInt {
        var result: BInt = 1;
        for i in (1...n) {
            result *= BInt(i)
        }
        return result
    }
    
    
    private static func recursive(n: BInt) -> BInt {
        if n == 1 {
            return 1
        }
        return n * recursive(n: n - 1)
    }
    
}
