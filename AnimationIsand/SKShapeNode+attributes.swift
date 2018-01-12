//
//  SKShapeNode+location.swift
//  AnimationIsand
//
//  Created by Perrin Cloutier on 1/11/18.
//  Copyright © 2018 Perrin Cloutier. All rights reserved.
//

import Foundation
import SpriteKit

extension SKShapeNode {
    
    func getLocation() -> CGPoint {
     return self.frame.origin
    }
}
