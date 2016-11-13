//
//  EnemyController.swift
//  Session1
//
//  Created by Nguyen Bach on 11/12/16.
//  Copyright © 2016 Nguyen Bach. All rights reserved.
//

import SpriteKit

class EnemyController: Controller {
    let SPEED : CGFloat = 250
    let SHOOT_INTERVAL : Double = 1
    var enemy : SKSpriteNode!

    
    
    init() {
        super.init(view : SKSpriteNode(texture: ENEMY_TEXTURE))
        enemy = self.view
        enemy.physicsBody = SKPhysicsBody(texture: ENEMY_TEXTURE, size: enemy.size)
        enemy.physicsBody?.categoryBitMask = ENEMY_MASK
        enemy.physicsBody?.contactTestBitMask = PLAYER_BULLET_MASK
        enemy.physicsBody?.collisionBitMask = 0
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent : parent )
        configMove()
        configShoot()
    }
    func configMove() {

        let moveToBottomAction = SKAction.moveToBot(position: self.position, speed: SPEED)
        self.view.run(SKAction.sequence([
            moveToBottomAction, SKAction.removeFromParent()]))
    }
    func configShoot () -> Void{
        let ShootAction = SKAction.run { 
            let enemyBulletController = EnemyBulletController()
            
            let startPosition = CGPoint(x: self.position.x, y: self.position.y - (self.height + enemyBulletController.height) / 2)
            enemyBulletController.config(position: startPosition, parent: self.parent)
            
        }
        let shootWithDelayAction = SKAction.sequence([
            ShootAction, SKAction.wait(forDuration: self.SHOOT_INTERVAL)])
        self.view.run(SKAction.repeatForever(shootWithDelayAction))
    }
}
