//
//  StockValueFactories.swift
//  SprotStore
//
//  Created by nguyen hula on 6/14/17.
//  Copyright © 2017 nguyen hula. All rights reserved.
//

import Foundation

class StockTotalFactory {
    enum Currency {
        case USD
        case GBP
        case EUR
    }
    
    var formatter : StockValueFormatter?
    var converter : StockValueConverter?
    
    class func getFactory(curr : Currency) -> StockTotalFactory? {
        if (curr == Currency.USD) {
            return DollarStockTotalFactory.shared
        } else if (curr == .GBP){
            return PoundStockTotalFactory.shared
        } else {
            return EuroHandlerAdapter.shared
        }
    }
}


private class DollarStockTotalFactory : StockTotalFactory {
    static let shared = DollarStockTotalFactory()
    private override init() {
        super.init()
        formatter = DollarStockValueFormatter()
        converter = DollarStockValueConverter ()
    }
}

private class PoundStockTotalFactory : StockTotalFactory {
    static let shared = PoundStockTotalFactory()
    private override init() {
        super.init()
        formatter = PoundStockValueFormatter()
        converter = PoundStockValueConverter()
    }
}

class EuroHandlerAdapter : StockTotalFactory,
StockValueConverter, StockValueFormatter {
    static let shared = EuroHandlerAdapter();
    private let handler:EuroHandler;
    override init() {
        self.handler = EuroHandler();
        super.init();
        super.formatter = self;
        super.converter = self;
    }
    func formatTotal(total:Double) -> String {
        return handler.getDisplayString(amount: total);
    }
    func convertTotal(total:Double) -> Double {
        return handler.getCurrencyAmount(amount: total);
    }

}
