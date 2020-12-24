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

    enum CodingKeys: String, CodingKey {
        case amount
        case countGoods
        case contents
        case userMoney
    }
}

struct ProductsResult: Codable {
    var pageNumber: Int
    var products: [Product]

    enum CodingKeys: String, CodingKey {
        case pageNumber = "page_number"
        case products
    }
}
