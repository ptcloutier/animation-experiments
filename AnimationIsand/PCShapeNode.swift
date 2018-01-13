//
//  PCShapeNode.swift
//  AnimationIsand
//
//  Created by Perrin Cloutier on 1/12/18.
//  Copyright © 2018 Perrin Cloutier. All rights reserved.
//

import UIKit
import SpriteKit

class PCShapeNode: SKShapeNode {

    var id: Int = Int()
    
    
 
    func startTimerToEraseBitmasks(){
        
         Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(PCShapeNode.setBitmasksToZero), userInfo: nil, repeats: false)
    }
    
    @objc func setBitmasksToZero(){
        if self.name == "shape" {
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.fieldBitMask = 0
//        self.physicsBody?.categoryBitMask = 0
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.contactTestBitMask = 0
        print("bitmasks set to zero for shapenode - \(self.id)")
        } else {
            print("ground node")
        }
    }
    
    func getLocation() -> CGPoint {
        return self.frame.origin
    }
    
}
