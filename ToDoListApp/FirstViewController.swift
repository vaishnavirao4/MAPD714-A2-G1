//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Kisu on 2022-11-12.
//

import UIKit

struct Task {
    let title: String
    let status: String
}
let taskNames = [
    Task(title: " ̶T̶a̶s̶k̶ ̶1̶", status: "Completed"),
    Task(title: "Task 2", status: "Cancelled"),
    Task(title: "Task 3", status: "November 13 2022"),
    Task(title: "T̶a̶s̶k̶ ̶4̶", status: "Completed"),
    Task(title: "Task 5", status: "Overdue"),
]

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //var AllTasks = [Task]()
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TaskTableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! CustomCell
        let task = taskNames[indexPath.row]
        cell.TaskTitle.text = task.title
        cell.TaskSubtitle.text = task.status
        return cell
    }
    
    @IBOutlet weak var TaskTableView: UITableView!
    
    //var taskNames = ["Task 1", "T̶a̶s̶k̶ ̶2̶", "Task 3", "Task 4", "Task 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskTableView.dataSource = self
        TaskTableView.delegate = self
    }
}

