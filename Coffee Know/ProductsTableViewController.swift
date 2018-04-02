//
//  ProductsTableViewController.swift
//  Coffee Know
//
//  Created by Gregory Allen on 3/18/16.
//  Copyright © 2016 Flippatron. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController, NSURLConnectionDelegate {
    var currentConnection: NSURLConnection?
    var products = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let coffeeUrl = NSURL(string: "http://localhost:8081/coffees")
        // Asynchronous Http call to your api url, using NSURLSession:
        NSURLSession.sharedSession().dataTaskWithURL(coffeeUrl!, completionHandler: { (data, response, error) -> Void in
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! Dictionary<String, AnyObject>
                    for aCoffee in json {
                        if let thisCoffee = json[aCoffee.0] as? Dictionary<String, String>{
                            let thisProduct = Product()
                            thisProduct.roaster = thisCoffee["roaster"]
                            thisProduct.name = thisCoffee["name"]
                            thisProduct.origins = thisCoffee["origins"]
                            thisProduct.varietals = thisCoffee["varietals"]
                            thisProduct.elevation = thisCoffee["elevation"]
                            thisProduct.cup = thisCoffee["cup"]
                            if thisCoffee["available"] == "on" {
                                thisProduct.available = true
                            }else{
                                thisProduct.available = false
                            }
                            thisProduct.cellImage = "bag"
                            thisProduct.productImage = "bag"
                            self.products.append(thisProduct)
                        }
                    }
                } catch {
                    print("caught: \(error)")
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                    return
                })
            }
        }).resume()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath)
        cell.textLabel?.text = self.products[indexPath.row].name
        //cell.imageView?.image =
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowProduct"{
            let productVC = segue.destinationViewController as? ProductViewController
            guard let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPathForCell(cell)
                else {
                    return
            }
            productVC?.product = products[indexPath.row]
        }
    }
    
}
