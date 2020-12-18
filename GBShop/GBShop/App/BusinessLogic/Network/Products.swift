//
//  Products.swift
//  GBShop
//
//  Created by Владислав Лихачев on 17.12.2020.
//

import Foundation
import Alamofire

class Products: AbstractRequestFactory {
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

extension Products: ProductsRequestFactory {
    func catalogData(categoryId: Int, pageNumber: Int, completionHandler: @escaping (AFDataResponse<ProductsResult>) -> Void) {
        let requestModel = Catalog(baseUrl: baseUrl, path: Catalog.Pathes.catalogData.rawValue, categoryId: 1, pageNumber: 5)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension Products {
    struct Catalog: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: Pathes.RawValue
        
        let categoryId: Int
        let pageNumber: Int
        var parameters: Parameters? {
            return [
                "id_category": categoryId,
                "page_number": pageNumber
            ]
        }
        
        enum Pathes : String{
            case catalogData
        }
    }
}
