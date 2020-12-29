//
//  LoginViewController.swift
//  GBShop
//
//  Created by Владислав Лихачев on 12.12.2020.
//

import UIKit
import FirebaseCrashlytics

class LoginViewController: UIViewController {
    let requestFactory = RequestFactory()
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        configureRegisterLabel()
    }
    
    @IBAction func loginButtonWasTapped(_ sender: UIButton) {
        guard let login = loginTextField.text, let password = passwordTextField.text else {
            loginTextField.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            return
        }
        guard !login.isEmpty else {
            loginTextField.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            return
        }
        
        guard !password.isEmpty else {
            passwordTextField.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            return
        }
        authorize(login: login, password: password)
    }
    

    
    func configureRegisterLabel(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(registerTap))
        registerLabel.isUserInteractionEnabled = true
        registerLabel.addGestureRecognizer(tap)
        let attributedString = NSMutableAttributedString(string: "Зарегистрироваться")
        attributedString.addAttribute(.link, value: "Зарегистрироваться", range: NSRange(location: 0, length: 18))
        registerLabel.attributedText = attributedString
    }
    
    @objc
    func registerTap(sender:UITapGestureRecognizer) {
        showProfileViewController(isRegister: true)
    }
    
    func configureTextFields(){
        loginTextField.setBottomBorderOnlyWith(color: UIColor.gray.cgColor)
        passwordTextField.setBottomBorderOnlyWith(color: UIColor.gray.cgColor)
    }
    
    func showProfileViewController(isRegister : Bool){
        let tabBarViewController = TabBarController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navigationController?.pushViewController(tabBarViewController, animated: true)
    }
    
    func authorize(login : String, password : String){
        let auth = requestFactory.makeAuthRequestFactory()
        auth.login(userName: login, password: password) { response in
            switch response.result {
            case .success(_):
                DispatchQueue.main.async {
                    fatalError("testerovaka")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Ошибка авторизации!", message: error.errorDescription ?? "")
                }
            }
        }
    }
}

extension UITextField {
    func setBottomBorderOnlyWith(color: CGColor) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func isError(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "")

        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }
}
