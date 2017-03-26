//
//  ToDoListManager.swift
//  WatchApp
//
//  Created by Андрей Трошкин on 26.03.17.
//  Copyright © 2017 Андрей Трошкин. All rights reserved.
//

import Foundation
class ToDoListManager {
    
    private(set) var list = ToDoList()
    
    enum Event: String{
        case updateList = "UPDATE_LIST"
        var name: String{
            return rawValue
        }
    }
    
    static let shared = ToDoListManager()
    private init(){
        
    }
    
    func updateList(fromJSON json: String){
        list = ToDoList(fromJSON: json)
        NotificationCenter.default.post(name: Notification.Name(rawValue: Event.updateList.name), object: nil)
    }
    func loadList(){
        let path = Bundle.main.path(forResource: "ListData", ofType: "json")!
        let data = try! String(contentsOfFile: path)
        list = ToDoList(fromJSON: data)
    }
}
