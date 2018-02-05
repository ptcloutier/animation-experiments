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
    
    var addSpritesTimer = Timer()
    var topCenterPoint: CGPoint = CGPoint()
    var colors = [UIColor]()
    var count: Int = 0
    let timeInterval: TimeInterval = 0.1
    let maxCount: Int = 300
    var shapeSize: CGFloat = 8.0
    var container: SKView?
    var hourglass = SKShapeNode()
    var timer: Timer = Timer()
    var door = SKShapeNode()
    var top = SKShapeNode()
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override init(size: CGSize) {
        super.init(size: size)


        let hourglassPoints = [CGPoint(x: 100.0, y: frame.maxY-100.0),
                  CGPoint(x: 70.0, y: frame.maxY-170.0),
                  CGPoint(x: frame.midX-15.0, y: frame.midY),
                  CGPoint(x: 70.0, y: frame.minY+200.0),
                  CGPoint(x: 100.0, y: frame.minY+100.0),
                  CGPoint(x: frame.maxX-100.0, y: frame.minY+100.0),
                  CGPoint(x: frame.maxX-70.0, y: frame.minY+200.0),
                  CGPoint(x: frame.midX+15.0, y: frame.midY),
                  CGPoint(x: frame.maxX-100.0, y: frame.maxY-200.0),
                  CGPoint(x: frame.maxX-100.0, y: frame.maxY-100.0)
        ]
        
        let doorPoints = [CGPoint(x: frame.midX-100.0, y: frame.midY),
                          CGPoint(x: frame.midX+100.0, y: frame.midY),
                          ]
        door = connectShapePoints(points: doorPoints)
        hourglass = connectShapePoints(points: hourglassPoints)
        addChild(hourglass)
        addChild(door)
     
        addSpritesTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(PCAnimationScene.addSprites), userInfo: nil, repeats:true)
     }
    
    
    
    func connectShapePoints(points: [CGPoint]) -> SKShapeNode{
        
        var splinePoints = points
        let shape = SKShapeNode(splinePoints: &splinePoints,
                             count: splinePoints.count)
        shape.strokeColor = UIColor.white
        shape.lineWidth = 0.3
        shape.physicsBody = SKPhysicsBody(edgeChainFrom: shape.path!)
        shape.physicsBody?.isDynamic = false
        return shape
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
        let topCenterStartingPoint = CGPoint(x: (frame.midX+CGFloat(arc4random_uniform(2))), y: frame.maxY-1.0)
        return topCenterStartingPoint
    }
    

    
    
    func randomColor() -> UIColor {
        
       let color =  UIColor.init(red: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, green: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, blue: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, alpha: 1.0)
        return color
    }
    
    
    
    func closeTopHourglassLoop(){
        
        let topPoints = [CGPoint(x: frame.maxX-100.0, y: frame.maxY-100.0),
                         CGPoint(x: frame.midX, y: frame.maxY-70.0),
                         CGPoint(x: 100.0, y: frame.maxY-100.0)
        ]
        top = connectShapePoints(points: topPoints)
        addChild(top)
    }
    
    
    
    func openDoor(){
   
       door.removeFromParent()
    }
    
    
    
    @objc func addSprites(){
  
        while count <= maxCount {
            createSprite()
            count += 1
            print("\(count)")
            return
        }
        openDoor()
        closeTopHourglassLoop()
        addSpritesTimer.invalidate()
    }
    
    
    func createSprite(){
        let shapeNode = SKShapeNode.init(circleOfRadius: shapeSize)
//        shapeNode.blendMode = .add
        shapeNode.fillColor = randomColor()
        shapeNode.strokeColor = shapeNode.fillColor
        shapeNode.glowWidth = 0.9
        let texture = container?.texture(from: shapeNode) //(imageNamed: "pixel")
        let sprite = PCSpriteNode.init(texture: texture)
//        let sprite = PCSpriteNode(color: randomColor(), size: CGSize(width: shapeSize, height: shapeSize))
        sprite.blendMode = .add
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.frame.size.width/3.0)
        sprite.physicsBody?.affectedByGravity = true
        sprite.physicsBody?.linearDamping = 5.0
        sprite.physicsBody?.angularDamping = 10.0
        sprite.physicsBody?.usesPreciseCollisionDetection = false
        sprite.physicsBody?.mass = 0.5
        topCenterPoint = topCenterStartingPoint()
        sprite.position = topCenterPoint
        self.addChild(sprite)
     }
}
