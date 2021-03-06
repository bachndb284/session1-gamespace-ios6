//
//  File.swift
//  Session1
//
//  Created by Nguyen Bach on 11/10/16.
//  Copyright © 2016 Nguyen Bach. All rights reserved.
//

import Foundation
import SpriteKit

extension CGPoint{
    func add(other: CGPoint) -> CGPoint {
        return CGPoint(x: self.x + other.x, y: self.y + other.y)
    }
    
    func add(x: CGFloat , y : CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y + y)
    }
    
    func add(vector: CGVector) -> CGPoint {
        return CGPoint(x: self.x + vector.dx, y: self.y + vector.dy)
    }
    
    func distance(other: CGPoint) -> CGFloat {
        let dx = self.x - other.x
        let dy = self.y - other.y
        return sqrt(dx*dx + dy*dy)
    }
}

extension SKAction {
  static  func moveToTop(position : CGPoint , rect : CGRect , speed : CGFloat) ->SKAction {
        let distance = rect.height - position.y
        let time  = distance / speed
        return SKAction.moveTo(y: rect.height, duration: TimeInterval(time) )
        
    }
    static func moveToBot (position : CGPoint, speed : CGFloat) -> SKAction{
        let distance = position.y
        let time = distance / speed
        return SKAction.moveTo(y : 0, duration: TimeInterval(time))
        
    
    }
    static func moveToRight (position : CGPoint, rect : CGRect, speed : CGFloat) -> SKAction{
        let dx = rect.width
        let dy = position.y
        let distance = sqrt(dx*dx+dy*dy)
        let time = distance/speed
        return SKAction.move(to: CGPoint(x:rect.width, y:0), duration: TimeInterval(time))
    }
    
    static func moveToLeft (position : CGPoint,  speed : CGFloat) -> SKAction{
        let dx :CGFloat = 0
        let dy = position.y
        let distance = sqrt(dx*dx+dy*dy)
        let time = distance/speed
        return SKAction.move(to: CGPoint(x:0, y:0), duration: TimeInterval(time))
    }
}
