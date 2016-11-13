//
//  GameScene.swift
//  Session1
//
//  Created by Nguyen Bach on 11/8/16.
//  Copyright © 2016 Nguyen Bach. All rights reserved.
//

import SpriteKit
import GameplayKit

//let PLAYER_MASK         = UInt32(1<<0)
//let PLAYER_BULLET_MASK  = UInt32(1<<1)
//let ENEMY_MASK          = UInt32(1<<2)
//let ENEMY_BULLET_MASK   = UInt32(1<<3)

class GameScene: SKScene , SKPhysicsContactDelegate{
    
//  let player = SKSpriteNode(imageNamed: "plane2")
//  let enemy = SKSpriteNode(imageNamed: "Bigenemy" )
  let PLAYER_SPEED      = 150.0
  let BULLET_SPEED      = 300.0
  let ENEMY_SPEED       = 100.0
  let BULLETENEMY_SPEED = 150.0
  let playerController = PlayerController()
  var gameTimer : Timer!
  //var explore = SKAction
    
    
    
    override func didMove(to view: SKView) {
    
        configPhysics()
        addbackGround()
        let playerPosition = CGPoint(x: self.size.width / 2 , y: playerController.height/2)
        playerController.config(position: playerPosition, parent: self)
       
        
//        addEnemyandBullet()
        addEnemies()
//        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addEnemies), userInfo: nil, repeats: true)
        
        
                }
    func addEnemies() -> Void {
        let enemyController = EnemyController()
        let randomEnemiesPosition = GKRandomDistribution(lowestValue: 0, highestValue: 414)
        let position = CGFloat(randomEnemiesPosition.nextInt())
       enemyController.config(position: CGPoint(x: position , y : self.frame.size.height ), parent: self)
         }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            let movementVector = CGVector(dx: location.x - previousLocation.x, dy: location.y - previousLocation.y)
            playerController.move(vector: movementVector)
            
        }
    }
    func addbackGround(){
        let background = SKSpriteNode(imageNamed:"background")
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)

        let moveBackGround : SKAction = SKAction.moveTo(y: -background.size.height, duration: 100)
        background.run(moveBackGround)
        self.addChild(background)

    }
    
    func configPhysics()  {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }

    
        func didBegin(_ contact: SKPhysicsContact) {
            let nodeA = contact.bodyA.node
            let nodeB = contact.bodyB.node

    
            //0100 | 0010 = 0110
            //0010 | 0100 = 0110
            if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (ENEMY_MASK | PLAYER_BULLET_MASK){
                // enemy vs player bullet
                nodeA?.removeFromParent()
                nodeB?.removeFromParent()
                
    
            }
    
            if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (PLAYER_MASK | ENEMY_BULLET_MASK) {
                nodeA?.removeFromParent()
                nodeB?.removeFromParent()
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameOver = SKScene(fileNamed: "GameOverScene") as! GameOverScene
                self.view?.presentScene(gameOver, transition: transition)
            }
    
            if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (PLAYER_BULLET_MASK | ENEMY_BULLET_MASK) {
                nodeA?.removeFromParent()
                nodeB?.removeFromParent()
            }
    
        }
        
        func didEnd(_ contact: SKPhysicsContact) {
            
        }
    
//    func fire()  {
//
//        let playerPosition = CGPoint(x: self.size.width / 2 , y: playerController.height/2)
//        playerController.config(position: playerPosition, parent: self)
//     
//        self.run(SKAction.playSoundFileNamed("fire.mp3", waitForCompletion: false))
//        let fireNode = SKSpriteNode(imageNamed: "fire")
//        fireNode.position = playerPosition
//        fireNode.position.y += 5
//        
//        fireNode.physicsBody = SKPhysicsBody(circleOfRadius: fireNode.size.width / 2)
//        fireNode.physicsBody?.isDynamic = true
//        
//        fireNode.physicsBody?.categoryBitMask = 
//    }
    
