//
//  PCAnimationScene.swift
//  AnimationIsand
//
//  Created by Perrin Cloutier on 11/28/17.
//  Copyright © 2017 Perrin Cloutier. All rights reserved.
//

import Foundation
import SpriteKit


class PCAnimationScene: SKScene {
    
    var animationBackground: SKSpriteNode!
    var colors = [UIColor]()
    var count: Int = 1
    var nodes: [SKShapeNode] = []
    let shapeNodeWidth: CGFloat = 5.0
    let timeInterval: TimeInterval = 0.1
    let maxCount = 100000
    var pool: [SKShapeNode] = []
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
    var ground = SKShapeNode()
    var timer: Timer = Timer()
    var sprites: [PCSpriteNode] = []

    lazy var circle: PCSpriteNode =
        {
            let target = SKShapeNode(circleOfRadius: 1000)
            target.blendMode = .add
            target.alpha = 1.0
            target.glowWidth = 0.3
            target.fillColor = randomColor()
            
            let texture = SKView().texture(from:target)
            let spr = PCSpriteNode(texture:texture)
            spr.physicsBody = SKPhysicsBody(circleOfRadius: 1000)
            spr.physicsBody?.affectedByGravity = true
            spr.physicsBody?.linearDamping = 5.0
            spr.physicsBody?.angularDamping = 5.0
            spr.physicsBody?.usesPreciseCollisionDetection = false
            return spr
    }()
    
 
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override init(size: CGSize) {
        super.init(size: size)
        
        // set shape size
        shapeSize = CGSize.init(width: CGFloat(shapeNodeWidth)/2.0, height: CGFloat(shapeNodeWidth))
       
//        // set shape origin point
//        atLocation = topCenterStartingPoint()
//
//        // import color palette for shapes
//        setupColors()
        
//        animationBackground = SKSpriteNode(color: UIColor.clear, size: size)
//        anchorPoint = CGPoint(x: 0, y: 1.0)
//        animationBackground.anchorPoint = anchorPoint
//        animationBackground.position = CGPoint(x: 0, y: 0)
//        self.addChild(animationBackground)
//
//
//
//        // create bottom edge
//        let bounds = UIScreen.main.bounds
//
//        groundPointA = CGPoint(x: 0, y:(-1)*bounds.maxY)
//        groundPointB = CGPoint(x: bounds.maxX/2.0, y: (-1)*bounds.maxY )
//        groundPointC = CGPoint(x: bounds.maxX, y: (-1)*bounds.maxY)
//
//        groundPoints = [groundPointA, groundPointB, groundPointC]
//
        
//        setupGround(points: groundPoints)

        self.scaleMode = .aspectFit
        self.physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)
        
//        // start drop shapes
//        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(PCAnimationScene.addShape), userInfo: nil, repeats: true)
//        
//        // set raiseApexY
//        raiseApexY = 100.0
//        apexY = groundPointB.y
        
    }
    
    
    
   
    func addCircle(id: Int) {
        
        let color = randomColor()
        let spr = createCircle(of: 3.0, color: color)
        spr.id = id
        spr.name = "sprite"
        let x = CGFloat(arc4random_uniform(UInt32(20)))+(atLocation.x)
        let y = (-1)*atLocation.y // (-1)*(CGFloat(UIScreen.main.bounds.height/CGFloat(2.0)))
        let location = CGPoint(x: x, y: y)
        spr.position = location
        animationBackground.addChild(spr)
    }
    
    
    
    
    func createCircle(of radius: CGFloat, color: UIColor) -> PCSpriteNode {
        
        let spr = circle.copy() as! PCSpriteNode
        let scale = radius/1200
        spr.xScale = scale
        spr.yScale = scale
        spr.color = color
        spr.colorBlendFactor = 0.3
        spr.blendMode = .add
        spr.zPosition = CGFloat(arc4random_uniform(UInt32(5.0)))
        
        return spr
        
    }
    
    
    
    

