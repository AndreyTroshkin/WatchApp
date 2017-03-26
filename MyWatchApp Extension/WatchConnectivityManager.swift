//
//  WatchConnectivityManager.swift
//  WatchApp
//
//  Created by Андрей Трошкин on 26.03.17.
//  Copyright © 2017 Андрей Трошкин. All rights reserved.
//

import Foundation
import WatchConnectivity

class WatchConnectivityAction {
    
    typealias AnswerHandler = ([String: Any]) -> Void
    typealias ErrorHandler = (Error) -> Void
    typealias Message = [String : AnyObject]
    let answer: AnswerHandler
    let error : ErrorHandler
    let message: Message
    init(message:Message, answer: @escaping AnswerHandler = { _ in}, error: @escaping ErrorHandler = {_ in}){
        self.answer = answer
        self.error = error
        self.message = message
    }
    
}

class WatchConnectivityManager : NSObject{
    static let shared = WatchConnectivityManager()
    
    private var queue = [WatchConnectivityAction]()
    
    private var session : WCSession{
        return WCSession.default()
    }
    
    var isActive: Bool{
        return session.activationState == .activated
    }
    
    
    private override init(){
        
    }
    
    func initConnectivity(){
        session.delegate = self
        session.activate()
    }
    
    func push(message: WatchConnectivityAction) -> Bool{
        queue.append(message)
        processQuery()
        return true
    }
    fileprivate func processQuery(){
        if isActive {
            for callback in queue{
                session.sendMessage(callback.message, replyHandler: callback.answer, errorHandler: callback.error)
            }
            queue.removeAll()
        }
    }
}

extension WatchConnectivityManager: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if case .activated = activationState{
            processQuery()
        }
    }
}



