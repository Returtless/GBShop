//
//  GBShopUITests.swift
//  GBShopUITests
//
//  Created by Владислав Лихачев on 24.12.2020.
//

import XCTest

class GBShopUITests: XCTestCase {
    
    var app: XCUIApplication!
    var scrollViewsQuery: XCUIElementQuery!
    
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        scrollViewsQuery = app.textFields
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    private func enterAuthData(login: String, password: String) {

        let loginTextField = app.textFields.element(boundBy: 0)
        if loginTextField.exists {
            loginTextField.tap()
            loginTextField.typeText(login)
        }
        
        let passwordTextField = app.textFields.element(boundBy: 1)
        if passwordTextField.exists {
            passwordTextField.tap()
            passwordTextField.typeText(password)
        }
        

       
        app.staticTexts["Войти"].tap()
    }
    
    func testSuccess() {
        enterAuthData(login: "admin\n", password: "123456\n")
        
        let resultLabel = scrollViewsQuery.staticTexts["Данные верны"]
        XCTAssertNotNil(resultLabel)
    }
    
    func testFail() {
        enterAuthData(login: "user", password: "password")
        
        let resultLabel = scrollViewsQuery.staticTexts["Ошибка входа"]
        XCTAssertNotNil(resultLabel)
    }
    
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
