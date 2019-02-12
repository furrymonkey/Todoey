//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Apple on 12/02/2019.
//  Copyright © 2019 Jamie King. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    var itemArray: Array = [Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    }
    
    //MARK: - TableView Manipulation Methods

    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        print("I was pressed")
    }
    
    //MARK: - TableView Delegate Methods
}
