//
//  BasketViewController.swift
//  GBShop
//
//  Created by Владислав Лихачев on 24.12.2020.
//

import UIKit

class BasketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let requestFactory = RequestFactory()
    var products : [Product]? {
        didSet{
            changePayButtonState()
        }
    }
    
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        changePayButtonState()
        registerCell(cellName: "ProductsTableViewCell")
        getBasket()
    }
    
    @IBAction func payBasketTap(_ sender: UIButton) {
        guard let products = products, products.count > 0 else { return }
        let basket = requestFactory.makeBasketRequestFactory()
        basket.payBasket(userId: Int.random(in: 1..<100)) { response in
            switch response.result {
            case .success(_):
                DispatchQueue.main.async {
                    self.showAlert(title: "ОК!", message: "Покупка прошла успешно")
                    self.products = nil
                    self.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Ошибка!", message: error.errorDescription ?? "")
                }
            }
        }
        
    }
    func getBasket() {
        let basket = requestFactory.makeBasketRequestFactory()
        basket.getBasket(userId: Int.random(in: 1..<100)) { response in
            switch response.result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.products = result.contents
                    self.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Ошибка!", message: error.errorDescription ?? "")
                }
            }
        }
        
    }
    func registerCell(cellName : String){
        let nib = UINib(nibName: cellName, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellName)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products?.count ?? 0
    }
    
    func changePayButtonState() {
        if let products = products, products.count > 0 {
            payButton.isEnabled = true
        } else {
            payButton.isEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell", for: indexPath) as! ProductsTableViewCell
        if let products = products {
            cell.configure(product: products[indexPath.row])
        }
        return cell
    }
}
