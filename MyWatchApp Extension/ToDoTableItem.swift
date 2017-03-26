//
//  ToDoTableItem.swift
//  WatchApp
//
//  Created by Андрей Трошкин on 26.03.17.
//  Copyright © 2017 Андрей Трошкин. All rights reserved.
//

import Foundation
import WatchKit
class ToDoTableItem: NSObject{
    
    @IBOutlet var group: WKInterfaceGroup!
    @IBOutlet var ToDoLabel: WKInterfaceLabel!
    
    var label : String?{
        didSet {
            ToDoLabel.setText(label)
        }
    }
    var done: Bool = false{
        didSet{
            group.setBackgroundColor(done ? UIColor.green : nil)
        }
    }
    
    
}
