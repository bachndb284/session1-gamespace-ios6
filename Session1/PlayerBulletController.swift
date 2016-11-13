//
//  PlayerController.swift
//  Session1
//
//  Created by Nguyen Bach on 11/10/16.
//  Copyright © 2016 Nguyen Bach. All rights reserved.
//

import SpriteKit

class PlayerBulletController : Controller{
    //Constructor - ham tao
//    let view: SKSpriteNode = SKSpriteNode(imageNamed: "bullet-double")
    let SPEED : CGFloat = 300
    
    init() {
        //goi gia tri tu ham me
        super.init(view : SKSpriteNode(texture: PLAYER_BULLET_TEXTURE))
        view.name = "player_bullet"
        //lay hinh quanh vat
                self.view.physicsBody = SKPhysicsBody(texture: PLAYER_BULLET_TEXTURE, size: self.view.size)
        
                // 0010
                // 1 << 1 => 0010
                // 1 << 2 => 0100
                view.physicsBody?.categoryBitMask = PLAYER_BULLET_MASK
                view.physicsBody?.contactTestBitMask = ENEMY_MASK
                view.physicsBody?.collisionBitMask = 0
        
                view.physicsBody?.categoryBitMask = PLAYER_BULLET_MASK
                view.physicsBody?.contactTestBitMask = ENEMY_BULLET_MASK
                view.physicsBody?.collisionBitMask  = 0

    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        let moveToTopAction = SKAction.moveToTop(position: position, rect : parent.frame , speed : SPEED)
              view.run(SKAction.sequence([moveToTopAction, SKAction.removeFromParent()]))

        
    }
    
//    init() { // init -> size -> position -> config // break the circle in last session
//        view.name = "player_bullet"
//        view.physicsBody = SKPhysicsBody(rectangleOf: view.size)
//        // 0010
//        // 1 << 1 => 0010
//        // 1 << 2 => 0100
//        view.physicsBody?.categoryBitMask = PLAYER_BULLET_MASK
//        view.physicsBody?.contactTestBitMask = ENEMY_MASK
//        view.physicsBody?.collisionBitMask = 0
//    }
    
    //getter
//    
//    var width : CGFloat{
//        get {
//            return self.view.size.width
//        
//        }
//    }
//    
//    var height : CGFloat{
//        get {
//            return self.view.size.height
//            
//        }
//    }
//    
//    var position : CGPoint{
//        get {
//            return self.view.position
//        
//        }
//    }
//    func config(position : CGPoint , parent : SKNode)  {
//        self.view.position = position
//        let moveToTopAction = SKAction.moveToTop(position: position, rect : parent.frame , speed : SPEED)
//        view.run(SKAction.sequence([moveToTopAction, SKAction.removeFromParent()]))
//        parent.addChild(self.view) // GameScene.addChild(self.view)
//        
//    }
    
//    init(position : CGPoint , parent: SKNode) {
//        //Configure properties
//        view.position = position
//        view.name = "player_bullet"
//        //Physics Body
//        view.physicsBody = SKPhysicsBody(rectangleOf: view.size)
//        // 0010
//        // 1 << 1 => 0010
//        // 1 << 2 => 0100
//        view.physicsBody?.categoryBitMask = PLAYER_BULLET_MASK
//        view.physicsBody?.contactTestBitMask = ENEMY_MASK
//        view.physicsBody?.collisionBitMask = 0
//
//        //Actions
//        //Position.y -> top -> distance / SPEED
//        let moveToTopAction = SKAction.moveToTop(position: position, rect : parent.frame , speed : SPEED)
//        view.run(SKAction.sequence([moveToTopAction, SKAction.removeFromParent()]))
//    }
//    
////    init(playerNode: SKSpriteNode, parent : SKNode) {
////        let position = playerNode.position.add(x: 0, y: -(playerNode.size.height + self.view.size.height)/2)
////        
////        self.init( position, parent)
////    }

   
}
