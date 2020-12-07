//
//  ResponseCodableTests.swift
//  GBShopTests
//
//  Created by Владислав Лихачев on 29.11.2020.
//

import XCTest
import Alamofire
@testable import GBShop

class ResponseCodableTests: XCTestCase {
    
    let requestFactory = RequestFactory()
    var errorParser: ErrorParserStub!
    
    
    override func setUp() {
        super.setUp()
        errorParser = ErrorParserStub()
    }
    
    override func tearDown() {
        super.tearDown()
        errorParser = nil
    }
    
    
    func testAuth() {
        let expectation = self.expectation(description: "Авторизация успешна")
        let auth = requestFactory.makeAuthRequestFatory()
        auth.login(userName: "123", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                XCTAssert(true, login.result.description)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    func testRegistration() {
        let expectation = self.expectation(description: "End")
        let auth = requestFactory.makeAuthRequestFatory()
        auth.registration(userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", cardNumber: "9872389-2424-234224-234", comment: "Hello") { response in
            switch response.result {
            case .success(let res):
                XCTAssert(true, res.userMessage)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLogout() {
        let expectation = self.expectation(description: "Выход успешен")
        let auth = requestFactory.makeAuthRequestFatory()
        auth.logout(id: 123) { response in
            switch response.result {
            case .success(let login):
                XCTAssert(true, login.result.description)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testChangeData() {
        let expectation = self.expectation(description: "Смена данных успешна")
        let auth = requestFactory.makeAuthRequestFatory()
        auth.changeData(userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", cardNumber: "9872389-2424-234224-234", comment: "Hello") { response in
            switch response.result {
            case .success(let login):
                XCTAssert(true, login.result.description)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testAddReview() {
        let expectation = self.expectation(description: "Добавление отзыва успешно")
        let userReviews = requestFactory.makeUserReviewsRequestFatory()
        userReviews.addReview(userId: Int.random(in: 1..<100), text: "Отзыв") { response in
            switch response.result {
            case .success(let result):
                XCTAssert(true, result.result.description)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testRemoveReview() {
        let expectation = self.expectation(description: "Удаление отзыва успешно")
        let userReviews = requestFactory.makeUserReviewsRequestFatory()
        userReviews.removeReview(reviewId: Int.random(in: 1..<100)) { response in
            switch response.result {
            case .success(let result):
                XCTAssert(true, result.result.description)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testApproveReview() {
        let expectation = self.expectation(description: "Подтверждение отзыва успешно")
        let manageReviews = requestFactory.makeManageReviewsRequestFatory()
        manageReviews.approveReview(reviewId: Int.random(in: 1..<100)) { response in
            switch response.result {
            case .success(let result):
                XCTAssert(true, result.result.description)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}

struct PostStub: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

enum ApiErrorStub: Error {
    case fatalError
}

struct ErrorParserStub: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}
