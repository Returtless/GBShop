//
//  ReviewsTableViewController.swift
//  GBShop
//
//  Created by Владислав Лихачев on 21.12.2020.
//

import UIKit

class ReviewsTableViewController: UITableViewController {
    let requestFactory = RequestFactory()
    var product : Product?
    var reviews : [Review] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        registerCell(cellName: "ProductsTableViewCell")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "+", style: .done, target: self, action: #selector(self.addReview(sender:)))
    }

    @objc
    func addReview(sender: UITabBarItem) {
         let alert = UIAlertController(title: "Новый отзыв", message: "Добавьте отзыв о товаре", preferredStyle: UIAlertController.Style.alert )

            let save = UIAlertAction(title: "Сохранить", style: .default) { (alertAction) in
                let textField = alert.textFields![0] as UITextField
                if !textField.text!.isEmpty {
                    self.addReviewToServer(review: Review(commentId: self.reviews.count+1, productId: self.product!.id_product, userId: Int.random(in: 1..<100), text: textField.text!))
                }
            }

            alert.addTextField { (textField) in
                textField.placeholder = "Введите текст"
                
                textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 100))
            }

            alert.addAction(save)
            let cancel = UIAlertAction(title: "Отмена", style: .default) { (alertAction) in }
            alert.addAction(cancel)

            self.present(alert, animated:true, completion: nil)
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {return 1}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return reviews.count }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell", for: indexPath) as! ProductsTableViewCell
        cell.configureFor(review: reviews[indexPath.row])
        return cell
    }
    
    func registerCell(cellName : String){
        let nib = UINib(nibName: cellName, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellName)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeReviewFromServer(review: reviews[indexPath.row], indexPath: indexPath)
        }
    }
    
    func addReviewToServer(review: Review){
        let userReviews = requestFactory.makeUserReviewsRequestFactory()
        userReviews.addReview(userId: review.userId, text: review.text) { response in
            switch response.result {
            case .success(_):
                DispatchQueue.main.async {
                    self.reviews.append(review)
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.showAlert(title: "Ошибка сохранения отзыва!", message: error.errorDescription ?? "")
            }
        }
    }
    
    func removeReviewFromServer(review: Review, indexPath : IndexPath){
        let userReviews = requestFactory.makeUserReviewsRequestFactory()
        userReviews.removeReview(reviewId: review.commentId) { response in
            switch response.result {
            case .success(_):
                DispatchQueue.main.async {
                    self.reviews.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
            case .failure(let error):
                self.showAlert(title: "Ошибка удаления отзыва!", message: error.errorDescription ?? "")
            }
        }
    }
}
