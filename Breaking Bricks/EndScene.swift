//
//  EndScene.swift
//  Breaking Bricks
//
//  Created by Justin Ferre on 11/3/15.
//  Copyright © 2015 Justin Ferre. All rights reserved.
//

import Foundation
import SpriteKit

class EndScene: SKScene {
    
  
    init(size: CGSize, won:Bool) {
        
        super.init(size: size)
        
     gameOver()
        tryAgain()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    func gameOver() {
        
        let label = SKLabelNode(fontNamed: "Futura Medium")
        label.text = "GAME OVER"
        label.fontColor = SKColor.whiteColor()
        label.fontSize = 40
        label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        
        self.addChild(label)
    }
    
    func tryAgain() {
        
        let label = SKLabelNode(fontNamed: "Futura Medium")
        label.text = "Tap To Try Again"
        label.fontColor = SKColor.whiteColor()
        label.fontSize = 30
        label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 320)
       let moveLabel = SKAction.moveToY(CGRectGetMidY(self.frame) - 40, duration: 2.0)
         label.runAction(moveLabel)
        self.addChild(label)
      
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var gameScene = GameScene(size: size)
        self.view?.presentScene(gameScene, transition: SKTransition.doorsOpenHorizontalWithDuration(1.5) )
    }
    
}