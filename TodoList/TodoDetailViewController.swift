//
//  TodoDetailViewController.swift
//  TodoList
//
//  Created by Conner on 8/3/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class TodoDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet var importantSwitch: UISwitch!
    @IBOutlet var todoTextField: UITextField!
    
    var todoTableVC: TodoTableViewController? = nil
    
    @IBAction func addTodo(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let newTodo = Todo(context: context)
            
            newTodo.important = importantSwitch.isOn
            
            if let name = todoTextField.text {
                newTodo.name = name
            }
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }
}
