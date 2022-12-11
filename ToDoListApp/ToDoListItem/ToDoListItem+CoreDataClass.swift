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
import Foundation
import CoreData

@objc(ToDoListItem)
public class ToDoListItem: NSManagedObject {}
