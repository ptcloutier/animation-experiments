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
    let timeInterval: TimeInterval = 0
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

    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override init(size: CGSize) {
        super.init(size: size)

        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(PCAnimationScene.replaceSprite(notification:)), name: Notification.Name("replaceWithLargerShapeNotification"), object: nil )

        self.scaleMode = .aspectFit
        self.physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)
  
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
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PCAnimationScene.addSprite), userInfo: nil, repeats: true)
    }
    
    
    
    @objc func addSprite(){
  
        let top = topCenterStartingPoint()
        createSprite(id: 0, sizeFactor: 0.33, position: top)

    }
    
    
    func createSprite(id: Int, sizeFactor: CGFloat, position: CGPoint) {
        
        let texture = SKTexture.init(imageNamed: "pixel")
        let sprite = PCSpriteNode.init(texture: texture)
        sprite.startContactTimer()
        sprite.id = id
        sprite.colorBlendFactor = 0.3
        sprite.color = randomColor()
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width * sizeFactor)
        sprite.physicsBody?.affectedByGravity = true
        sprite.physicsBody?.linearDamping = 10.0
        sprite.physicsBody?.angularDamping = 10.0
        sprite.physicsBody?.usesPreciseCollisionDetection = false
        sprite.position = position
        self.addChild(sprite)
   
        
     }

    
    
    @objc func replaceSprite(notification: Notification){
        guard let location = notification.object as? CGPoint else {
            print("no location passed with notification")
            return
        }
        replaceSprite(atLocation: location)
    }
    
    func replaceSprite(atLocation: CGPoint){
        createBigSprite(id: 0, sizeFactor: 10.0, position: atLocation)
    }
    
    func createBigSprite(id: Int, sizeFactor: CGFloat, position: CGPoint) {
        
        let size = CGSize(width: 100.0, height: 100.0)
         let sprite = SKSpriteNode(color: UIColor.purple, size: size)
//        sprite.startContactTimer()
        sprite.colorBlendFactor = 0.3
//        sprite.color = randomColor()
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width * sizeFactor)
        sprite.physicsBody?.affectedByGravity = true
        sprite.physicsBody?.linearDamping = 10.0
        sprite.physicsBody?.angularDamping = 10.0
        sprite.physicsBody?.usesPreciseCollisionDetection = false
        sprite.position = position
        self.addChild(sprite)
        
        
    }
}
