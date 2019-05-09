//
//  WYGameElements.swif
//  Planner Pet
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//


import SpriteKit

// 建立Node
extension GameFlyScene{
    // 障碍物
    func createObstacle() -> SKSpriteNode{
        //Entity
        let obstacle = WYObstacleEntity(imageName: "wall")
        //Component
        let obstacleNode  = obstacle.spriteCom.node
        obstacleNode.name = "obstacle"
        obstacleNode.zPosition = 2 // 位于树的下层
        obstacleNode.anchorPoint = CGPoint(x: 0.5, y: 0)  // x轴为正中心，旋转后才会位于正顶端;
        obstacleNode.size.height = 570
        /* 障碍物
         * obstacleNode.size.height = 570 //值越大 游戏难度越大 ：size.height=>1536 - 500 - 500 企鹅通过的间隙就越小;
         */
        // let width  = (obstacleNode.texture?.size().width)!
        let height = (obstacleNode.texture?.size().height)! * 0.5
        obstacleNode.physicsBody = SKPhysicsBody(rectangleOf:(obstacleNode.texture?.size())!,center:CGPoint(x: 0, y:height))
        print("obstacle's center CGPoint:\(height)")
        obstacleNode.physicsBody?.affectedByGravity  = false
        obstacleNode.physicsBody?.isDynamic = false 
        obstacleNode.physicsBody?.categoryBitMask    = WyPhysicsFlyCategory.Obstacle
        obstacleNode.physicsBody?.contactTestBitMask = WyPhysicsFlyCategory.Player
        obstacleNode.physicsBody?.collisionBitMask   = WyPhysicsFlyCategory.None
        obstacleNode.physicsBody?.usesPreciseCollisionDetection = true
        
        return obstacleNode
    }
    //皇冠
    func createCrownSprite() -> SKSpriteNode {
        let crownNode = SKSpriteNode(imageNamed:"crown")    // 皇冠
        crownNode.zPosition = 8
        crownNode.zRotation = -CGFloat(10).degreesToRadians() // 角度  Mi /2
        crownNode.physicsBody = SKPhysicsBody(texture: crownNode.texture!, size: crownNode.size) //SKPhysicsBody(circleOfRadius: crownNode.size.width / 2)
        crownNode.physicsBody?.categoryBitMask   = WyPhysicsFlyCategory.Crown
        crownNode.physicsBody?.contactTestBitMask = WyPhysicsFlyCategory.Ground
        crownNode.physicsBody?.collisionBitMask  = WyPhysicsFlyCategory.Ground
        crownNode.physicsBody?.affectedByGravity = true
        crownNode.physicsBody?.isDynamic = false
         // 注意 皇冠此处要用 false ，因为皇冠是circle的物理体，会有细微的滚动，会一直update执行GameOverState
        crownNode.physicsBody?.usesPreciseCollisionDetection = false
        return crownNode
    }
    
}
