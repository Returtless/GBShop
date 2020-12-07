//
//  AppDelegate.swift
//  GBShop
//
//  Created by Владислав Лихачев on 19.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let requestFactory = RequestFactory()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.login(userName: "123", password: "mypassword") { response in
            print("Результат авторизации:")
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        auth.registration(userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", cardNumber: "9872389-2424-234224-234", comment: "Hello") { response in
            print("Результат регистрации:")
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        auth.changeData(userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", cardNumber: "9872389-2424-234224-234", comment: "Hello") { response in
            print("Результат изменения данных:")
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        auth.logout(id: 123) { response in
            print("Результат выхода из профиля:")
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let userReviews = requestFactory.makeUserReviewsRequestFatory()
        userReviews.addReview(userId: Int.random(in: 1..<100), text: "Отзыв") { response in
            print("Результат добавления отзыва:")
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        userReviews.removeReview(reviewId: Int.random(in: 1..<100)) { response in
            print("Результат удаления отзыва:")
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let manageReviews = requestFactory.makeManageReviewsRequestFatory()
        manageReviews.approveReview(reviewId: Int.random(in: 1..<100)) { response in
            print("Результат подтверждения отзыва:")
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

