//
//  NetworkPool.swift
//  SprotStore
//
//  Created by nguyen hula on 4/16/17.
//  Copyright © 2017 nguyen hula. All rights reserved.
//

import Foundation

final class NetworkPool {
    private let connectionCount = 3
    private var connections = [NetWorkConnection]()
    private var semaphore : DispatchSemaphore
    private var queue : DispatchQueue
    private var itemsCreated = 0
    
    static let sharedInstance = NetworkPool()
    
    private init()
    {
//        for _ in 0 ... connectionCount {
//            connections.append(NetWorkConnection())
//        }
        semaphore = DispatchSemaphore(value: connections.count)
        queue = DispatchQueue(label: "networkpoolQ")
    }
    
    private func doGetConnection() -> NetWorkConnection {
        semaphore.wait()
        var result: NetWorkConnection? = nil
        queue.sync {
            if self.connections.count > 0 {
                result = self.connections.remove(at: 0)
            } else if self.itemsCreated < self.connectionCount {
                result = NetWorkConnection()
                self.itemsCreated += 1
            }
        }
        return result!
    }
    
    private func doReturnConnection(conn : NetWorkConnection) {
        queue.async {
            self.connections.append(conn)
            self.semaphore.signal()
        }
    }
    
    class func getConnection() -> NetWorkConnection {
        return sharedInstance.doGetConnection()
    }
    
    class func returnConnection(conn : NetWorkConnection) {
        sharedInstance.doReturnConnection(conn: conn)
    }
}
