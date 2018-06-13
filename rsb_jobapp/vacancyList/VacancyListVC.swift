//
//  VacancyListVC.swift
//  rsb_jobapp
//
//  Created by Roman Brazhnikov on 13.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import UIKit

class VacancyListVC: UITableViewController {
    
    let repository = Repository.getInstance()
    var vacancyArray = [Vacancy]()
    
    //
    //  Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        vacancyArray = repository.getVacanciesFor(Request: "iOS")
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
    //
    //  DataSource protocol
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacancyArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StandardCell", for: indexPath)
        
        let item = vacancyArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.description
        
        return cell
    }
    
}
