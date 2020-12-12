//
//  LoginViewControllerTest.swift
//  GBShopTests
//
//  Created by Владислав Лихачев on 12.12.2020.
//

import XCTest
import Alamofire
@testable import GBShop

class LoginViewControllerTest: XCTestCase {
    var loginViewController: LoginViewController!
    let requestFactory = RequestFactory()

    override func setUpWithError() throws {
        loginViewController = LoginViewController()
        loginViewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        loginViewController = nil
    }

    func testFillingTextFields() throws {
        loginViewController.loginTextField.text = "login"
        loginViewController.passwordTextField.text = "pass"
        
        XCTAssertNotEqual(loginViewController.loginTextField.text, "")
        XCTAssertNotEqual(loginViewController.loginTextField.text, "")
    }
    
    func testAuthRequest() throws {
        loginViewController.loginTextField.text = "login"
        loginViewController.passwordTextField.text = "pass"
        
        XCTAssertNotEqual(loginViewController.loginTextField.text, "")
        XCTAssertNotEqual(loginViewController.passwordTextField.text, "")
        let expectation = self.expectation(description: "Авторизация успешна")
        
        if let login = loginViewController.loginTextField.text, let pass = loginViewController.passwordTextField.text {
            let auth = requestFactory.makeAuthRequestFactory()
            auth.login(userName: login, password: pass) { response in
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
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
