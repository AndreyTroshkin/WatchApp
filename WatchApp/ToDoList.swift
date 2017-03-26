//
//  ToDoList.swift
//  WatchApp
//
//  Created by Андрей Трошкин on 26.03.17.
//  Copyright © 2017 Андрей Трошкин. All rights reserved.
//

import Foundation
import SwiftyJSON

class ToDoItem {
    let title: String
    let done: Bool
    init(title: String, done: Bool){
        self.title = title
        self.done = done
    }
    
}

class ToDoList {
    typealias JSONItem = [String : AnyObject]
    private var toDoItems = [ToDoItem]()
    init(){
        
    }
    var count: Int{
        return toDoItems.count
    }
    init(fromJSON list: String){
        let items = JSON(parseJSON: list).arrayValue
        for item in items {
            let toDo = ToDoItem(title: item["title"].stringValue, done: item["done"].boolValue)
            toDoItems.append(toDo)
        }
    }
    func add(item: ToDoItem){
        toDoItems.append(item)
    }
    func remove(at index: Int){
        toDoItems.remove(at: index)
    }
    subscript(index: Int) -> ToDoItem{
        return toDoItems[index]
    }
    func toJSON() -> String{
        var list: [JSONItem] = []
        for item in toDoItems{
            list.append(convertToJson(item: item))
        }
        let data = try! JSONSerialization.data(withJSONObject: list, options: [])
        
        return String(data: data, encoding: String.Encoding.ascii)!
    }
    
    
    private func convertToJson(item: ToDoItem) -> JSONItem{
        return ["title": item.title as AnyObject, "done" : item.done as AnyObject]
    }
}
