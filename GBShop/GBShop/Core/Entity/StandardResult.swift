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
