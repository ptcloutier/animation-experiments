//
//  PCAnimationViewController.swift
//  AnimationIsand
//
//  Created by Perrin Cloutier on 11/28/17.
//  Copyright © 2017 Perrin Cloutier. All rights reserved.
//

import UIKit
import SpriteKit


class PCAnimationViewController: UIViewController {
    
    var scene: PCAnimationScene!
    var size: CGSize!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScene()
    }
    
    
    
    func configureScene(){
        
        size = self.view.frame.size
        let skView = self.view as! SKView
        scene = PCAnimationScene(size: size)
        scene.container = skView
        setupShelfAttributes()
        setupShelves()
        skView.presentScene(scene)
        scene.createAddSpritesTimer()
    }
    
    
    func setupShelves(){
        
        //TODO: calculate values rather than hardcoding
    
        let frame = view.frame
        let unit = frame.height/16.0
        
        let pointsA = [
            CGPoint(x: frame.midX-unit, y: frame.maxY-(3.5*unit)),
            CGPoint(x: frame.midX+(2.0*unit), y: frame.maxY-unit)
        ]
        let pointsB = [
            CGPoint(x: frame.minX+(unit*2.0), y: frame.midY+(4.0*unit)),
            CGPoint(x: frame.midX+unit/2.0, y: frame.midY+(unit*2.0))
        ]
        
        let pointsC = [
            CGPoint(x: frame.midX+unit*2.0, y: frame.midY+unit),
            CGPoint(x: frame.midX-unit, y: frame.midY)
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
            CGPoint(x: frame.midX+30.0, y: frame.minY+40.0)
        ]
        
        
        
        scene.pointsCollection = [
            pointsA, pointsB, pointsC, pointsD, pointsE, pointsF
        ]
        
        scene.addShelvesToScene()
    }
    
    
    func setupShelfAttributes(){
        scene.lineWidths.append(10.0)
    }
}
