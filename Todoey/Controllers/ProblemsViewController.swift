//
//  ViewController.swift
//  Todoey
//
//  Created by Apple on 08/02/2019.
//  Copyright © 2019 Jamie King. All rights reserved.
//

import UIKit
import RealmSwift

class ProblemsViewController: UITableViewController{
    
    let realm = try! Realm()
   
    //var problems: Array = ["Utopia No Problems", "Utopia Traverse V5", "The Crack V3"]
    
    var boulderProblems : Results<Problems>?
    
    var selectedCategory : Boulder?{
        didSet{
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    //MARK - Tableview Datasource Methods
    
    //Declare number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boulderProblems?.count ?? 1
    }
    
    //Declare cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = boulderProblems?[indexPath.row]{
            cell.textLabel?.text = item.title
        }
        
        return cell
        
    }
    
    //Mark - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Checkmark validation when reusing cells in tableview
        
         performSegue(withIdentifier: "goToBoulder", sender: self)
        
        if let item = boulderProblems?[indexPath.row]{
            do{
                try realm.write {
                    item.done = !item.done
                }
            }catch{
                print("Error saving done status: \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        print("Cell was clicked")
        
        print(indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let destinationVC = segue.destination as! BoulderViewController
        if(segue.identifier == "goToBoulder"){
//            var selectedRow = self.tableView.indexPathForSelectedRow
            var moveVC: BoulderViewController = segue.destination as! BoulderViewController
            //moveVC.cellID = selectedRow!.row
            moveVC.cellID = self.realm.objects(Problems.self).map{$0.problemsID}.max() ?? 0
        }
        
    }
    
    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        

        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert

            

            if let currentCategory = self.selectedCategory {
//                var myvalue = self.realm.objects(Problems.self).map{$0.problemsID}.max() ?? 0
//                myvalue += 1
//                print("MYVALUE = \(myvalue)")
                do {
                    try self.realm.write {
                        let newItem = Problems()
                        newItem.title = textField.text!
                        currentCategory.problems.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            
            self.tableView.reloadData()

        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK - Model Manipulation Methods

    
    func loadItems() {

        boulderProblems = selectedCategory?.problems.sorted(byKeyPath: "problemsID")
        
        tableView.reloadData()
    }
    
//    func nextId() -> Int
//    {
//        return (realm.objects(Problems.self).map{$0.problemsID}.max() ?? 0) + 1
//
//    }
    
}

//MARK: - Search bar methods

extension ProblemsViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

//        boulderProblems = boulderProblems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        boulderProblems = boulderProblems?.filter("title CONTAINS[cd] %@", searchBar.text!)
        
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

