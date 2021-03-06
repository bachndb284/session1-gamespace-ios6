//
//  Controller.swift
//  Session1
//
//  Created by Nguyen Bach on 11/12/16.
//  Copyright © 2016 Nguyen Bach. All rights reserved.
//

import SpriteKit

class Controller {
    let view : SKSpriteNode
    var parent :SKNode!
    
    init(view : SKSpriteNode) {
        self.view = view
    }
    var width : CGFloat{
        get {
            return self.view.size.width
            
        }
    }
    
    var height : CGFloat{
        get {
            return self.view.size.height
            
        }
    }
    
    var position : CGPoint{
        get {
            return self.view.position
            
        }
    }
    func config(position : CGPoint , parent : SKNode)  {
        self.view.position = position
        self.parent = parent
       parent.addChild(self.view) // GameScene.addChild(self.view)
        
    }
}
