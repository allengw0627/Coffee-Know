//
//  ProductViewController.swift
//  Coffee Know
//
//  Created by Gregory Allen on 3/15/16.
//  Copyright © 2016 Flippatron. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let p = product{
            productNameLabel.text = p.name
            if let i = p.productImage{
                productImageView.image = UIImage(named: i)
            }
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func addToCartPressed(sender: AnyObject) {
        print("Button tapped")
    }
}
