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
    
    
 
    func startTimerToClearBitmasks(){
        
         Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(PCSpriteNode.setBitmasksToZero), userInfo: nil, repeats: false)
    }
    
    @objc func setBitmasksToZero(){
        if self.name == "sprite" {
//            self.physicsBody?.collisionBitMask = 0
//            self.physicsBody?.fieldBitMask = 0
            self.physicsBody?.contactTestBitMask = 0
            self.physicsBody?.categoryBitMask = 0
            print("sprite bitmasks set to zero - \(self.id)")
        } else {
            print("ground node")
        }
    }
    
    func getLocation() -> CGPoint {
        return self.frame.origin
    }
    
}
