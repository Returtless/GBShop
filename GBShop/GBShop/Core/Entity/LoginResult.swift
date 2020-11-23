//
//  LoginResult.swift
//  GBShop
//
//  Created by Владислав Лихачев on 22.11.2020.
//

import Foundation

struct LoginResult: Codable {
    let result: Int
    let user: User
}

struct RegisterResult: Codable {
    let result: Int
    let userMessage: String
}
