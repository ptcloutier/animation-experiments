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
    let shapeNodeWidth: CGFloat = 30.0
    let timeInterval: TimeInterval = 0.001
    let maxCount = 5000
    var pool: [SKShapeNode] = []
    var container: SKView?
    var shapeSize: CGSize = CGSize()
    var atLocation: CGPoint = CGPoint()
    var splinePoints: [CGPoint] = []
    var ground: SKShapeNode = SKShapeNode()
    var groundPoints: [CGPoint] = []
    var nodeYLocations: [CGFloat] = []
    var groundPointA: CGPoint = CGPoint()
    var groundPointB: CGPoint = CGPoint()
    var groundPointC: CGPoint = CGPoint()

    var apexX: CGFloat = CGFloat()
    var apexY: CGFloat = CGFloat()
    var poolCount: Int = 100
    var raiseApexY: CGFloat = CGFloat()
    var raiseYDrop: CGFloat = CGFloat()
    
    
    
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
        let bounds = UIScreen.main.bounds
        
        groundPointA = CGPoint(x: 0, y:(-1)*bounds.maxY)
        groundPointB = CGPoint(x: bounds.maxX/2.0, y: (-1)*bounds.maxY )
        groundPointC = CGPoint(x: bounds.maxX, y: (-1)*bounds.maxY)

        groundPoints = [ groundPointA, groundPointB, groundPointC]
        
        
        setupGround(points: groundPoints)

        self.scaleMode = .aspectFit
        self.physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)
        
        // start drop shapes
        Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(AnimationScene.addShape), userInfo: nil, repeats: true)
        
        // set raiseApexY
        raiseApexY = 40.0
        apexY = groundPointB.y
        
    }
    
    
    func setupGround(points: [CGPoint]){
        
        splinePoints = points
        ground.removeFromParent()
        ground = SKShapeNode(splinePoints: &splinePoints,
                                 count: splinePoints.count)
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
       
        while pool.count <= poolCount {
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
        shape.physicsBody?.linearDamping = 0
        shape.physicsBody?.angularDamping = 5.0
        shape.physicsBody?.usesPreciseCollisionDetection = false
        animationBackground.addChild(shape)
        let x = CGFloat(arc4random_uniform(UInt32(20)))+(atLocation.x)
        let y = adjustYLocations()
        let location = CGPoint(x: x, y: y)
        shape.position = location
    }
    
    
    func adjustYLocations() -> CGFloat {
        
        if raiseYDrop > 1 {
            raiseYDrop = raiseYDrop - 100.0
        } else {
            raiseYDrop = atLocation.y
        }
        return (-1)*raiseYDrop
    }
   
    
    
    func cacheShapes(){
        
        let apexPoint = CGPoint(x: UIScreen.main.bounds.maxX/2.0, y: groundPointB.y + raiseApexY)

        let cacheTexture: SKTexture = SKView().texture(from: self, crop: UIScreen.main.bounds)!
        animationBackground.texture = cacheTexture
        
        for child in animationBackground.children {
            let n = child as! SKShapeNode
            n.removeFromParent()
            self.pool.append(n)
        }
        raiseYDrop = (-1)*apexY
        changeGroundPoint(apexPoint: apexPoint)
    }
    
    
    
    
    
    func changeGroundPoint(apexPoint: CGPoint) {
        groundPointB = apexPoint
        groundPoints.removeAll()
        groundPoints.append(groundPointA)
        groundPoints.append(groundPointB)
        groundPoints.append(groundPointC)
        setupGround(points: groundPoints)
    }
    
    
    
}
