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
            configureUI(labelText: "Регистрация", buttonText: "Зарегистрироваться", isRegisterWindow: true)
        } else {
            configureUI(labelText: "Информация о пользователе", buttonText: "Сохранить изменения", isRegisterWindow: false)
        }
        
    }
    
    @IBAction func saveButtonWasTapped(_ sender: UIButton) {
        let auth = requestFactory.makeAuthRequestFactory()
        if isRegisterWindow{
            registerRequest(auth: auth)
        } else {
            saveDataRequest(auth: auth)
        }
    }
    
    func configureUI(labelText : String, buttonText : String, isRegisterWindow : Bool){
        if (!isRegisterWindow){
            configureLabels()
        }
        
        titleLabel.text = labelText
        saveButton.setTitle(buttonText, for: .normal)
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
    
}
