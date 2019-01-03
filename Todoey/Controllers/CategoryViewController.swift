//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Gustavo Bentemuller Junior on 02/01/19.
//  Copyright © 2019 BENT. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories ()

    }

    // MARK: - TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = categories[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    // MARk - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    // MARK: - Data Manipulation Methods
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todo category", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // what will happen when the user click
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            
            self.saveCategories()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            field.placeholder = "add new category"
            
        }
      
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveCategories () {
        
        do {
            try context.save()
        } catch {
            print("Erro try saving context \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        
        do {
            categories = try context.fetch(request)
        } catch {
            
        }
        
        tableView.reloadData()
    }
}
