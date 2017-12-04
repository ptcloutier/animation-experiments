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
    var bubbleShouldGrow: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0, y: 1.0)
        colors.append(UIColor.red)
        colors.append(UIColor.green)
        colors.append(UIColor.blue)
        colors.append(UIColor.yellow)
        colors.append(UIColor.purple)
        colors.append(UIColor.orange)
        let vintColors = Colors.getVintage()
        let psyColors = Colors.getPsychedelicIceCreamShopColors()
        for x in vintColors {
            colors.append(x)
        }
        for x in psyColors {
            colors.append(x)
        }
        animationBackground = SKSpriteNode(color: UIColor.clear, size: size)
        animationBackground.anchorPoint = CGPoint(x: 0, y: 1.0)
        animationBackground.position = CGPoint(x: 0, y: 0)
        self.addChild(animationBackground)
        
        
        
    }
    
    
    @objc func handleParameterGesture(gestureRecognizer: UIGestureRecognizer){
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed || gestureRecognizer.state == .ended {
            let location =  gestureRecognizer.location(in: self.view)
            tapAddBubble(atLocation: location)

        }
    }

    override func didMove(to view: SKView) {
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(AnimationScene.handleParameterGesture))
        view.addGestureRecognizer(pan)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(AnimationScene.handleParameterGesture))
        view.addGestureRecognizer(tap)
//        let singleTap = UITapGestureRecognizer(target:self, action: #selector(AnimationScene.handleSingleTap))
//        singleTap.numberOfTouchesRequired = 1
//        view.isUserInteractionEnabled = true
//        view.addGestureRecognizer(singleTap)
    }
    
    
    
    //event handler
    @objc func handleSingleTap(sender:UITapGestureRecognizer){
        let location = sender.location(in: self.view)
        print("location x: \(location.x), y: \(location.y)")
        tapAddBubble(atLocation: location)
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        let randomStartingPoint = CGPoint(x: CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.size.width))), y: (-1)*(CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.size.height)))))
        addBubble(atLocation: randomStartingPoint)
        floatBubbles()
        removeExcessBubbles()
    }
    
    func addBubble(atLocation: CGPoint) {
        let bubble = SKShapeNode(circleOfRadius: CGFloat(arc4random_uniform(1)))
        bubble.fillColor = UIColor.init(red: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, green: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, blue: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, alpha: 1.0)
        bubble.blendMode = .add
        bubble.strokeColor = bubble.fillColor
        bubble.alpha = 1.0
        bubble.glowWidth = bubble.frame.size.width
        animationBackground.addChild(bubble)
//         let bottomStartingPoint = CGPoint(x: CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.size.width))), y: (-1)*size.height)
//        let randomStartingPoint = CGPoint(x: CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.size.width))), y: (-1)*(CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.size.height)))))
        
      
        bubble.position = atLocation //CGPoint(x: x, y: y)
    }
    
    func tapAddBubble(atLocation: CGPoint){
        
        let bubble = SKShapeNode(circleOfRadius: CGFloat(arc4random_uniform(10)))
        bubble.fillColor = UIColor.init(red: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, green: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, blue: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, alpha: 1.0)
        bubble.blendMode = .add
        bubble.strokeColor = bubble.fillColor
        bubble.alpha = 1.0
        bubble.glowWidth = bubble.frame.size.width
        animationBackground.addChild(bubble)
        let x = atLocation.x
        let y = (-1)*atLocation.y
        bubble.position = CGPoint(x: x, y: y)
    }
    
    
    func floatBubbles() {
        for child in animationBackground.children {
            
            let bubble = child as! SKShapeNode
            
            bubble.glowWidth += 0.1 //CGFloat(arc4random_uniform(UInt32(1.0)))  //0.1
            bubble.alpha -= 0.005   //0.05 and 0.5 are awesome
            
            let xOffset: CGFloat = CGFloat(arc4random_uniform(30)) - 10.0
            let yOffset: CGFloat = 10.0
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
