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
    var timeInterval: TimeInterval = 0.01
    var timer = Timer()
    var animator: UIDynamicAnimator? = nil
    let gravity = UIGravityBehavior()
    let collider = UICollisionBehavior()
    let itemBehavior = UIDynamicItemBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Custom.Gray.dark
        //        size = self.view.frame.size
        //        scene = AnimationScene(size: size)
        //
        //        let skView = self.view as! SKView
        //        skView.ignoresSiblingOrder = true
        //        scene.container = skView
        //        skView.presentScene(scene)
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(ViewController.addUIViewShapes), userInfo: nil, repeats: true)
        createAnimatorStuff()
    }
    
    
    
    @objc func addUIViewShapes() -> UIView {
        
        let circle = UIView.init(frame: CGRect(x: 0, y: 0, width: 10.0, height: 10.0))
        circle.layer.cornerRadius = 5.0
        view.addSubview(circle)
        circle.frame.origin = randomStartingPoint()
        circle.backgroundColor = Colors.randomColor()
        gravity.addItem(circle)
        collider.addItem(circle)
        itemBehavior.addItem(circle)
        return circle
    }
    
    func randomStartingPoint() -> CGPoint{
        
        let randomStartingPoint = CGPoint(x: CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.size.width))), y: (CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.size.height)))))
        return randomStartingPoint
    }
    
    
    
    
    func createAnimatorStuff() {
        animator = UIDynamicAnimator(referenceView:self.view)
        
        gravity.gravityDirection = CGVector(dx: 0.0, dy: 0.8)
        animator?.addBehavior(gravity)
        
        // We're bouncin' off the walls
        collider.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collider)
        
        itemBehavior.friction = 0.1
        itemBehavior.elasticity = 0.9
        animator?.addBehavior(itemBehavior)
    }
    
    
    
}
