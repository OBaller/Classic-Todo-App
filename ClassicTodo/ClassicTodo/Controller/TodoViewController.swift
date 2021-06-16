//
//  ViewController.swift
//  ClassicTodo
//
//  Created by apple on 16/06/2021.
//

import UIKit

class TodoViewController: UITableViewController {

    var itemArray = ["Find Mike", "Play Ball", "Buy groceries"]
    
    //set up userdefaults 1
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // final user defaults set up. 3
       if let item = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = item
        }
    }

    // MARK:- Tableview datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    // MARK:- Tableview delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the add bar button
            self.itemArray.append(textField.text!)
            
            
            // data persistence using userdefaults 2
            self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
           textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

