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
    var bg = SKSpriteNode()
    override func didMoveToView(view: SKView) {
        
        //bg
        let bgTexture = SKTexture(imageNamed: "bg.png")
 
        let moveBg = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9)
        let resetBg = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        let bgAction = SKAction.repeatActionForever(SKAction.sequence([moveBg,resetBg]))
        
        
        for var i=0; i<3; i++ {
            bg.size.height = self.frame.height
            bg = SKSpriteNode(texture: bgTexture)
            bg.position = CGPoint(x: bgTexture.size().width/2 + bgTexture.size().width * CGFloat(i), y: frame.size.height/2.0)
            bg.runAction(bgAction)
            addChild(bg)
        }
        
        
        //bird
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        
        let animation = SKAction.animateWithTextures([birdTexture, birdTexture2], timePerFrame: 0.1)
        let makeBirdFlap = SKAction.repeatActionForever(animation)
        
        bird = SKSpriteNode(texture: birdTexture)
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height/2.0)
        bird.physicsBody!.dynamic = true
        
        bird.position = CGPoint(x: frame.size.width/2.0, y: frame.size.height/2.0)
        bird.runAction(makeBirdFlap)
        addChild(bird)
        
        
        //ground
        var ground = SKNode()
        ground.position = CGPointMake(0, 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.frame.size.width, height: 1))
        ground.physicsBody?.dynamic = false
        addChild(ground)
        
       
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        bird.physicsBody?.velocity = CGVectorMake(0, 0)
        bird.physicsBody?.applyImpulse(CGVectorMake(0, 50))
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
