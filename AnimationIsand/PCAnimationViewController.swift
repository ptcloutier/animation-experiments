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
        scene.startAddSpriteTimer()
    }
    
    
    
    func configureScene(){
        
        size = self.view.frame.size
        let skView = self.view as! SKView
        scene = PCAnimationScene(size: size)
        scene.container = skView
        skView.presentScene(scene)
    }
}
