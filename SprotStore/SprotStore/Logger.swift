//
//  Logger.swift
//  SprotStore
//
//  Created by nguyen hula on 2/25/17.
//  Copyright © 2017 nguyen hula. All rights reserved.
//

import Foundation

let productLogger = Logger<Product>(callBack: {
    p in
    var builder = ChangeRecordBuilder()
    builder.productName = p.name;
    builder.category = p.category;
    builder.value = String(p.stockLevel);
    builder.outerTag = "stockChange";
    
    var changeRecord = builder.changeRecord;
    if (changeRecord != nil) {
        print(builder.changeRecord!);
    }
})

final class Logger<T> where T : NSObject, T : NSCopying {
    var dataItems:[T] = [];
    var callBack: (T) -> Void
    
    let arrayQ = DispatchQueue(label: "arrayQ", attributes: .concurrent)
    let callbackQ = DispatchQueue(label: "callbackQ")
    
    
     init(callBack: @escaping (T) -> Void , protect: Bool = true) {
        self.callBack = callBack
        if protect {
//            weak var blockSelf = self
            self.callBack = { [unowned self] (item : T) -> Void in
                self.callbackQ.sync {
                    callBack(item)
                }
            }
        }
        
    }
    
    func logItem(item:T)  {
        arrayQ.async(flags: .barrier) { [unowned self] in
            self.dataItems.append(item.copy() as! T)
            self.callBack(item)
        }
        
    }
    
    
    func processItems(callBack : (T) -> Void)  {
        arrayQ.sync { [unowned self] in
            for item in self.dataItems {
                self.callBack(item)
            }
        }
    }
}
