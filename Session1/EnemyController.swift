//
//  EnemyController.swift
//  Session1
//
//  Created by Nguyen Bach on 11/12/16.
//  Copyright © 2016 Nguyen Bach. All rights reserved.
//
import GameplayKit
import SpriteKit

class EnemyController: Controller {
    let SPEED : CGFloat = 250
    let SHOOT_INTERVAL : Double = 2
    var enemy : SKSpriteNode!

    
    
    init() {
        ENEMY_TEXTURE = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: ENEMY_TEXTURE) as! [SKTexture]
        super.init(view : SKSpriteNode(texture: ENEMY_TEXTURE[0]))
        enemy = self.view
        enemy.physicsBody = SKPhysicsBody(texture: view.texture!, size: enemy.size)
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

//        let moveToBottomAction = SKAction.moveToBot(position: self.position, speed: SPEED)
//        self.view.run(SKAction.sequence([
//            moveToBottomAction, SKAction.removeFromParent()]))
//
//        let moveToRightAction = SKAction.moveToRight(position: self.position, rect: parent.frame, speed: SPEED)
//        self.view.run(SKAction.sequence([moveToRightAction, SKAction.removeFromParent()]))
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
