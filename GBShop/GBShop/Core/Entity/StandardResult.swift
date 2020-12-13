//
//  LoginResult.swift
//  GBShop
//
//  Created by Владислав Лихачев on 22.11.2020.
//

import Foundation

struct StandardResult: Codable {
    let result: Int
}

struct RegisterResult: Codable {
    let result: Int
    let userMessage: String
    
    enum CodingKeys: String, CodingKey {
        case result
        case userMessage = "user_message"
    }
}

struct ProductResult: Codable {
    let result: Int
    let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case result
        case errorMessage = "error_message"
    }
}

struct UserBasketResult: Codable {
    var amount: Int
    var countGoods: Int
    var contents: [Product]
    var userMoney: Int?
    
    struct Product: Codable {
        var id_product: Int
        var product_name: String
        var price: Int
        var quantity: Int?
    }

    enum CodingKeys: String, CodingKey {
        case amount
        case countGoods
        case contents
        case userMoney
    }
//    required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.contents = (try? container.decodeIfPresent(Array<Product>.self, forKey: .contents)) ?? []
//        self.countGoods = (try? container.decodeIfPresent(Int.self, forKey: .countGoods)) ?? 0
//        self.userMoney = (try? container.decodeIfPresent(Int.self, forKey: .userMoney))
//        self.amount = (try? container.decodeIfPresent(Int.self, forKey: .amount)) ?? 0
//    }
}
