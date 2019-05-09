//
//  WYCoinSprite.swif
//  Planner Pet
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

import SpriteKit

public class WYCoinSprite:SKSpriteNode {
    
    public static func sharedInstance() -> WYCoinSprite {
        
        let coinNode = WYCoinSprite(imageNamed: "coin01")
        coinNode.anchorPoint = CGPoint(x: 0, y: 0.5)
        coinNode.name = "coin"
        coinNode.physicsBody = SKPhysicsBody(circleOfRadius: coinNode.size.width / 2)
        coinNode.physicsBody?.affectedByGravity = false  //不受重力影响
        coinNode.physicsBody?.categoryBitMask = WyPhysicsFlyCategory.Coin
        coinNode.physicsBody?.contactTestBitMask = WyPhysicsFlyCategory.Player
        coinNode.physicsBody?.collisionBitMask = WyPhysicsFlyCategory.None
        coinNode.zPosition = 6  // 地板的上方
        
        // frame
        var coinTextures = [SKTexture]()
        coinTextures.append(SKTexture(imageNamed: "coin01"))
        coinTextures.append(SKTexture(imageNamed: "coin02"))
        let coinAction = SKAction.animate(with: coinTextures, timePerFrame: 0.2)
        let repeatAction    = SKAction.repeatForever(coinAction)
        coinNode.run(repeatAction)
        
        return coinNode
    }
    
    
}
