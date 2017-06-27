//
//  StockValueImplementations.swift
//  SprotStore
//
//  Created by nguyen hula on 6/14/17.
//  Copyright © 2017 nguyen hula. All rights reserved.
//

import Foundation

protocol StockValueFormatter {
    func formatTotal(total:Double) -> String;
}

class DollarStockValueFormatter : StockValueFormatter {
    func formatTotal(total:Double) -> String {
        let formatted = Utils.currencyStringFromNumber(number: total);
        return "\(formatted)";
    }
}
class PoundStockValueFormatter : StockValueFormatter {
    func formatTotal(total:Double) -> String {
        let formatted = Utils.currencyStringFromNumber(number: total);
        return "£\((formatted))";
    }
}


protocol StockValueConverter {
    func convertTotal(total:Double) -> Double;
}

class DollarStockValueConverter : StockValueConverter {
    func convertTotal(total:Double) -> Double {
        return total;
    }
}

class PoundStockValueConverter : StockValueConverter {
    func convertTotal(total:Double) -> Double {
        return 0.60338 * total;
    }
}
