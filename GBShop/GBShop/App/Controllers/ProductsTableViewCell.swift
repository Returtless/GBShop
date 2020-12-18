//
//  ProductsTableViewCell.swift
//  GBShop
//
//  Created by Владислав Лихачев on 17.12.2020.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {

    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var productNameLabel: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(product : Product){
        self.productNameLabel.text = product.product_name
        self.priceLabel.text = "\(product.price)"
    }
}
