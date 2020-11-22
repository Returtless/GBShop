//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Владислав Лихачев on 22.11.2020.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
