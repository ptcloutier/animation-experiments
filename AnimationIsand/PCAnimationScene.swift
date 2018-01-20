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
    
    var top: CGPoint = CGPoint()
    var animationBackground: SKSpriteNode!
    var colors = [UIColor]()
    var count: Int = 0
    var nodes: [SKShapeNode] = []
    let shapeNodeWidth: CGFloat = 1.0
    let timeInterval: TimeInterval = 0.01
    let maxCount = 100000
    var pool: [SKShapeNode] = []
    var shapeSize: CGSize = CGSize()
    var atLocation: CGPoint = CGPoint()
    var splinePoints: [CGPoint] = []
    var points: [CGPoint] = []
    
    var container: SKView?

    var apexX: CGFloat = CGFloat()
    var apexY: CGFloat = CGFloat()
    var poolCount: Int = 150
    var raiseApexY: CGFloat = CGFloat()
    var raiseYDrop: CGFloat = CGFloat()
    var hourglass = SKShapeNode()
    var timer: Timer = Timer()
    var sprites: [PCSpriteNode] = []

    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override init(size: CGSize) {
        super.init(size: size)

//        self.scaleMode = .aspectFit
//        self.physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)

        
        points = [CGPoint(x: 100.0, y: frame.maxY-100.0),
                  CGPoint(x: 70.0, y: frame.maxY-170.0),
                  CGPoint(x: frame.midX-100.0, y: frame.midY+100.0),
                  CGPoint(x: frame.midX-100.0, y: frame.midY),
                  CGPoint(x: frame.midX-100.0, y: frame.midY),
                  CGPoint(x: 70.0, y: frame.minY+170.0),
                  CGPoint(x: 100.0, y: frame.minY+100.0),
                  CGPoint(x: frame.maxX-100.0, y: frame.minY+100.0),
                  CGPoint(x: frame.maxX-70.0, y: frame.minY+170.0),
                  CGPoint(x: frame.midX+100.0, y: frame.midY),
                  CGPoint(x: frame.midX+100.0, y: frame.midY+100.0),
                  CGPoint(x: frame.maxX-100.0, y: frame.maxY-170.0)
//                  CGPoint(x: frame.maxX-70.0, y: frame.maxY-100.0),
        ]
        
        
        setupPoints(points: points)
    }
    
    func setupPoints(points: [CGPoint]){
        
        splinePoints = points
        hourglass.removeFromParent()
        hourglass = SKShapeNode(splinePoints: &splinePoints,
                             count: splinePoints.count)
        hourglass.strokeColor = UIColor.clear
        
        hourglass.lineWidth = 1.0
        hourglass.physicsBody = SKPhysicsBody(edgeChainFrom: hourglass.path!)
        hourglass.physicsBody?.isDynamic = false
        self.addChild(hourglass)
        
    }
     
    
    
    
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
        let topCenterStartingPoint = CGPoint(x: (UIScreen.main.bounds.midX+CGFloat(arc4random_uniform(2))), y: UIScreen.main.bounds.size.height)
        return topCenterStartingPoint
    }
    

    
    
   
    
    
    
    func randomColor() -> UIColor{
       let color =  UIColor.init(red: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, green: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, blue: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, alpha: 1.0)
        return color
    }
    
 
    func startAddSpriteTimer(){
        
        Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(PCAnimationScene.addSprite), userInfo: nil, repeats: true)
    }
    
    
    
    @objc func addSprite(){
  
        createSprite()
        
    }
    
    
    func createSprite(){
        
        let shapeNode = SKShapeNode.init(circleOfRadius: 10.0)
        shapeNode.blendMode = .add
        shapeNode.fillColor = randomColor()
        shapeNode.strokeColor = shapeNode.fillColor
        shapeNode.glowWidth = 0.9
        let texture = container?.texture(from: shapeNode) //(imageNamed: "pixel")
        let sprite = PCSpriteNode.init(texture: texture)
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: shapeNode.frame.size.width/2.0)
        sprite.physicsBody?.affectedByGravity = true
        sprite.physicsBody?.linearDamping = 05.0
        sprite.physicsBody?.angularDamping = 10.0
        sprite.physicsBody?.usesPreciseCollisionDetection = false
        top = topCenterStartingPoint()
        sprite.position = top
        self.addChild(sprite)
     }
}
