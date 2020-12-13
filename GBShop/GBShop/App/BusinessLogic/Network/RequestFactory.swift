//
//  RequestFactory.swift
//  GBShop
//
//  Created by Владислав Лихачев on 22.11.2020.
//

import Foundation
import Alamofire

class RequestFactory {
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFatory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeUserReviewsRequestFatory() -> UserReviewsRequestFactory {
        let errorParser = makeErrorParser()
        return UserReviews(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeManageReviewsRequestFatory() -> ManageReviewsRequestFactory {
        let errorParser = makeErrorParser()
        return ManageReviews(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeBasketRequestFatory() -> BasketRequestFactory {
        let errorParser = makeErrorParser()
        return Basket(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}
