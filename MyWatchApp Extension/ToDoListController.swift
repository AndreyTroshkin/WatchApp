//
//  InterfaceController.swift
//  MyWatchApp Extension
//
//  Created by Андрей Трошкин on 26.03.17.
//  Copyright © 2017 Андрей Трошкин. All rights reserved.
//

import WatchKit
import Foundation


class ToDoListController: WKInterfaceController {

    @IBOutlet var toDoListTable: WKInterfaceTable!
    
    private var selectedItem = -1
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
   
        // Configure interface objects here.
    }
    private func initTable(){
        ToDoListManager.shared.requestList()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        NotificationCenter.default.addObserver(self, selector: #selector(self.toDoListUpdated(_:)), name: Notification.Name(rawValue: ToDoListManager.Event.listUpdate.name), object: nil)
        initTable()
    }
    
    func toDoListUpdated(_ notification: Notification){
        fillTable()
        
    }
    
    private enum Cell: String{
        case toDoItem = "ToDoItemCell"
        var identifier: String{
            return rawValue
        }
    }
    
    private func fillTable(){
    
        let list = ToDoListManager.shared.toDoList
        toDoListTable.setNumberOfRows(list.count, withRowType: Cell.toDoItem.identifier)
        for i in 0..<list.count{
            if let row = toDoListTable.rowController(at: i) as? ToDoTableItem{
                let item = list[i]
                row.label = item.title
                row.done = item.done
            }
        }
        
        
    }
    
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        NotificationCenter.default.removeObserver(self)
    }

}
