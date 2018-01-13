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
    var nodes: [PCShapeNode] = []
    let shapeNodeWidth: CGFloat = 30.0
    let timeInterval: TimeInterval = 0.5
    let maxCount = 5000
    var pool: [PCShapeNode] = []
    var shapeSize: CGSize = CGSize()
    var atLocation: CGPoint = CGPoint()
    var splinePoints: [CGPoint] = []
    var groundPoints: [CGPoint] = []
    var nodeYLocations: [CGFloat] = []
    var groundPointA: CGPoint = CGPoint()
    var groundPointB: CGPoint = CGPoint()
    var groundPointC: CGPoint = CGPoint()
    var container: SKView?

    var apexX: CGFloat = CGFloat()
    var apexY: CGFloat = CGFloat()
    var poolCount: Int = 150
    var raiseApexY: CGFloat = CGFloat()
    var raiseYDrop: CGFloat = CGFloat()
    var ground = PCShapeNode()
    
    
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
        
        
        
        // create bottom edge
        let bounds = UIScreen.main.bounds
        
        groundPointA = CGPoint(x: 0, y:(-1)*bounds.maxY)
        groundPointB = CGPoint(x: bounds.maxX/2.0, y: (-1)*bounds.maxY )
        groundPointC = CGPoint(x: bounds.maxX, y: (-1)*bounds.maxY)

        groundPoints = [groundPointA, groundPointB, groundPointC]
        
        
        setupGround(points: groundPoints)

        self.scaleMode = .aspectFit
        self.physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)
        
        // start drop shapes
        Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(AnimationScene.addShape), userInfo: nil, repeats: true)
        
        // set raiseApexY
        raiseApexY = 100.0
        apexY = groundPointB.y
        
    }
    
    
    func setupGround(points: [CGPoint]){
        
        splinePoints = points
        ground.removeFromParent()
        ground = PCShapeNode(splinePoints: &splinePoints,
                                 count: splinePoints.count)
        ground.name = "ground"
        ground.strokeColor = UIColor.clear
        
        ground.lineWidth = 5
        ground.physicsBody = SKPhysicsBody(edgeChainFrom: ground.path!)
        ground.physicsBody?.isDynamic = false
        animationBackground.addChild(ground)

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
    

    
    
    @objc func addShape(){  // until timer is up, then present alert
        
        
        if count >= maxCount {
            
            for n in nodes {
                n.glowWidth = 1.0
                n.physicsBody?.affectedByGravity = false
            }
            print("done!")
            return
        }
         else {
            addShapeNodeToScene()
        
        }
    }
    
    
    
    
    
    
    
    
    func addShapeNodeToScene(){
        
        let shape = PCShapeNode(circleOfRadius: shapeSize.width)
        shape.startTimerToEraseBitmasks()
        shape.name = "shape"
        shape.fillColor = UIColor.init(red: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, green: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, blue: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, alpha: 1.0)
        shape.blendMode = .add
        shape.strokeColor = shape.fillColor
        shape.alpha = 1.0
        shape.glowWidth = 0.3
        // apply physics
        
        shape.physicsBody = SKPhysicsBody(circleOfRadius: shapeSize.width)
        shape.physicsBody?.affectedByGravity = true
        shape.physicsBody?.linearDamping = 5.0
        shape.physicsBody?.angularDamping = 5.0
        shape.physicsBody?.usesPreciseCollisionDetection = false
        animationBackground.addChild(shape)
        let x = CGFloat(arc4random_uniform(UInt32(20)))+(atLocation.x)
        let y = (-1)*atLocation.y
        let location = CGPoint(x: x, y: y)
        shape.position = location
    }
    
    
    
    
    
  
    
    
}