//    
//    func addPlayer() {
//        player.position = CGPoint(x: self.size.width/2, y: player.size.height/2)
//        //bullet Forever
//        let shootAction = SKAction.run(addBullet)
//        let shootActionWithDelay = SKAction.sequence([shootAction, SKAction.wait(forDuration: 0.1)])
//        let shootActionForever = SKAction.repeatForever(shootActionWithDelay)
//        //Limiting the player-area
//        let PlayerLimitnessAreaX = SKRange(lowerLimit: 0 , upperLimit: size.width)
//        let PlayerLimitnessAreaY = SKRange(lowerLimit: 0, upperLimit: size.height)
//        let retrisctionMove = SKConstraint.positionX(PlayerLimitnessAreaX, y : PlayerLimitnessAreaY)
//        player.constraints = [retrisctionMove]
//        player.run(shootActionForever)
//        self.addChild(player)
//        
//        
//    }
    
//    func addEnemyandBullet() {
//        
//        
//        let shootActionEnemy = SKAction.run(addBulletEnemy)
//        let shootActionEnemyWithDelay = SKAction.sequence([shootActionEnemy, SKAction.wait(forDuration: 0.5)])
//        let shootActionEnemyForever = SKAction.repeatForever(shootActionEnemyWithDelay)
//        
//        enemy.run(shootActionEnemyForever)
//        self.addChild(enemy)
//    }
//    func addEnemy()  {
//        //random the position's enemy
//        let randomEnemyPosition = GKRandomDistribution(lowestValue : 0, highestValue: 414)
//        let position = CGFloat(randomEnemyPosition.nextInt())
//        enemy.position = CGPoint(x: position, y: (self.size.height + enemy.size.height) )
//        
//        
//        let enemyMoveToBot = SKAction.moveTo(y: 0 , duration: Double(enemy.position.y) / ENEMY_SPEED)
//        let EnemyRemoveAtBot = SKAction.sequence([enemyMoveToBot, SKAction.removeFromParent()])
//        
//        
//        
//        enemy.run(EnemyRemoveAtBot)
//
//    }
    

//    //**** chua bai tap ve nha
//    func addEnemies()  {
//        
//        let enemy = SKSpriteNode(imageNamed: "Bigenemy" )
//        enemy.name = "enemy"
//        enemy.position = CGPoint(x : self.size.width / 2 , y : self.size.height)
//        
//        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
//        enemy.physicsBody?.categoryBitMask = ENEMY_MASK
//        enemy.physicsBody?.contactTestBitMask = PLAYER_BULLET_MASK
//        enemy.physicsBody?.collisionBitMask = 0
//        
//        // Fly
//        
//        let  flyAction = SKAction.moveTo(y :   0 , duration: 3)
//        let flyAndRemoveAction = SKAction.sequence([flyAction, SKAction.removeFromParent()])
//        
//        //Shoot
//        
//        let shootAction = SKAction.run {
////            let bullet = SKSpriteNode(imageNamed: "bulletEnemy")
//            let bulletController = EnemyBulletController()
//            
//            let bulletPosition = enemy.position.add(x: 0 , y: -(enemy.size.height + bulletController.height)/2)
//            bulletController.config(position: bulletPosition, parent: self)
////            let flyToBottom = SKAction.moveTo(y: 0, duration: Double (self.size.height - bullet.position.y) / self.BULLETENEMY_SPEED )
////            let removeBullet = SKAction.sequence([flyToBottom, SKAction.removeFromParent()])
////            let EnemyBulletForever = SKAction.repeatForever(removeBullet)
////            bullet.run(EnemyBulletForever)
////            self.addChild(bullet)
//        }
//        
//        enemy.run(flyAndRemoveAction)
//        enemy.run(SKAction.repeatForever(SKAction.sequence([shootAction, SKAction.wait(forDuration: 1)])))
//        self.addChild(enemy)
//        
    }
