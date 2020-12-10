//
//  Basket.swift
//  GBShop
//
//  Created by Владислав Лихачев on 06.12.2020.
//

import Foundation
import Alamofire

class Basket: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://gbshopapi.herokuapp.com")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Basket: BasketRequestFactory {
    func addToBasket(productId: Int, quantity: Int, completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void) {
        let requestModel = Product(baseUrl: baseUrl, path: Product.Pathes.addToBasket.rawValue,  userId : nil, productId: productId, quantity: quantity)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func deleteFromBasket(productId: Int, completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void) {
        let requestModel = Product(baseUrl: baseUrl, path: Product.Pathes.deleteFromBasket.rawValue, userId : nil, productId: productId, quantity: nil)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func payBasket(userId: Int, completionHandler: @escaping (AFDataResponse<UserBasketResult>) -> Void) {
        let requestModel = Product(baseUrl: baseUrl, path: Product.Pathes.payBasket.rawValue, userId : userId, productId: nil, quantity: nil)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Basket {
    struct Product: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: Pathes.RawValue
        
        let userId: Int?
        let productId: Int?
        let quantity: Int?
        var parameters: Parameters? {
            return [
                "id_user": userId ?? 0,
                "id_product": productId ?? 0,
                "quantity": quantity ?? 0
            ]
        }
        
        enum Pathes : String{
            case addToBasket
            case deleteFromBasket
            case payBasket
        }
    }
}
