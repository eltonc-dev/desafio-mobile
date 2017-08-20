//
//  SubcategoryViewController.swift
//  MobfiqChallenge
//
//  Created by Elton Coelho on 19/08/17.
//  Copyright © 2017 Elton Coelho. All rights reserved.
//

import UIKit

class SubcategoryViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "default"
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if( cell == nil ) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
            
        }
        cell.textLabel?.text = "Sub categoria \(indexPath.row + 1)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToProducts", sender: nil)
    }
 

}
