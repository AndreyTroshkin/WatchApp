//
//  MessageAPI.swift
//  WatchApp
//
//  Created by Андрей Трошкин on 26.03.17.
//  Copyright © 2017 Андрей Трошкин. All rights reserved.
//

import Foundation
class MessageAPI {
 
    enum Message: String{
        case action = "Action"
        case toDoList = "ToDoList"
        var identifier: String{
            return rawValue
        }
        
    }
    enum MessageType: String{
        case getToDoList = "GetToDoList"
        case updateToDoList = "UpdateToDoList"
        var identifier: String{
            return rawValue
        }
    }
    private init(){
        
    }
    
}
