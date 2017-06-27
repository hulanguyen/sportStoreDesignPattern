//
//  Product.swift
//  SprotStore
//
//  Created by nguyen hula on 2/20/17.
//  Copyright © 2017 nguyen hula. All rights reserved.
//

import UIKit

enum UpsellOpportunities {
    case SwimmingLessons
    case MapOfLakes
    case SoccerVideos
}

class Product : NSObject, NSCopying{

    private(set) var name : String
    private(set) var productDescription : String
    private(set) var category : String
    private(set) var price : Double
    {
        get {
            return priceBackingValue
        }
        set {
            priceBackingValue = max(1, newValue)
        }
    }
    var stockLevel : Int
    {
        get{
           return stockLevelBackingValue
        }
        set {
            stockLevelBackingValue = max(0, newValue)
        }
    }
    private var stockLevelBackingValue : Int = 0
    private var priceBackingValue : Double = 0
    
    
    var stockValue : Double {
        get {
            return price * (1 + salesTaxRate) * Double(stockLevel)
        }
    }
    
    fileprivate var salesTaxRate : Double = 0.2
    
    var upsells : [UpsellOpportunities] {
        get {
            return Array()
        }
    }
    
    
    required init(name : String, description : String, category :String, price : Double, stockLevel : Int) {
        self.name = name
        self.productDescription = description
        self.category = category
        super.init()
        self.price = price
        self.stockLevel = stockLevel
    }
    
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Product(name: self.name, description: self.productDescription, category: self.category, price: self.price, stockLevel: self.stockLevel)
    }
    
    class func createProduct(name : String, description : String, category : String, price :Double, stockLevel: Int) -> Product{
        var productType : Product.Type
        switch category {
        case "Watersports":
            productType = WatersportProduct.self
        case "Soccer":
            productType = SoccerProduct.self
        default:
            productType = Product.self
        }
        return productType.init(name : name, description: description,category : category, price : price, stockLevel : stockLevel)
    }
}


class WatersportProduct: Product {
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
        salesTaxRate = 0.1
    }
    
    override var upsells: [UpsellOpportunities] {
        return [UpsellOpportunities.SwimmingLessons, UpsellOpportunities.MapOfLakes]
    }
}

class SoccerProduct: Product {
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
        salesTaxRate = 0.25
    }
    
    override var upsells: [UpsellOpportunities] {
        return [UpsellOpportunities.SoccerVideos]
    }
}
