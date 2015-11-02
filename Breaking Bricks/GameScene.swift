//
//  GameScene.swift
//  Breaking Bricks
//
//  Created by Justin Ferre on 11/1/15.
//  Copyright (c) 2015 Justin Ferre. All rights reserved.
//

import SpriteKit



class GameScene: SKScene {
   let paddle = SKSpriteNode(imageNamed: "paddle")
    let ball = SKSpriteNode(imageNamed: "ball")
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.backgroundColor = SKColor.whiteColor()
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
        
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        createBall()
        createPaddle()
    }
    

    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            
            let location = touch.locationInNode(self)
            var newLocation = CGPointMake(location.x, size.height/4)
            var previousLocation = touch.previousLocationInNode(self)
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
        
        
        
        let myVector = CGVectorMake(10, 10)
        
        ball.physicsBody?.applyImpulse(myVector)

    }
    
    func createPaddle() {
        
        paddle.position = CGPointMake(size.width/2, size.height/4)
        paddle.physicsBody = SKPhysicsBody(rectangleOfSize: paddle.frame.size)
        paddle.physicsBody?.dynamic = false
        
        
        self.addChild(paddle)
        
    }
    
}

