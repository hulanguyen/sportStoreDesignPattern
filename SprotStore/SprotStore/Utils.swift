//
//  Utils.swift
//  SprotStore
//
//  Created by nguyen hula on 2/20/17.
//  Copyright © 2017 nguyen hula. All rights reserved.
//

import Foundation

class Utils {
    class func currencyStringFromNumber(number : Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(for: number) ?? ""
    }
}
