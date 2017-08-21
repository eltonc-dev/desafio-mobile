//
//  SearchViewController.swift
//  MobfiqChallenge
//
//  Created by Elton Coelho on 18/08/17.
//  Copyright © 2017 Elton Coelho. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController , UISearchBarDelegate , UITableViewDelegate ,
    UITableViewDataSource  {

    @IBOutlet weak var searchbar: UISearchBar!
    
    var mySearches : NSMutableArray?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchbar.becomeFirstResponder()
    }

    // MARK: - Search
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  "BUSCAS RECENTES"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "default"
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if( cell == nil ) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
            cell.accessoryType = .disclosureIndicator
        }
        cell.textLabel?.text = "Busca \(indexPath.row + 1)"
        return cell
    }
    
    
        

}
