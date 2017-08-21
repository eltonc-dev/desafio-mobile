//
//  SubcategoryViewController.swift
//  MobfiqChallenge
//
//  Created by Elton Coelho on 19/08/17.
//  Copyright © 2017 Elton Coelho. All rights reserved.
//

import UIKit

class SubcategoryViewController: UITableViewController {

    var category : Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = category.name
        self.navigationController?.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        
        self.tableView.tableFooterView = UIView()
    }

    
    // MARK: - Table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.category.subCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "default"
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if( cell == nil ) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
            
        }
        if( indexPath.row == 0 ) {
            cell.backgroundColor = UIColor.groupTableViewBackground
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        let currentCategory = self.category.subCategories[indexPath.row]
        
        cell.textLabel?.text = currentCategory.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCategory = self.category.subCategories[indexPath.row]
        self.performSegue(withIdentifier: "goToProducts", sender: currentCategory)
    }
    
    // MARK: - segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productsVC : ProductsViewController = segue.destination as! ProductsViewController
        
        productsVC.category = sender as! Category
        
    }
 

}
