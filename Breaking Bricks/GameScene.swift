//
//  GameScene.swift
//  Breaking Bricks
//
//  Created by Justin Ferre on 11/1/15.
//  Copyright (c) 2015 Justin Ferre. All rights reserved.
//

import SpriteKit

let ballCategory: UInt32 = 0x1
let brickCategory: UInt32 = 0x1 << 1
let paddleCategory: UInt32 = 0x1 << 2
let edgeCategory: UInt32 = 0x1 << 3
let bottomEdgeCategory: UInt32 = 0x1 << 4

class GameScene: SKScene, SKPhysicsContactDelegate {
   let paddle = SKSpriteNode(imageNamed: "paddle")
    let ball = SKSpriteNode(imageNamed: "ball")
    let playBlip =  SKAction.playSoundFileNamed("blip.wav", waitForCompletion: false)
    let playBrickHit =  SKAction.playSoundFileNamed("brickhit.wav", waitForCompletion: false)
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.backgroundColor = SKColor.whiteColor()
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.categoryBitMask = edgeCategory
        self.physicsWorld.contactDelegate = self
        
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        createBall()
        createPaddle()
        createBricks()
        addBottomEdge()
    }
    

    func didBeginContact(contact: SKPhysicsContact) {
//     
        
        
        
        
        
        let notTheBall: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            
            notTheBall = contact.bodyB
        }else {
            notTheBall = contact.bodyA
        }
        if notTheBall.categoryBitMask == brickCategory {
            print("it's a brick")
          //  self.runAction(playBrickHit)
            notTheBall.node?.removeFromParent()
            
        }
        if notTheBall.categoryBitMask == paddleCategory {
            print("it's the paddle")
           
           // self.runAction(playBlip)
        }
        if notTheBall.categoryBitMask == bottomEdgeCategory {
           let end = EndScene(size: self.size, won: false)
            self.view?.presentScene(end, transition: SKTransition.doorsCloseHorizontalWithDuration(0.5))
            
            
            
        }
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            
            let location = touch.locationInNode(self)
            let newLocation = CGPointMake(location.x, size.height/4)
            let previousLocation = touch.previousLocationInNode(self)
          var xPos = paddle.position.x + (newLocation.x - previousLocation.x)
            xPos = max(xPos, paddle.size.width/2)
            xPos = min(xPos, (size.width - (paddle.size.width / 2)))
            
            paddle.position = CGPointMake(xPos, paddle.position.y)
            
            
        }
        
        
    }
    
    
    func createBall() {
        
        //create a new sprite node for an image
        
        
        //ball.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        let myPoint = CGPointMake(size.width/2, size.height/2)
        ball.position = myPoint
        ball.color = SKColor.redColor()
        self.addChild(ball)
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.width/2)
        ball.physicsBody?.friction = 0
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = brickCategory | paddleCategory | bottomEdgeCategory
//        ball.physicsBody?.collisionBitMask = edgeCategory | brickCategory
        
        
        
        let myVector = CGVectorMake(10, 10)
        
        ball.physicsBody?.applyImpulse(myVector)

    }
    
    func createPaddle() {
        
        paddle.position = CGPointMake(size.width/2, size.height/4)
        paddle.physicsBody = SKPhysicsBody(rectangleOfSize: paddle.frame.size)
        paddle.physicsBody?.dynamic = false
        paddle.physicsBody?.categoryBitMask = paddleCategory
        
        
        self.addChild(paddle)
        
    }
    
    func createBricks() {
        for var i = 0; i < 5; i++ {
            let brick = SKSpriteNode(imageNamed: "brick")
            
            brick.physicsBody = SKPhysicsBody(rectangleOfSize: brick.frame.size)
            brick.physicsBody?.dynamic = false
            brick.physicsBody?.categoryBitMask = brickCategory
            let xPos = (size.width/5 - 10) * CGFloat(i + 1)
            let yPos = size.height - 50
            brick.position = CGPointMake(xPos, yPos)
            self.addChild(brick)
        }
        
    }
    
    func addBottomEdge() {
        
        let bottomEdge = SKNode()
        bottomEdge.physicsBody = SKPhysicsBody(edgeFromPoint: CGPointMake(0, 1), toPoint: CGPointMake(size.width, 1))
        bottomEdge.physicsBody?.categoryBitMask = bottomEdgeCategory
        self.addChild(bottomEdge)
        
    }
    
}