//    func addBulletEnemy(){
//    
//        let bulletEnemy = SKSpriteNode(imageNamed: "bulletEnemy")
//        bulletEnemy.position = CGPoint(x: enemy.position.x , y: enemy.position.y - (enemy.size.height + bulletEnemy.size.height) / 2)
//        let distanceEnemyBullet = enemy.position.y - bulletEnemy.position.y - bulletEnemy.size.height * 0.5
//        let enemyfire = SKAction.moveTo(y: 0, duration: Double(distanceEnemyBullet) / BULLETENEMY_SPEED)
//        let enemyfireWithRemoveAtBot = SKAction.sequence([enemyfire, SKAction.removeFromParent()])
//        bulletEnemy.run(enemyfireWithRemoveAtBot)
//        
//        
//        self.addChild(bulletEnemy)
//    }
    
//    func addBullet(){
////        let bullet = SKSpriteNode(imageNamed: "bullet-double")
////        bullet.name = "bullet"
////        bullet.position = CGPoint(x: player.position.x, y: player.position.y + (player.size.height + bullet.size.height)/2 )
////        
////        bullet.physicsBody = SKPhysicsBody(rectangleOf:  bullet.size)
////        // 0010
////        // 1 << 1 => 0010
////        // 1 << 2 => 0100
////        bullet.physicsBody?.categoryBitMask = PLAYER_BULLET_MASK
////        bullet.physicsBody?.contactTestBitMask = ENEMY_MASK
////        bullet.physicsBody?.collisionBitMask = 0
////        
////        let playerfire = SKAction.moveTo(y: self.size.height, duration: Double(self.size.height - bullet.position.y) / BULLET_SPEED )
////        let playerfireWithRemoveFromRoot = SKAction.sequence([playerfire, SKAction.removeFromParent()])
////        bullet.run(playerfireWithRemoveFromRoot)
////        
////        
////        self.addChild(bullet)
//
////        let bulletController = PlayerBulletController(position : player.position , parent: self)
////        self.addChild(bulletController.view)
//        
//        let bulletController = PlayerBulletController()
//        let startPosition = CGPoint(x: player.position.x, y: player.position.y + (player.size.height + bulletController.height ) / 2)
//        bulletController.config(position: startPosition, parent: self)
//    
//    }
//    //**** limiting area via Moveby
////    func move (point : CGPoint , vector : CGVector) -> CGPoint {
////        return CGPoint (x : point.x + vector.dx , y : point.y + vector.dy)
////    }

//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesBegan: count = \(touches.count)")
//        //unwraping, nil = null
//        if let touch = touches.first{
//            let location = touch.location(in: self)
//            let previousLocation = touch.previousLocation(in: self)
//            
//            
//            
//            let vector = CGVector(dx: location.x - previousLocation.x, dy: location.y - previousLocation.y)
//            // **** limiting area via Moveby
////            var nextpostion = self.move(point:player.position, vector: vector)
////            if nextpostion.x > self.size.width{
////                nextpostion.x = self.size.width
////            }
////            
////            if nextpostion.x < 0 {
////                nextpostion.x=0
////            }
////            
////            if nextpostion.y > self.size.height{
////                nextpostion.y = self.size.height
////            }
////            
////            if nextpostion.y < 0 {
////                nextpostion.y=0
////            }
//            
//            let dx = location.x - previousLocation.x
//            let dy = location.y - previousLocation.y
//            let distance = sqrt(dx*dx + dy*dy)
//            let time = Double(distance) / PLAYER_SPEED
//            let move = SKAction.move(by: vector, duration: time)
//            player.run(move)
//            
//            //player.position = location
////            let dx = location.x - player.position.x
////            let dy = location.y - player.position.y
////            let distance = sqrt(dx * dx + dy * dy)
////            let time = Double(distance) / PLAYER_SPEED
////            
////       player.run(SKAction.move(to: location, duration: time))
//            print("location : \(location) ")
//        
//            }
//        }

    
