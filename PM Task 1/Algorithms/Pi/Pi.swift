//
//  Pi.swift
//  PM Task 1
//
//  Created by Yaroslav Hrytsun on 10.12.2020.
//

import Foundation

enum Pi {
    
    static func getNdigit(n: Int, completionHandler: (Result<Int, PMMessage>) -> Void) {
        
        guard n != 0 else {
            completionHandler(.failure(.zeroNumber))
            return
        }
        
        guard n <= 17 else {
            completionHandler(.failure(.tooLargeForPi))
            return
        }
        
        let multipliedPi = Int(Double.pi * pow(10.0, Double(n-1)))
        let remainder = multipliedPi % 10
        completionHandler(.success(remainder))
    }
}
