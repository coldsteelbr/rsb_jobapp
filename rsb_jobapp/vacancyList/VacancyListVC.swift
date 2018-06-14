//
//  VacancyListVC.swift
//  rsb_jobapp
//
//  Created by Roman Brazhnikov on 13.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import UIKit

class VacancyListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    let repository = Repository.getInstance()
    var vacancyArray = [Vacancy]()
    
    //
    //  Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // simulating search request
        vacancyArray = repository.getVacanciesFor(Request: "ios")
        
        // setting table view cell height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        
        // listening for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    //
    //  SearchBarDelegate protocol
    //
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    
    //
    //  DataSource protocol
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacancyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StandardCell", for: indexPath)
        
        let item = vacancyArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.description
        
        return cell
    }
    
    //
    //  Logic
    //
    
    // Dismisses the soft keyboard
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func keyBoardWillChange(notification: Notification){
        print("Keyboard will show: \(notification.name.rawValue)")
        view.frame.origin.y = -300
    }
    
}
