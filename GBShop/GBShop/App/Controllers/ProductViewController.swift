//
//  ProductViewController.swift
//  GBShop
//
//  Created by Владислав Лихачев on 21.12.2020.
//

import UIKit

class ProductViewController: UIViewController {
    let requestFactory = RequestFactory()
    var product : Product?
    
    @IBOutlet weak var fullImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    func configure(){
        guard product != nil else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        self.fullImageView.image = UIImage(systemName: "sun.max.fill")
        self.nameLabel.text = product?.product_name
        self.priceLabel.text = "\(product?.price ?? 0)"
        self.descTextView.text = "Скоро здесь будет описание"
    }
    
    @IBAction func buyProduct(_ sender: UIButton) {
        
        let basket = requestFactory.makeBasketRequestFactory()
        basket.addToBasket(productId: product!.id_product, quantity: 1) { response in
            switch response.result {
            case .success(_):
                DispatchQueue.main.async {
                    self.showAlert(title: "ОК!", message: "Товар добавлен в корзину")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Ошибка!", message: error.errorDescription ?? "")
                }
            }
        }
    }
    
    @IBAction func viewReviews(_ sender: UIButton) {
        let reviewsTableViewController = ReviewsTableViewController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        reviewsTableViewController.product = product
        appDelegate.navigationController?.pushViewController(reviewsTableViewController, animated: true)
    }
}
