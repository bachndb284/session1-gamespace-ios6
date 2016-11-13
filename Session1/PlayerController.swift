//
//  PlayerController.swift
//  Session1
//
//  Created by Nguyen Bach on 11/12/16.
//  Copyright © 2016 Nguyen Bach. All rights reserved.
//
import AVFoundation
import Foundation
import SpriteKit

class PlayerController: Controller {
  let SHOOt_INTERVAL = 1.0
    var player : SKSpriteNode!
    var fireSound =  Bundle.main.url(forResource: "fire", withExtension: "mp3")
    var audioPlayer = AVAudioPlayer()
    init() {
        // set view
        super.init(view: SKSpriteNode(texture: PLAYER_TEXTURE))
        view.name = "player"
        player = self.view
        player.physicsBody = SKPhysicsBody(texture: PLAYER_TEXTURE, size: player.size)
        player.physicsBody?.categoryBitMask = PLAYER_MASK
        player.physicsBody?.contactTestBitMask = ENEMY_BULLET_MASK
        player.physicsBody?.collisionBitMask = 0
        
        
          }
    // Physics
    override  func config(position: CGPoint, parent: SKNode){
        super.config(position: position, parent: parent)
        self.configContraints()
        self.configShoot()
    }
    
    func configContraints() {
        //Contraints
        let xRange = SKRange(lowerLimit: 0, upperLimit: parent.frame.width)
        let yRange = SKRange(lowerLimit: 0, upperLimit: parent.frame.height)
        
        view.constraints = [SKConstraint.positionX(xRange, y: yRange)]
    }
    
    func configShoot()  {
        let shootAction = SKAction.run {
//            audioPlayer = AVAudioPlayer(contentsOf: fireSound, error :nil)
            
            let bulletController = PlayerBulletController()
            
            let startPosition = CGPoint(x: self.position.x, y: self.position.y + 0.5 * (self.height + bulletController.height)  )
            bulletController.config(position: startPosition, parent: self.parent) // !
            
            
         }
        let shootWithDelayAction = SKAction.sequence([shootAction, SKAction.wait(forDuration: self.SHOOt_INTERVAL)])
        view.run(SKAction.repeatForever(shootWithDelayAction))
    }
    
    func move(vector: CGVector){
        view.position = view.position.add(vector : vector)
    }
    
    func playSound(fileSound: SKAction)  {
        
    }

}
