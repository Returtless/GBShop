//
//  Product.swift
//  GBShop
//
//  Created by Владислав Лихачев on 21.12.2020.
//

import Foundation

struct Product: Codable {
    var id_product: Int
    var product_name: String
    var price: Int
    var quantity: Int?
}
