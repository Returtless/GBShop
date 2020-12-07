//
//  Auth.swift
//  GBShop
//
//  Created by Владислав Лихачев on 22.11.2020.
//

import Foundation
import Alamofire

class Auth: AbstractRequestFactory {
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

extension Auth: AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<StandardResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func registration(userName: String, password: String, email : String, gender: String, cardNumber: String, comment: String, completionHandler: @escaping (AFDataResponse<RegisterResult>) -> Void) {
        let requestModel = Registration(baseUrl: baseUrl, login: userName, password: password, id: Int.random(in: 1..<10000), email: email, gender: gender, cardNumber: cardNumber, comment: comment)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func changeData(userName: String, password: String, email : String, gender: String, cardNumber: String, comment: String, completionHandler: @escaping (AFDataResponse<StandardResult>) -> Void) {
        let requestModel = Changer(baseUrl: baseUrl, login: userName, password: password, id: Int.random(in: 1..<10000), email: email, gender: gender, cardNumber: cardNumber, comment: comment)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(id: Int, completionHandler: @escaping (AFDataResponse<StandardResult>) -> Void) {
        let requestModel = Exit(baseUrl: baseUrl, id: id)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "login"
        
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "username": login,
                "password": password
            ]
        }
    }
    
    struct Registration: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "register"
        
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
    
    struct Exit: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "logout"
        
        let id: Int
        var parameters: Parameters? {
            return [
                "id_user": id
            ]
        }
    }
    
    struct Changer: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "changeData"
        
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
