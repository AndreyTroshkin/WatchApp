//
//  ToDoListManager.swift
//  WatchApp
//
//  Created by Андрей Трошкин on 26.03.17.
//  Copyright © 2017 Андрей Трошкин. All rights reserved.
//

import Foundation

class ToDoListManager{
    enum Event: String{
        case listUpdate = "LIST_UPDATE"
        var name:String{
            return rawValue
        }
    }
    
    private(set) var toDoList = ToDoList()
    
    static let shared = ToDoListManager()
    
    private init(){
        
    }
    func requestList(){
        let message = [
            MessageAPI.Message.action.identifier: MessageAPI.MessageType.getToDoList.identifier]
        let action = WatchConnectivityAction(message: message as WatchConnectivityAction.Message, answer: {
            data in
            DispatchQueue.main.async {
                let json = data[MessageAPI.Message.toDoList.identifier] as! String
                self.toDoList = ToDoList(fromJSON: json)
                NotificationCenter.default.post(name: Notification.Name(rawValue: Event.listUpdate.name), object: nil)
            }
        })
        _ = WatchConnectivityManager.shared.push(message: action)
        
    }
    func sendUpdatedList(){
        let message = [
            MessageAPI.Message.action.identifier: MessageAPI.MessageType.updateToDoList.identifier, MessageAPI.Message.toDoList.identifier: toDoList.toJSON()]
        _ = WatchConnectivityManager.shared.push(message: WatchConnectivityAction(message: message as WatchConnectivityAction.Message))
    }
    
}
