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
import CoreData

class SecondViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemData = ToDoListItem()
    
    var hasDueDate: Bool = false;
    var isCompleted: Bool = false;
    var dueDate: Date = Date()
    var datePicker:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textView.layer.borderColor = UIColor.lightGray.cgColor
        self.textView.layer.borderWidth = 1
        
        taskName.text = itemData.name
        textView.text = itemData.notes
        hasDueDateSwitch.setOn(itemData.hasDueDate, animated:true)
        DatePicker.setDate(itemData.dueDate!, animated: true)
        datePicker = itemData.hasDueDate
        DatePicker.isHidden = !datePicker!
        isCompleteSwitch.setOn(itemData.isCompleted, animated:true)
    }
    
    //Function for each button and text field
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var hasDueDateSwitch: UISwitch!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var isCompleteSwitch: UISwitch!
    
    //Cancel button function
    @IBAction func CancelBtn(_ sender: UIBarButtonItem) {
        // create the actual alert controller view that will be the pop-up
        let alertController = UIAlertController(title: "Cancel Changes", message: "Are you sure you want to cancel?", preferredStyle: .alert)
        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Yes", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)

        present(alertController, animated: true, completion: nil)
    }
    
    //The task is completed switch function
    @IBAction func isCompletedToggle(_ sender: UISwitch) {
        if(sender.isOn) {
            isCompleted = true
        }
        else {
            isCompleted = false
        }
    }

    //Has due date switch function
    @IBAction func hasDueDateToggle(_ sender: UISwitch) {
        if(sender.isOn){
            hasDueDate = true
            DatePicker.isHidden = false
        }else{
            hasDueDate = false
            DatePicker.isHidden = true
        }
    }
    
    //Function for date picker
    @IBAction func DatePicker(_ sender: UIDatePicker) {
        dueDate = DatePicker.date
    }
    
    //Delete button function
    @IBAction func DeleteTask(_ sender: UIBarButtonItem) {
        // create the actual alert controller view that will be the pop-up
        let alertController = UIAlertController(title: "Delete Task", message: "You cannot undo this action", preferredStyle: .alert)

        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { _ in
            do
            {
                let models = try self.context.fetch(ToDoListItem.fetchRequest())
                let deleteTask = self.itemData
                self.context.delete(deleteTask)
            }
            catch {}
            do{
                try self.context.save()
                self.navigationController?.popViewController(animated: true)
            }
            catch {}
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)

        present(alertController, animated: true, completion: nil)
    }
    
    //Update button function
    @IBAction func UpdateTask(_ sender: UIBarButtonItem) {
        // create the actual alert controller view that will be the pop-up
        let alertController = UIAlertController(title: "Update Task", message: "Are you sure you want to update task details?", preferredStyle: .alert)

        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let updateAction = UIAlertAction(title: "Yes", style: .default) { _ in
            do
            {
                let models = try self.context.fetch(ToDoListItem.fetchRequest())
                    self.itemData.setValue(self.taskName.text, forKey: "name")
                    self.itemData.setValue(self.textView.text, forKey: "notes")
                    self.itemData.setValue(self.hasDueDate , forKey: "hasDueDate")
                    self.itemData.setValue(self.dueDate , forKey: "dueDate")
                    self.itemData.setValue(self.isCompleted , forKey: "isCompleted")
                    
                    try self.context.save()
                    self.navigationController?.popViewController(animated: true)
            }
            catch {}
        }
        alertController.addAction(cancelAction)
        alertController.addAction(updateAction)

        present(alertController, animated: true, completion: nil)
    }
    
}
