//
//  Register.swift
//  GBShop
//
//  Created by Владислав Лихачев on 22.11.2020.
//

import Foundation
import Alamofire

class Register: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Register: RegisterRequestFactory {
    func registration(userName: String, password: String, email : String, gender: String, cardNumber: String, comment: String, completionHandler: @escaping (AFDataResponse<RegisterResult>) -> Void) {
        let requestModel = Registration(baseUrl: baseUrl, login: userName, password: password, id: Int.random(in: 1..<10000), email: email, gender: gender, cardNumber: cardNumber, comment: comment)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Register {
    struct Registration: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "registerUser.json"
        
        let login: String
        let password: String
        let id : Int
        let email : String
        let gender : String
        let cardNumber : String
        let comment : String
        var parameters: Parameters? {
            return [
                "id_user" : id,
                "username" : login,
                "password" : password,
                "email" : email,
                "gender": gender,
                "credit_card" : cardNumber,
                "bio" : comment
            ]
        }
    }
}
