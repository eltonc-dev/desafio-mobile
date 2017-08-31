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
    
    var mySearches : [String] = [String]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        
        
        if let searches =  UserDefaults.standard.array(forKey: Constants.UserDefault.KEY_SEARCHES) as? [String] {
            self.mySearches = searches
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchbar.becomeFirstResponder()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem?.title = ""
    }

    // MARK: - Search
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if( self.mySearches.count >= 10 ) {
            self.mySearches.removeFirst()
        }
        
        self.mySearches.append( searchBar.text! )
        UserDefaults.standard.set(self.mySearches, forKey: Constants.UserDefault.KEY_SEARCHES)
        
        self.performSegue(withIdentifier: "goToProducts", sender: searchBar.text!)
        
    
        
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mySearches.count
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
        
        //lista reversa para mostrar do mais recente ao mais antigo
        let index = self.mySearches.count - 1
        let currentSearch = self.mySearches[ index - indexPath.row ]
        cell.textLabel?.text = currentSearch
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let index = self.mySearches.count - 1
        let currentSearch = self.mySearches[ index - indexPath.row ]
        self.performSegue(withIdentifier: "goToProducts", sender: currentSearch)
        
        
    }
    
    
    
        

}
