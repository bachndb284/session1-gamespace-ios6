//
//  GameScene.swift
//  Session1
//
//  Created by Nguyen Bach on 11/8/16.
//  Copyright © 2016 Nguyen Bach. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
  let player = SKSpriteNode(imageNamed: "plane2")
  let enemy = SKSpriteNode(imageNamed: "Bigenemy" )
  let PLAYER_SPEED      = 150.0
  let BULLET_SPEED      = 300.0
  let ENEMY_SPEED       = 100.0
  let BULLETENEMY_SPEED = 200.0
  var gameTimer:Timer!
  
    
    override func didMove(to view: SKView) {
        
      
        addbackGround()
        addPlayer()
        addEnemyandBullet()
        addEnemy()
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true)
                }
    func addbackGround(){
        let background = SKSpriteNode(imageNamed:"background")
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = -1
        let moveBackGround : SKAction = SKAction.moveTo(y: -background.size.height, duration: 100)
        background.run(moveBackGround)
        self.addChild(background)
    }
    
    func addPlayer() {
        player.position = CGPoint(x: self.size.width/2, y: player.size.height/2)
       
        let shootAction = SKAction.run(addBullet)
        let shootActionWithDelay = SKAction.sequence([shootAction, SKAction.wait(forDuration: 0.1)])
        let shootActionForever = SKAction.repeatForever(shootActionWithDelay)
        let PlayerLimitnessAreaX = SKRange(lowerLimit: 0 , upperLimit: size.width)
        let PlayerLimitnessAreaY = SKRange(lowerLimit: 0, upperLimit: size.height)
        let retrisctionMove = SKConstraint.positionX(PlayerLimitnessAreaX, y : PlayerLimitnessAreaY)
        player.constraints = [retrisctionMove]
        player.run(shootActionForever)
        self.addChild(player)
        
        
    }
    
    func addEnemyandBullet() {
        
        
        let shootActionEnemy = SKAction.run(addBulletEnemy)
        let shootActionEnemyWithDelay = SKAction.sequence([shootActionEnemy, SKAction.wait(forDuration: 0.5)])
        let shootActionEnemyForever = SKAction.repeatForever(shootActionEnemyWithDelay)
        
        enemy.run(shootActionEnemyForever)
        self.addChild(enemy)
    }
    func addEnemy()  {
        let randomEnemyPosition = GKRandomDistribution(lowestValue : 0, highestValue: 414)
        let position = CGFloat(randomEnemyPosition.nextInt())
        enemy.position = CGPoint(x: position, y: (self.frame.size.height + enemy.size.height) )
        
        
        let enemyMoveToBot = SKAction.moveTo(y: 0 , duration: Double(enemy.position.y) / ENEMY_SPEED)
        let EnemyRemoveAtBot = SKAction.sequence([enemyMoveToBot, SKAction.removeFromParent()])
        
        
        
        enemy.run(EnemyRemoveAtBot)

    }
    func addBulletEnemy(){
    
        let bulletEnemy = SKSpriteNode(imageNamed: "bulletEnemy")
        bulletEnemy.position = CGPoint(x: enemy.position.x , y: enemy.position.y - (enemy.size.height + bulletEnemy.size.height) / 2)
        let distanceEnemyBullet = enemy.position.y - bulletEnemy.position.y - bulletEnemy.size.height * 0.5
        let enemyfire = SKAction.moveTo(y: 0, duration: Double(distanceEnemyBullet) / BULLETENEMY_SPEED)
        let enemyfireWithRemoveAtBot = SKAction.sequence([enemyfire, SKAction.removeFromParent()])
        bulletEnemy.run(enemyfireWithRemoveAtBot)
        
        
        self.addChild(bulletEnemy)
    }
    
    func addBullet(){
        let bullet = SKSpriteNode(imageNamed: "bullet-double")
        bullet.position = CGPoint(x: player.position.x, y: player.position.y + (player.size.height + bullet.size.height)/2 )
        let playerfire = SKAction.moveTo(y: self.size.height, duration: Double(self.size.height - bullet.position.y) / BULLET_SPEED )
        let playerfireWithRemoveFromRoot = SKAction.sequence([playerfire, SKAction.removeFromParent()])
        bullet.run(playerfireWithRemoveFromRoot)
        self.addChild(bullet)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan: count = \(touches.count)")
        //unwraping, nil = null
        if let touch = touches.first{
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            
            let vector = CGVector(dx: location.x - previousLocation.x, dy: location.y - previousLocation.y)
            
            let dx = location.x - previousLocation.x
            let dy = location.y - previousLocation.y
            let distance = sqrt(dx*dx + dy*dy)
            let time = Double(distance) / PLAYER_SPEED
            let move = SKAction.move(by: vector, duration: time)
            player.run(move)
            
            //player.position = location
//            let dx = location.x - player.position.x
//            let dy = location.y - player.position.y
//            let distance = sqrt(dx * dx + dy * dy)
//            let time = Double(distance) / PLAYER_SPEED
//            
//       player.run(SKAction.move(to: location, duration: time))
            print("location : \(location) ")
        
            }
        }
    
    }
