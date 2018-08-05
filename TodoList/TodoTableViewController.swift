//
//  TodoTableViewController.swift
//  TodoList
//
//  Created by Conner on 8/3/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController {

    var todos: [Todo] = []

    override func viewWillAppear(_ animated: Bool) {
        getTodos()
    }

    func getTodos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            do {
                let todosFromCD = try context.fetch(Todo.fetchRequest())
                if let fetchedTodos = todosFromCD as? [Todo] {
                    todos = fetchedTodos
                    tableView.reloadData()
                }
            } catch {
                NSLog("\(error)")
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        let currentTodo = todos[indexPath.row]

        if currentTodo.important {
            if let name = currentTodo.name {
                cell.textLabel?.text = "‼️" + name
            }

        } else {
            if let name = currentTodo.name {
                cell.textLabel?.text = name
            }
        }

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let todoDetail = segue.destination as? TodoDetailViewController {
            todoDetail.todoTableVC = self
        }

        if let todoComplete = segue.destination as? TodoCompleteViewController {
            if let tappedOnTodo = sender as? Todo {
                todoComplete.todo = tappedOnTodo
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todos[indexPath.row]
        performSegue(withIdentifier: "ShowCompleteTodo", sender: todo)
    }
}
