//
//  Euro.swift
//  SprotStore
//
//  Created by nguyen hula on 6/18/17.
//  Copyright © 2017 nguyen hula. All rights reserved.
//

import Foundation

class EuroHandler {
    func getDisplayString(amount : Double) -> String {
        let formatted = Utils.currencyStringFromNumber(number: amount)
        return "€\((formatted))"
    }
    
    func getCurrencyAmount (amount : Double) -> Double {
        return 0.76164 * amount
    }
}
