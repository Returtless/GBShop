//
//  AppDelegate.swift
//  GBShop
//
//  Created by Владислав Лихачев on 19.11.2020.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
 //   let requestFactory = RequestFactory()
    var window: UIWindow?
    
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootViewController = LoginViewController(nibName: "LoginViewController", bundle : nil)
        navigationController = UINavigationController(rootViewController: rootViewController)
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        FirebaseApp.configure()
        
//        let auth = requestFactory.makeAuthRequestFatory()
//        auth.login(userName: "123", password: "mypassword") { response in
//            print("Результат авторизации:")
//            switch response.result {
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//        auth.registration(userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", cardNumber: "9872389-2424-234224-234", comment: "Hello") { response in
//            print("Результат регистрации:")
//            switch response.result {
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//        auth.changeData(userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", cardNumber: "9872389-2424-234224-234", comment: "Hello") { response in
//            print("Результат изменения данных:")
//            switch response.result {
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//        auth.logout(id: 123) { response in
//            print("Результат выхода из профиля:")
//            switch response.result {
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//        let userReviews = requestFactory.makeUserReviewsRequestFatory()
//        userReviews.addReview(userId: Int.random(in: 1..<100), text: "Отзыв") { response in
//            print("Результат добавления отзыва:")
//            switch response.result {
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//        userReviews.removeReview(reviewId: Int.random(in: 1..<100)) { response in
//            print("Результат удаления отзыва:")
//            switch response.result {
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//        let manageReviews = requestFactory.makeManageReviewsRequestFatory()
//        manageReviews.approveReview(reviewId: Int.random(in: 1..<100)) { response in
//            print("Результат подтверждения отзыва:")
//            switch response.result {
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//        
//        let basket = requestFactory.makeBasketRequestFatory()
//        basket.addToBasket(productId: Int.random(in: 1..<100), quantity: Int.random(in: 1..<100)) { response in
//            print("Результат добавления в корзину:")
//            switch response.result {
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//        basket.deleteFromBasket(productId: Int.random(in: 1..<100)) { response in
//            print("Результат удаления из корзины:")
//            switch response.result {
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//        basket.payBasket(userId: Int.random(in: 1..<100)) { response in
//            print("Результат покупки корзины:")
//            switch response.result {
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        return true
    }
}

extension UIViewController {
    func showAlert(title : String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