//    func setupGround(points: [CGPoint]){
//
//        splinePoints = points
//        ground.removeFromParent()
//        ground = SKShapeNode(splinePoints: &splinePoints,
//                                 count: splinePoints.count)
//        ground.name = "ground"
//        ground.strokeColor = UIColor.clear
//
//        ground.lineWidth = 5
//        ground.physicsBody = SKPhysicsBody(edgeChainFrom: ground.path!)
//        ground.physicsBody?.isDynamic = false
//        animationBackground.addChild(ground)
//
//    }
    
    
    func setupColors(){
        colors.append(UIColor.red)
        colors.append(UIColor.green)
        colors.append(UIColor.blue)
        colors.append(UIColor.yellow)
        colors.append(UIColor.purple)
        colors.append(UIColor.orange)
        let vintColors = PCColors.getVintage()
        let psyColors = PCColors.getPsychedelicIceCreamShopColors()
        for x in vintColors {
            colors.append(x)
        }
        for x in psyColors {
            colors.append(x)
        }
    }
    
    
    
    func randomStartingPoint() -> CGPoint{
        
        let randomStartingPoint = CGPoint(x: CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.size.width))), y: (-1)*(CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.size.height)))))
        return randomStartingPoint
    }
    
    
    
    func topCenterStartingPoint() -> CGPoint {
        let topCenterStartingPoint = CGPoint(x: (UIScreen.main.bounds.midX+CGFloat(arc4random_uniform(2))), y: 1)
        return topCenterStartingPoint
    }
    

    
    
    @objc func addShape(){  // until timer is up, then present alert
        
        
        if count % 50 == 0 {
            let children: [PCSpriteNode] = (animationBackground.children as? [PCSpriteNode])!
            for ch in children {
                if ch.id <= 40 && ch.id > 0 {
                    ch.setBitmasksToZero()
                    
                    ch.id = -1
                    count = 1
                }
            }
            self.scaleMode = .aspectFit
            self.physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)
        }
         else {
            addCircle(id: count)
            count += 1
        }
    }
    
    
    
    func randomColor() -> UIColor{
       let color =  UIColor.init(red: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, green: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, blue: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, alpha: 1.0)
        return color
    }
    
    
    
    
//    func addShapeNodeToScene(){
//
//        let shape = SKShapeNode(circleOfRadius: shapeSize.width)
//        shape.fillColor = randomColor()
//        shape.blendMode = .add
//        shape.strokeColor = shape.fillColor
//        shape.alpha = 1.0
//        shape.glowWidth = 0.3
//
//        // create sprite w/ skshapenode attributes
//        let texture = SKView().texture(from: shape)
//        let sprite = PCSpriteNode.init(texture: texture)
//        sprite.name = "sprite"
//        sprite.startTimerToClearBitmasks()
//
//        // apply physics
//        sprite.physicsBody = SKPhysicsBody(circleOfRadius: shapeSize.width)
//        sprite.physicsBody?.affectedByGravity = false
//        sprite.physicsBody?.linearDamping = 5.0
//        sprite.physicsBody?.angularDamping = 5.0
//        sprite.physicsBody?.usesPreciseCollisionDetection = false
//        animationBackground.addChild(sprite)
//
//        // start location
//        let x = CGFloat(arc4random_uniform(UInt32(20)))+(atLocation.x)
//        let y = (-1)*(CGFloat(UIScreen.main.bounds.height/CGFloat(2.0))) // (-1)*atLocation.y
//        let location = CGPoint(x: x, y: y)
//        sprite.position = location
//    }
//
    
    func startTimer(){
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(PCAnimationScene.addSprite), userInfo: nil, repeats: true)
    }
    
    @objc func addSprite(){
        
        let texture = SKTexture.init(imageNamed: "pixel")
        let sprite = PCSpriteNode.init(texture: texture)
        sprite.colorBlendFactor = 0.3
        sprite.color = randomColor()
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width)
        sprite.physicsBody?.affectedByGravity = true
        sprite.physicsBody?.linearDamping = 10.0
        sprite.physicsBody?.angularDamping = 10.0
        sprite.physicsBody?.usesPreciseCollisionDetection = false
        sprite.position = topCenterStartingPoint()
        self.addChild(sprite)
        sprites.append(sprite)
    }
}
