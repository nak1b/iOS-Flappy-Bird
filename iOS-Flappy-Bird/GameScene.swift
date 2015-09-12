//
//  GameScene.swift
//  iOS-Flappy-Bird
//
//  Created by Nakib on 9/3/15.
//  Copyright (c) 2015 Nakib. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var bird = SKSpriteNode()
    var bg = SKSpriteNode()
    
    var pipe1 = SKSpriteNode()
    var pipe2 = SKSpriteNode()
    
    enum ColliderType: UInt32{
        case Bird = 1
        case Object = 2
    }
    
    var gameOver = false
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.contactDelegate = self
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
        
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.contactTestBitMask = ColliderType.Object.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Object.rawValue
        
        addChild(bird)
        
        
        //ground
        var ground = SKNode()
        ground.position = CGPointMake(0, 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.frame.size.width, height: 1))
        ground.physicsBody?.dynamic = false
        
        ground.physicsBody?.categoryBitMask = ColliderType.Object.rawValue
        ground.physicsBody?.collisionBitMask = ColliderType.Object.rawValue
        ground.physicsBody?.contactTestBitMask = ColliderType.Object.rawValue
        addChild(ground)
        
        
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("makePipes"), userInfo: nil, repeats: true)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        print("We have contact")
        gameOver = true
        self.speed = 0
    }
    
    func makePipes(){
        //pipes
        let gapHeight = bird.size.height * 4
        let movementAmount = arc4random() % UInt32(self.frame.size.height/2)
        
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height/4.0
        
        let movePipes = SKAction.moveByX(-self.frame.size.width*2 , y: 0, duration: NSTimeInterval(self.frame.size.width/100))
        let removePipe = SKAction.removeFromParent()
        
        let moveAndRemovePipes = SKAction.sequence([movePipes, removePipe])
        
        //create pipe TOP
        var pipeTexture = SKTexture(imageNamed: "pipe1.png")
        var pipe1 = SKSpriteNode(texture: pipeTexture)
        pipe1.position = CGPoint(x:frame.size.width/2.0 + frame.size.width, y:frame.size.height/2.0 + pipeTexture.size().height/2 + gapHeight/2.0 + pipeOffset)
        pipe1.runAction(moveAndRemovePipes)
        
        pipe1.physicsBody = SKPhysicsBody(rectangleOfSize: pipeTexture.size())
        pipe1.physicsBody?.dynamic = false
        pipe1.physicsBody?.categoryBitMask = ColliderType.Object.rawValue
        pipe1.physicsBody?.collisionBitMask = ColliderType.Object.rawValue
        pipe1.physicsBody?.contactTestBitMask = ColliderType.Object.rawValue
        
        addChild(pipe1)
        
        //create pipe Bottom
        var pipeTexture2 = SKTexture(imageNamed: "pipe2.png")
        var pipe2 = SKSpriteNode(texture: pipeTexture2)
        pipe2.position = CGPoint(x:frame.size.width/2.0 + frame.size.width, y:frame.size.height/2.0-pipeTexture2.size().height/2 - gapHeight/2.0 + pipeOffset)
        pipe2.runAction(moveAndRemovePipes)
        
        pipe2.physicsBody = SKPhysicsBody(rectangleOfSize: pipeTexture.size())
        pipe2.physicsBody?.dynamic = false
        pipe2.physicsBody?.categoryBitMask = ColliderType.Object.rawValue
        pipe2.physicsBody?.collisionBitMask = ColliderType.Object.rawValue
        pipe2.physicsBody?.contactTestBitMask = ColliderType.Object.rawValue
        
        addChild(pipe2)
    }

    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if gameOver == false{
            bird.physicsBody?.velocity = CGVectorMake(0, 0)
            bird.physicsBody?.applyImpulse(CGVectorMake(0, 50))
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
