//
//  ViewController.swift
//  AnimationIsand
//
//  Created by Perrin Cloutier on 11/28/17.
//  Copyright © 2017 Perrin Cloutier. All rights reserved.
//

import UIKit
import SpriteKit
class ViewController: UIViewController {
    
    var scene: AnimationScene!
    var size: CGSize!
    var timeInterval: TimeInterval = 0.5
    var timer = Timer()
    var animator: UIDynamicAnimator? = nil
    let gravity = UIGravityBehavior()
    let collider = UICollisionBehavior()
    let itemBehavior = UIDynamicItemBehavior()
    var circles: [UIView] = []
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skViewSetUp()
    }
    
    
    
    func skViewSetUp(){
        
        size = self.view.frame.size
        scene = AnimationScene(size: size)
        
        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        scene.container = skView
        skView.presentScene(scene)
        
    }
    
    
    func fireTimer(){
        
        
         timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(ViewController.addUIViewShapes), userInfo: nil, repeats: true)
    }
    
    
    
    @objc func addUIViewShapes() {
        
        if count < 10 {
            let circle = UIView.init(frame: CGRect(x: 0, y: 0, width: 10.0, height: 10.0))
            circle.layer.cornerRadius = 5.0
            view.addSubview(circle)
            circle.frame.origin = topCenterStartingPoint()
            circle.backgroundColor = Colors.randomColor()
            gravity.addItem(circle)
            collider.addItem(circle)
            itemBehavior.addItem(circle)
            count += 1
        } else {
            manageResources()
            count = 0
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
    
    
    
    
    func createAnimatorStuff() {
        
        animator = UIDynamicAnimator(referenceView:self.view)
        
        gravity.gravityDirection = CGVector(dx: 0.0, dy: 0.8)
        animator?.addBehavior(gravity)
        
        collider.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collider)
        
        itemBehavior.friction = 0.5
        itemBehavior.elasticity = 0.1
        animator?.addBehavior(itemBehavior)
    }
    
    
    func manageResources(){
      
    
//        for i in gravity.items {
//            gravity.removeItem(i)
//            itemBehavior.removeItem(i)
//            collider.removeItem(i)
//        }
        for i in (animator?.items(in: self.view.frame))!{
            if i.center.y > 600 {
                itemBehavior.removeItem(i)
                print("p - \(i.center.y)")
            }
        }
    }
    
    
}
