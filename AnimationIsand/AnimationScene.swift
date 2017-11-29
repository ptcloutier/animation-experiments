//
//  AnimationScene.swift
//  AnimationIsand
//
//  Created by Perrin Cloutier on 11/28/17.
//  Copyright © 2017 Perrin Cloutier. All rights reserved.
//

import Foundation
import SpriteKit

class AnimationScene: SKScene {
    
    var animationBackground: SKSpriteNode!
    var colors = [UIColor]()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0, y: 1.0)
        colors.append(UIColor.red)
        colors.append(UIColor.green)
        colors.append(UIColor.blue)
        animationBackground = SKSpriteNode(color: UIColor.blue, size: size)
        animationBackground.anchorPoint = CGPoint(x: 0, y: 1.0)
        animationBackground.position = CGPoint(x: 0, y: 0)
        self.addChild(animationBackground)
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        addBubble()
        floatBubbles()
        removeExcessBubbles()
    }
    
    func addBubble() {
//        let bubble = SKSpriteNode(color: UIColor.white, size: CGSize(width: 10, height: 10))
        let bubble = SKShapeNode(circleOfRadius: CGFloat(arc4random_uniform(40)))
        bubble.fillColor = colors[Int(arc4random_uniform(2))]
        bubble.blendMode = .add
        animationBackground.addChild(bubble)
        let startingPoint = CGPoint(x: size.width/CGFloat(arc4random_uniform(10)), y: (-1)*size.height)
        bubble.position = startingPoint
    }
    
    func floatBubbles() {
        for child in animationBackground.children {
            let xOffset: CGFloat = CGFloat(arc4random_uniform(30)) - 10.0
            let yOffset: CGFloat = 20.0
            let newLocation = CGPoint(x: child.position.x + xOffset/2, y: child.position.y + yOffset)
            let moveAction = SKAction.move(to: newLocation, duration: 0.2)
            child.run(moveAction)
        }
    }
    
    func removeExcessBubbles() {
        
        for child in animationBackground.children {
            if child.position.y > 0 {
                child.removeFromParent()
            }
        }
    }
}
