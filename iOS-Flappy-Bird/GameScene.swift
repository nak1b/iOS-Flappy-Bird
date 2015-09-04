//
//  GameScene.swift
//  iOS-Flappy-Bird
//
//  Created by Nakib on 9/3/15.
//  Copyright (c) 2015 Nakib. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var bird = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        
        let animation = SKAction.animateWithTextures([birdTexture, birdTexture2], timePerFrame: 0.1)
        let makeBirdFlap = SKAction.repeatActionForever(animation)
        
        bird = SKSpriteNode(texture: birdTexture)
        bird.position = CGPoint(x: frame.size.width/2.0, y: frame.size.height/2.0)
        bird.runAction(makeBirdFlap)
        addChild(bird)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
