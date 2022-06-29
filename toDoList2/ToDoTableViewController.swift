//
//  ToDoTableViewController.swift
//  toDoList2
//
//  Created by Scholar on 6/27/22.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    var toDos : [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func viewWillAppear(_ animated : Bool)
    {
        getToDos()
    }
    
    func getToDos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {

            if let coreDataToDos = try? context.fetch(Task.fetchRequest()) as? [Task] {
                        toDos = coreDataToDos
                        tableView.reloadData()
                }

          }
    }
    
    func createToDos() -> [ToDo]
    {
        let swift = ToDo()
        swift.name = "we know swift"
        
        let cat = ToDo(name : "pet stan", important : true)
        
        return [swift, cat]
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView : UITableView, numberOfRowsInSection : Int) -> Int
    {
        return toDos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

      let toDo = toDos[indexPath.row]

      if let name = toDo.name {
        if toDo.important {
            cell.textLabel?.text = "🐱" + name
        } else {
            cell.textLabel?.text = toDo.name
        }
      }

      return cell
    }
    
//    override func prepare (for segue : UIStoryboardSegue, sender : Any?)
//    {
//        if let addVC = segue.destination as? ToDoViewController
//        {
//            addVC.previousVC = self
//        }
//
//        print(sender)
//
//        if let completeVC = segue.destination as? CompletedToDoViewController
//        {
//            print("vghvjgj")
//            print("here")
//            completeVC.selectedToDo = sender as! ToDo
//            completeVC.previousVC = self
//            if let toDo = sender as? ToDo
//            {
//                print("here")
//                completeVC.selectedToDo = toDo
//                print(toDo)
//                completeVC.previousVC = self
//            }
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
        if let addVC = segue.destination as? ToDoViewController {
          addVC.previousVC = self
        }
         
        if let completeVC = segue.destination as? CompletedToDoViewController {
          if let toDo = sender as? Task {
            completeVC.selectedToDo = toDo
            completeVC.previousVC = self
          }
        }
      }
    
    override func tableView(_ tableView : UITableView, didSelectRowAt indexPath : IndexPath)
    {
        performSegue(withIdentifier : "moveToComplete", sender : toDos[indexPath.row])
    }

}
