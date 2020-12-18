//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Владислав Лихачев on 22.11.2020.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<StandardResult>) -> Void)
    func logout(id: Int, completionHandler: @escaping (AFDataResponse<StandardResult>) -> Void)
    func registration(userName: String, password: String, email : String, gender: String, cardNumber: String, comment: String, completionHandler: @escaping (AFDataResponse<RegisterResult>) -> Void)
    func changeData(userName: String, password: String, email : String, gender: String, cardNumber: String, comment: String, completionHandler: @escaping (AFDataResponse<StandardResult>) -> Void)
}

protocol UserReviewsRequestFactory {
    func addReview(userId: Int, text: String, completionHandler: @escaping (AFDataResponse<StandardResult>) -> Void)
    func removeReview(reviewId: Int, completionHandler: @escaping (AFDataResponse<StandardResult>) -> Void)
}

protocol ManageReviewsRequestFactory {
    func getReviewsForProduct(productId: Int, completionHandler: @escaping (AFDataResponse<StandardResult>) -> Void)
    func approveReview(reviewId: Int, completionHandler: @escaping (AFDataResponse<StandardResult>) -> Void)
}

protocol BasketRequestFactory {
    func addToBasket(productId: Int, quantity : Int, completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void)
    func deleteFromBasket(productId: Int, completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void)
    
    func payBasket(userId: Int, completionHandler: @escaping (AFDataResponse<UserBasketResult>) -> Void)
}

protocol ProductsRequestFactory {
    func catalogData(categoryId: Int, pageNumber: Int, completionHandler: @escaping (AFDataResponse<ProductsResult>) -> Void)
}
