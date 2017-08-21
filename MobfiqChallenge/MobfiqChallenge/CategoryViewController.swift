//
//  SecondViewController.swift
//  MobfiqChallenge
//
//  Created by Elton Coelho on 18/08/17.
//  Copyright © 2017 Elton Coelho. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController , UITableViewDelegate ,
    UITableViewDataSource , RequestHandler {

    var requestTask : URLSessionDataTask?
    var categoryList : [Category] = [Category]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if( RequestHelper.hasInternetConnection() ) {
            self.requestTask =  RequestHelper.getRequest(on: Constants.Url.CATEGORY , and: self)
        } else {
            //sem internet 
        }
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if( requestTask != nil ) {
            requestTask?.cancel()
        }
    }

    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "default"
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if( cell == nil ) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
            cell.accessoryType = .disclosureIndicator
        }
        let category : Category = categoryList[indexPath.row]
        
        cell?.textLabel?.text = category.name
        
        cell?.accessoryType = .disclosureIndicator
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let category : Category = categoryList[indexPath.row]
        
        self.performSegue(withIdentifier: "goToSubcategory", sender: category )
    }
    
    
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let subCategoryVC : SubcategoryViewController = segue.destination as! SubcategoryViewController
        subCategoryVC.category = sender as! Category
    }
    
    // MARK: - Request Handler Methods
    
    func requestSuccess(with data: Any, forRequest request: URLRequest) {
    
        
        let info : NSDictionary = data as! NSDictionary
        if(info.object(forKey: Constants.Category.Categories) != nil ){
            let list = info.object(forKey: Constants.Category.Categories) as! NSArray
            for categoryDictionary in list {
                let category : Category = Category(info: categoryDictionary as? NSDictionary)
                self.categoryList.append(category)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    func requestFailed(with error: Error, forRequest request: URLRequest) {
        print(error.localizedDescription)
    }


}

