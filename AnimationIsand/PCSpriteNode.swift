//
//  PCShapeNode.swift
//  AnimationIsand
//
//  Created by Perrin Cloutier on 1/12/18.
//  Copyright © 2018 Perrin Cloutier. All rights reserved.
//

import UIKit
import SpriteKit

class PCSpriteNode: SKSpriteNode {

    var id: Int = Int()
    let replaceWithLargerShapeNotification: String = "replaceWithLargerShapeNotification"
 
//    func startTimerToClearBitmasks(){
//
//         Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(PCSpriteNode.setBitmasksToZero), userInfo: nil, repeats: false)
//    }
    
    func setBitmasksToZero(allContactedBodies: [SKPhysicsBody]){
        
        
        for i in allContactedBodies {
            
            if i == self.parent?.physicsBody {
                print("parent physics body")
                
            } else {
                i.collisionBitMask = 0
                i.fieldBitMask = 0
                i.contactTestBitMask = 0
                i.categoryBitMask = 0
                i.affectedByGravity = false
            }
        }
        
    }
    
    func getLocation() -> CGPoint {
        return self.frame.origin
    }
    
//    func startContactTimer(){
//        
//        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PCSpriteNode.countContact), userInfo: nil, repeats: true)
//    }
//    
//    @objc func countContact(){
//        
//        guard let bodies = self.physicsBody?.allContactedBodies() else {
//            print("no physics bods")
//            return
//        }
//        let count = bodies.count
//        if  count > 3 {
//            let location = self.getLocation()
//            let nc = NotificationCenter.default
//            nc.post(name: Notification.Name(replaceWithLargerShapeNotification), object: location)
//            setBitmasksToZero(allContactedBodies: bodies)
//        }
//    }
}
