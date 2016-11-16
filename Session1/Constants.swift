//
//  Constants.swift
//  Session1
//
//  Created by Nguyen Bach on 11/10/16.
//  Copyright © 2016 Nguyen Bach. All rights reserved.
//

import SpriteKit

let PLAYER_MASK         = UInt32(1<<0)
let PLAYER_BULLET_MASK  = UInt32(1<<1)
let ENEMY_MASK          = UInt32(1<<2)
let ENEMY_BULLET_MASK   = UInt32(1<<3)

let PLAYER_BULLET_TEXTURE = SKTexture(imageNamed : "bullet-double")
let ENEMY_BULLET_TEXTURE = SKTexture(imageNamed: "bulletEnemy")
let PLAYER_TEXTURE = SKTexture(imageNamed: "plane5")
var ENEMY_TEXTURE = [enemyA, enemyB, enemyC]

let enemyA = SKTexture(imageNamed: "plane1")
let enemyB = SKTexture(imageNamed: "plane2")
let enemyC = SKTexture(imageNamed: "plane3")


//let GAMEOVER_SCENE_BUTTON = SKTexture(imageNamed: "RestartButton")
