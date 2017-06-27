//
//  ViewController.swift
//  SprotStore
//
//  Created by nguyen hula on 2/19/17.
//  Copyright © 2017 nguyen hula. All rights reserved.
//

import UIKit


var handler = { (p : Product) in
    print("Change : \(p.name) \(p.stockLevel) item in stock")
};

class ViewController: UIViewController  {

    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var productStore = ProductDataStore()


    let logger = Logger<Product>(callBack: handler)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        displayStockTotal()
        productStore.callback = {(p : Product) in
            for cell in self.tableView.visibleCells {
                if let pcell = cell as? ProductTableCell {
                    if pcell.product?.name == p.name {
                        pcell.stockStepper.value = Double(p.stockLevel)
                        pcell.stockField.text = String(p.stockLevel)
                    }
                }
            }
            self.displayStockTotal()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func displayStockTotal() {
        let finalTotals:(Int, Double) = productStore.products.reduce((0, 0.0)) { (totals, product) -> (Int, Double) in
            return (
                totals.0 + product.stockLevel,
                totals.1 + product.stockValue
            )
        }
        
        let factory = StockTotalFactory.getFactory(curr: .EUR)
        let totalAmount = factory?.converter?.convertTotal(total: finalTotals.1)
        let formatted = factory?.formatter?.formatTotal(total: totalAmount!)
        totalLabel.text = "\(finalTotals.0) Product in stock." + "Total Value: \(String(describing: formatted))"
        
        
        
//        logger.processItems(callBack: handler)
    }
    
    
    @IBAction func stockLevelDidChanged(_ sender: Any) {
        if var currentCell = sender as? UIView {
            while (true) {
                currentCell = currentCell.superview!;
                if let cell = currentCell as? ProductTableCell {
                    if let product = cell.product {
                        if let stepper = sender as? UIStepper {
                            product.stockLevel = Int(stepper.value);
                        } else if let textfield = sender as? UITextField {
                            if let newValue = Int(textfield.text!) {
                                product.stockLevel = newValue;
                            } }
                        cell.stockStepper.value = Double(product.stockLevel);
                        cell.stockField.text = String(product.stockLevel);
                        productLogger.logItem(item: product)
                    }
                    break; }
            }
            displayStockTotal();
        }
    }
    
}


extension ViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productStore.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductTableCell
               let product = productStore.products[indexPath.row]
        cell.product = productStore.products[indexPath.row]
        cell.nameLabel.text = product.name
        cell.descLabel.text = product.productDescription
        cell.stockStepper.value = Double(product.stockLevel)
        cell.stockField.text = String(product.stockLevel)
        return cell
    }
}
