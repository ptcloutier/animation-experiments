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
    var colors = [UIColor]()
    var count: Int = 0
    let timeInterval: TimeInterval = 0.5
    var shapeSize: CGFloat = 15.0
    var container: SKView?
    var shelves = SKShapeNode()
    var timer: Timer = Timer()
    var door = SKShapeNode()
    var top = SKShapeNode()
    var flip: Bool = false
    let spriteName = "sprite"
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override init(size: CGSize) {
        super.init(size: size)
        
        
        let pointsA = [
            CGPoint(x: frame.minX+80, y: frame.maxY-80.0),
            CGPoint(x: frame.midX-20.0, y: frame.maxY-160.0)
        ]
        let pointsB = [
            CGPoint(x: frame.minX+120.0, y: frame.midY+140.0),
            CGPoint(x: frame.midX+20.0, y: frame.midY+90.0)
        ]
        
        let pointsC = [
            CGPoint(x: frame.midX+80.0, y: frame.maxY-250.0),
            CGPoint(x: frame.midX-20.0, y: frame.midY)
        ]
        
        let pointsD = [
            CGPoint(x: frame.minX+100.0, y: frame.midY-40.0),
            CGPoint(x: frame.midX+30.0, y: frame.midY-100.0)
        ]
        
        let pointsE = [
            CGPoint(x: frame.maxX-100.0, y: frame.midY-150.0),
            CGPoint(x: frame.midX-50.0, y: frame.minY+130.0)
        ]

        let pointsF = [
            CGPoint(x: frame.midX-100.0, y: frame.midY-250.0),
            CGPoint(x: frame.midX+80.0, y: frame.minY+30.0)
        ]
        
       
        
        let shelfCollection: [[CGPoint]] = [
            pointsA, pointsB, pointsC, pointsD, pointsE, pointsF
        ]
        
        for x in shelfCollection {
            let shelves = connectShapePoints(points: x)
            addChild(shelves)
        }
        
        addSpritesTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(PCAnimationScene.addSprites), userInfo: nil, repeats: true)
     }
    
    
    
    func connectShapePoints(points: [CGPoint]) -> SKShapeNode{
        
        var splinePoints = points
        let shape = SKShapeNode(splinePoints: &splinePoints,
                             count: splinePoints.count)
        shape.strokeColor = randomColor()
        shape.lineWidth = 10.0
        shape.physicsBody = SKPhysicsBody(edgeChainFrom: shape.path!)
        shape.physicsBody?.isDynamic = false
        return shape
    }
    
    
    
    override func update(_ currentTime: CFTimeInterval) {
        for child in children {
            
            if child.name == spriteName {
                let node = child as! PCSpriteNode
                let location = node.getLocation()
                let y = location.y
                if node.shouldFloat == true && y > frame.maxY {
                    removeFromParent()
                    break
                }
                if node.position.y < 0 {
                    node.shouldFloat = true
                }
                let randomCo = randomColor()
                let randomInterval = TimeInterval(arc4random_uniform((UInt32(1.5))))
                
                if node.shouldFloat == true {
                    let action = SKAction.colorize(with: randomCo, colorBlendFactor: CGFloat(arc4random_uniform((UInt32(1.0)))), duration: randomInterval)
                    node.run(action)
                    floatShape(node: node)

                }
                
                
            }
        }
    }
    
    
    
    
    
    
    func floatShape(node: PCSpriteNode){
        
            node.physicsBody?.affectedByGravity = false
            let xOffset: CGFloat = CGFloat(arc4random_uniform(30)) - 10.0
            let yOffset: CGFloat = 20.0
            let newLocation = CGPoint(x: node.position.x + xOffset/2, y: node.position.y + yOffset)
            let moveAction = SKAction.move(to: newLocation, duration: 0.2)
            node.run(moveAction)
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
        
        let point = CGPoint(x: CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.size.width))), y: (-1)*(CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.size.height)))))
        return point
    }
    
    func randomTopStartingPoint() -> CGPoint {
        let point =  CGPoint(x: CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.size.width))), y: frame.height)
        return point
    }
    
    func alternatingTopStartingPoints() -> CGPoint {
        
        var point: CGPoint
       
        switch flip {
        case true:
            point = CGPoint(x: frame.minX+60.0, y: frame.maxY)
            flip = false
        case false:
            point = CGPoint(x: frame.maxX-60.0, y: frame.maxY)
            flip = true
        }
        return point
    }
    
    func topCenterStartingPoint() -> CGPoint {
        let point = CGPoint(x: (frame.midX+CGFloat(arc4random_uniform(2))), y: frame.maxY-1.0)
        return point
    }
    

    
    
    func randomColor() -> UIColor {
        
       let color =  UIColor.init(red: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, green: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, blue: CGFloat(arc4random_uniform(UInt32(255.0)))/255.0, alpha: 1.0)
        return color
    }
    
    
    
  
    
    
    @objc func addSprites(){
            createSprite()
            count += 1
            print("\(count)")
    }
    
    
    
    
    func createSprite(){
        let shapeNode = SKShapeNode.init(ellipseOf: CGSize(width: CGFloat(arc4random_uniform(UInt32(self.shapeSize*3.0))), height:CGFloat(arc4random_uniform(UInt32(self.shapeSize*3.0)))))
        shapeNode.fillColor = randomColor()
        shapeNode.strokeColor = shapeNode.fillColor
        let texture = container?.texture(from: shapeNode) //(imageNamed: "pixel")
        let sprite = PCSpriteNode.init(texture: texture)
        sprite.blendMode = .add
        sprite.name = spriteName
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: shapeNode.frame.size.width/3.0)
        sprite.physicsBody?.affectedByGravity = true
        sprite.physicsBody?.linearDamping = 10.0
        sprite.physicsBody?.angularDamping = 3.0
        sprite.physicsBody?.usesPreciseCollisionDetection = false
        sprite.position = CGPoint(x: frame.minX+100.0, y: frame.maxY)
        self.addChild(sprite)
     }
    
    
}
