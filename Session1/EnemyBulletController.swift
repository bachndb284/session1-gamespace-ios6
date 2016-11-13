//
//  EnemyBulletController.swift
//  Session1
//
//  Created by Nguyen Bach on 11/12/16.
//  Copyright © 2016 Nguyen Bach. All rights reserved.
//

import SpriteKit

class EnemyBulletController: Controller {
    
    let SPEED : CGFloat = 150
    var enemyBullet : SKSpriteNode!
    
    init() {
        super.init(view: SKSpriteNode(texture: ENEMY_BULLET_TEXTURE))
        view.name = "enemy_bullet"
        enemyBullet = self.view
        
        enemyBullet.physicsBody = SKPhysicsBody(texture: ENEMY_BULLET_TEXTURE, size: enemyBullet.size)
        enemyBullet.physicsBody?.categoryBitMask = ENEMY_BULLET_MASK
        enemyBullet.physicsBody?.contactTestBitMask = PLAYER_MASK
        enemyBullet.physicsBody?.collisionBitMask = 0
        
        enemyBullet.physicsBody?.categoryBitMask = ENEMY_BULLET_MASK
        enemyBullet.physicsBody?.contactTestBitMask = PLAYER_BULLET_MASK
        enemyBullet.physicsBody?.collisionBitMask = 0
    }
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        let moveToBotAction = SKAction.moveToBot(position: position,  speed : SPEED)
        view.run(SKAction.sequence([moveToBotAction, SKAction.removeFromParent()]))
        
        
    }
}
