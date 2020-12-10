//
//  PMError.swift
//  PM Task 1
//
//  Created by Yaroslav Hrytsun on 09.12.2020.
//

import Foundation

enum PMMessage: String, Error {
    case info               = "Each time a factorial is calculated, a random algorithm (either recursive or iterative) is used."
    case zeroNumber         = "In human world, 'zero' doesn't mean 'one'. So yeah, nothing to show here."
    case tooLargeFactorial  = "Provided number is WAY to large to calculate in meaningful time. Maximum value is 999"
    case tooLargeFibonacci  = "Provided number is WAY to large to calculate in meaningful time. Maximum value is 80"
    case tooLargeForPi      = "Unfortunately, my algorithm can only process up to 17th number as it is limited to Double precision."
}
