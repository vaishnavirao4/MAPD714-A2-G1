/**App Name: ToDoListApp
Version: 3.0
Created on: 10-12-2022
 
 
Created by:
 
 
Krishna Patel 301268911
Vaishnavi Santhapuri 301307031
Kowndinya Varanasi 301210621
 
 
 Description:
 This is a ToDoList App that will be used to perform the daily tasks
 The plus button will add a new task into the main page
 We have included switch to update if the task is completed or not.
 We have used the scroll view calendar to set a due date for a particular task.
 The cancel button will move back from the main page,
 The delete button will delete the current task,
 The update button will update the existing task
 For the part 3 we included swiping gestures
 If we swipe from left to write, we can edit the task
 If we swipe from right to left, we can delete the task

*/

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Function for tasks
    @IBOutlet weak var TaskTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var models = [ToDoListItem]()
    var itemData = ToDoListItem()
    
    var hasDueDate: Bool = false;
    var isCompleted: Bool = false;
    var dueDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskTableView.dataSource = self
        TaskTableView.delegate = self
        getAllItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllItems()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = TaskTableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! CustomCell
    
        cell.TaskTitle.text = model.name
        cell.TaskSubtitle.text = model.notes
        
        if (models[indexPath.row].hasDueDate == true) {
            // Create date formatter
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, MMMM d,yyyy"
            var formattedDateInString = formatter.string(from: models[indexPath.row].dueDate!)
            cell.TaskSubtitle?.text = formattedDateInString
            //cell.TaskSubtitle.text = model.dueDate
        }
        
        cell.isCompleteSwitch?.tag = indexPath.row
        cell.isCompleteSwitch?.addTarget(self, action: #selector(isCompletedBtn), for:UIControl.Event.valueChanged)
        
        if (models[indexPath.row].isCompleted == true) {
            cell.isCompleteSwitch?.setOn(true, animated:false)
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: models[indexPath.row].name!)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            cell.TaskTitle?.attributedText = attributeString
            cell.TaskSubtitle?.text = "Completed"
        }
        else {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: models[indexPath.row].name!)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 0, range: NSRange(location: 0, length: attributeString.length))
            cell.TaskTitle?.attributedText = attributeString
            cell.isCompleteSwitch?.setOn(false, animated:false)
        }

        cell.editTask?.tag = indexPath.row
        cell.editTask?.addTarget(self, action: #selector(editTaskBtn(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    //swiping functionalities from right to left
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let complete = UIContextualAction(style: .normal, title: "Complete"){ _, _, _ in
            let todo = self.models[indexPath.row]
            self.isCompleted = true
            todo.setValue(self.isCompleted, forKey: "isCompleted")
            do
            {
                try self.context.save()
                self.getAllItems()
            }
            catch{}
        }
        let delete = UIContextualAction(style: .destructive, title: "Delete"){ _, _, _ in
            self.context.delete(self.models[indexPath.row])
            do
            {
                try self.context.save()
                self.getAllItems()
            }
            catch{}
        }
        complete.backgroundColor = .systemYellow
        return UISwipeActionsConfiguration(actions: [delete,complete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        // update task on left to right swipe
       let edit = UIContextualAction(style: .normal, title: "Edit"){(action,view,nil) in
           let subMenuVC = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController
           let todo = self.models[indexPath.row]
           subMenuVC?.itemData = todo
           self.navigationController?.pushViewController(subMenuVC!, animated: true)
           print("edit")}
       edit.backgroundColor=UIColor.init(red: 0/255, green: 0/255, blue: 255/255, alpha: 1)
       return UISwipeActionsConfiguration(actions: [edit])
    }
    
    //Function for edit task button
    @objc func editTaskBtn(sender: UIButton) {
        let selectedIndex = IndexPath(row: sender.tag, section: 0)
        let selectedTask = models[selectedIndex[1]]
        print(selectedTask.name!)
    
        let secondViewController = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
              
        // Pass data to SecondViewController
        secondViewController?.itemData = models[selectedIndex[1]]
               navigationController?.pushViewController(secondViewController!, animated: true)
    }
    
    //Switch function for task status
    @objc func isCompletedBtn(_ sender: UISwitch) {
        let selectedIndex = IndexPath(row: sender.tag, section: 0)
        let selectedTask = models[selectedIndex[1]]
        do
        {
            let models = try self.context.fetch(ToDoListItem.fetchRequest())
            try self.context.save()
            getAllItems()
        }
        catch {}
    }
    
    //Function for adding a new task
    @IBAction func AddTask(_ sender: UIButton) {

        // create the actual alert controller view that will be the pop-up
        let alertController = UIAlertController(title: "Add New Task", message: "Enter Task Name", preferredStyle: .alert)

        alertController.addTextField { (name) in
            // configure the properties of the text field
            name.placeholder = "Task Name"
        }
        alertController.addTextField { (notes) in
            // configure the properties of the text field
            notes.placeholder = "Notes"
        }

        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in

            // this code runs when the user hits the "save" button
            let taskName = alertController.textFields![0].text
            let taskNotes = alertController.textFields![1].text
            self.createItem(name: taskName!,notes: taskNotes!,hasDueDate:self.hasDueDate,dueDate:self.dueDate,isCompleted:self.isCompleted)
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }
    
    // Core Data
    //The values entered gets stored in a core database
    func getAllItems() {
        do {
            models = try context.fetch(ToDoListItem.fetchRequest())
            DispatchQueue.main.async {
                self.TaskTableView.reloadData()
            }
        }
        catch {}
    }
    
    func createItem(name:String,notes:String,hasDueDate:Bool,dueDate:Date,isCompleted:Bool) {
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.notes = notes
        newItem.hasDueDate = hasDueDate
        newItem.dueDate = dueDate
        newItem.isCompleted = isCompleted
        do {
            try context.save()
            getAllItems()
        }
        catch {}
    }
}

