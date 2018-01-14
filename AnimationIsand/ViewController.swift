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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        size = self.view.frame.size
        scene = AnimationScene(size: size)
        
        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        scene.container = skView
        skView.presentScene(scene)
    }
}
