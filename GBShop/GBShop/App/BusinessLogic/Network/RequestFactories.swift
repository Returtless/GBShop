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
