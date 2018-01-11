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
    var count: Int = 0
    var nodes: [SKShapeNode] = []
    let shapeNodeWidth: CGFloat = 25.0
    let timeInterval: TimeInterval = 0.5
    let maxCount = 480
    var pool: [SKShapeNode] = []
    var container: SKView?
    var shapeSize: CGSize = CGSize()
    var atLocation: CGPoint = CGPoint()

    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        // set shape size
        shapeSize = CGSize.init(width: CGFloat(shapeNodeWidth)/2.0, height: CGFloat(shapeNodeWidth))
       
        // set shape origin point
        atLocation = topCenterStartingPoint()

        // import color palette for shapes
        setupColors()
        
        animationBackground = SKSpriteNode(color: UIColor.clear, size: size)
        anchorPoint = CGPoint(x: 0, y: 1.0)
        animationBackground.anchorPoint = anchorPoint
        animationBackground.position = CGPoint(x: 0, y: 0)
        self.addChild(animationBackground)
        
        // populate nodes to reuse
        createPool()
        
        // create bottom edge
        self.scaleMode = .aspectFit
        self.physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)
        
        Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(AnimationScene.addShape), userInfo: nil, repeats: true)
        
    }
    
    
    
    func setupColors(){
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
    }
    
    
    
    func randomStartingPoint() -> CGPoint{
        
        let randomStartingPoint = CGPoint(x: CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.size.width))), y: (CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.size.height)))))
        return randomStartingPoint
    }
    
    
    
    func topCenterStartingPoint() -> CGPoint {
        let topCenterStartingPoint = CGPoint(x: (UIScreen.main.bounds.midX+CGFloat(arc4random_uniform(2))), y: 1)
        return topCenterStartingPoint
    }
    

    
    
    @objc func addShape(){
        
        
        if count >= maxCount {
            
            for n in nodes {
                n.glowWidth = 1.0
                n.physicsBody?.affectedByGravity = false
            }
            print("done!")
            return
        }
         else {
//            cacheShapes()
            addShapeNodeToScene()
        
        }
    }
    
    
    
    

    func createPool(){
    
        var node: SKShapeNode
       
        while pool.count <= 50 {
            node = createNodeForPool()
            pool.append(node)
        }
        
    }
    
    
    func createNodeForPool() -> SKShapeNode {
        let node = SKShapeNode(circleOfRadius: shapeSize.width)
        return node
    }
   
    
    
    
    func getShapeNode() -> SKShapeNode {
        
        if pool.count == 0 {
            cacheShapes()
        }
        let shapeNode: SKShapeNode = pool[0]
        pool.remove(at: 0)
        
        print("pool remove - count \(pool.count)")
        return shapeNode
    }
    
    
    
    func addShapeNodeToScene(){
        
        let shape = getShapeNode()
        shape.fillColor = UIColor.init(red: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, green: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, blue: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, alpha: 1.0)
        shape.blendMode = .add
        shape.strokeColor = shape.fillColor
        shape.alpha = 1.0
        shape.glowWidth = 0.3
        // apply physics
        
        shape.physicsBody = SKPhysicsBody(rectangleOf: shapeSize)
        shape.physicsBody?.affectedByGravity = true
        shape.physicsBody?.linearDamping = 5.0
        shape.physicsBody?.usesPreciseCollisionDetection = false
        animationBackground.addChild(shape)
        let x = CGFloat(arc4random_uniform(UInt32(20)))+(atLocation.x)
        let y = (-1)*atLocation.y
        shape.position = CGPoint(x: x, y: y)
    }
    
    
    
    func cacheShapes(){
   
       
        let cacheTexture: SKTexture = SKView().texture(from: self, crop: UIScreen.main.bounds)!
        animationBackground.texture = cacheTexture
        

        for child in animationBackground.children {
            let n = child as! SKShapeNode
            n.removeFromParent()
            self.pool.append(n)
             print("pool append - count \(self.pool.count)")
            let location = n.getLocation()
            print("node location - \(location.x), \(location.y)")
        }
    }
    
    
    func adjustBottomEdge(){
        
    }
    
    
    
}
