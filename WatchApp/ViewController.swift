//
//  ViewController.swift
//  WatchApp
//
//  Created by Андрей Трошкин on 26.03.17.
//  Copyright © 2017 Андрей Трошкин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var toDoListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoListTable.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateList( _:)), name: Notification.Name(rawValue: ToDoListManager.Event.updateList.name), object: nil)
    }
    func updateList(_ notification: Notification){
        toDoListTable.reloadData()
    }
    override func viewDidDisappear(_ animated: Bool) {
       super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoListManager.shared.list.count
        
    }
    private enum Cell: String{
        case toDoItem = "ToDoItemCell"
        var identifier: String{
            return rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.toDoItem.identifier) as! ToDoItemTableViewCell
        let item = ToDoListManager.shared.list[indexPath.row]
        cell.toDoLabel.text = item.title
        cell.done = item.done
        return cell
    }
    
}
