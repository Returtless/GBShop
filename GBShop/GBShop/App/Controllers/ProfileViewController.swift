//
//  ProfileViewController.swift
//  GBShop
//
//  Created by Владислав Лихачев on 12.12.2020.
//

import UIKit

class ProfileViewController: UIViewController {
    let requestFactory = RequestFactory()
    var isRegisterWindow = false
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (isRegisterWindow){
            titleLabel.text = "Регистрация"
            saveButton.setTitle("Зарегистрироваться", for: .normal)
        } else {
            configureLabels()
            saveButton.setTitle("Сохранить изменения", for: .normal)
            titleLabel.text = "Информация о пользователе"
        }
        
    }
    
    @IBAction func saveButtonWasTapped(_ sender: UIButton) {
        let auth = requestFactory.makeAuthRequestFatory()
        if isRegisterWindow{
            registerRequest(auth: auth)
        } else {
            saveDataRequest(auth: auth)
        }
    }
    
    func configureLabels(){
        nameTextField.text = "Иван Самойлов"
        emailTextField.text = "pochta@gmail.com"
        genderTextField.text = "мужской"
        cardNumberTextField.text = "9872389-2424-234224-234"
        descriptionTextField.text = "Меня зовут Ваня и я из Люксембурга"
    }
    
    func saveDataRequest(auth: AuthRequestFactory){
        auth.changeData(userName: nameTextField.text ?? "",
                        password: "mypassword",
                        email: emailTextField.text ?? "",
                        gender: genderTextField.text ?? "",
                        cardNumber: cardNumberTextField.text ?? "",
                        comment: descriptionTextField.text ?? "")
        { response in
            switch response.result {
            case .success(_):
                DispatchQueue.main.async {
                    self.showAlert(title: "Важно!", message:  "Информация прошла успешно!")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Ошибка сохранения!", message:  error.localizedDescription)
                }
            }
        }
    }
    func registerRequest(auth: AuthRequestFactory){
        auth.registration(userName: nameTextField.text ?? "",
                          password: "mypassword",
                          email: emailTextField.text ?? "",
                          gender: genderTextField.text ?? "",
                          cardNumber: cardNumberTextField.text ?? "",
                          comment: descriptionTextField.text ?? "")
        { response in
            switch response.result {
            case .success(_):
                DispatchQueue.main.async {
                    self.showAlert(title: "Важно!", message:  "Регистрация прошла успешно!")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Ошибка регистрации!", message: error.localizedDescription)
                }
            }
        }
    }
    func showAlert(title : String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
}
