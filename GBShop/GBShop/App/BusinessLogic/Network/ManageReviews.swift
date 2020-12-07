//
//  ManageReviews.swift
//  GBShop
//
//  Created by Владислав Лихачев on 06.12.2020.
//

import Foundation
import Alamofire

class ManageReviews: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://gbshopapi.herokuapp.com/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension ManageReviews: ManageReviewsRequestFactory {
    func approveReview(reviewId: Int, completionHandler: @escaping (AFDataResponse<StandardResult>) -> Void) {
        let requestModel = Review(baseUrl: baseUrl, path: Review.Pathes.approveReview.rawValue, id: reviewId, productId: nil, userId: nil, text: nil)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getReviewsForProduct(productId: Int, completionHandler: @escaping (AFDataResponse<StandardResult>) -> Void) {
        let requestModel = Review(baseUrl: baseUrl, path: Review.Pathes.approveReview.rawValue, id: nil, productId: productId, userId: nil, text: nil)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}

