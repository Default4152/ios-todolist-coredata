//
//  TodoCompleteViewController.swift
//  TodoList
//
//  Created by Conner on 8/3/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class TodoCompleteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let todo = todo else { return }
        
        if todo.important {
            guard let todoName = todo.name else { return }
            todoItemNameLabel.text = "‼️" + todoName
        } else {
            todoItemNameLabel.text = todo.name
        }
        
    }

    @IBAction func completeTodo(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            guard let todo = todo else { return }
            context.delete(todo)
        }
        
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        navigationController?.popViewController(animated: true)
    }

    @IBOutlet var todoItemNameLabel: UILabel!
    var todo: Todo?
}
