//
//  WYPenguinEntity.swif
//  Planner Pet
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

import SpriteKit
import GameplayKit

class WYPenguinEntity:GKEntity {
    
    var spriteCom:WYSpriteComponent! // 属性 大小 texture
    var moveCom:WYMoveComponent!     // 移动组件功能;
    var animationCom:WYAnimationComponent! //拍打翅膀的组件;
    
    init(imageName:String) {
        super.init()
        let texture = SKTexture(imageNamed: imageName)
        spriteCom = WYSpriteComponent(entity: self, texture: texture, size: texture.size())
        addComponent(spriteCom)
        // 加入上下飞动的组件
        moveCom = WYMoveComponent(entity: self)
        addComponent(moveCom)
        
        // 加入拍打翅膀的动画
        let textureAltas = SKTextureAtlas(named: "penguin")
        var textures = [SKTexture]()
        for i in 1...textureAltas.textureNames.count {
            let imageName = "penguin0\(i)"
            textures.append(SKTexture(imageNamed: imageName))
        }
        animationCom = WYAnimationComponent(entity: self, textures: textures)
        addComponent(animationCom)

    }
     // Add Physics
    func addPhysics(){
        let spriteNode = spriteCom.node
        spriteNode.physicsBody = SKPhysicsBody(texture: spriteNode.texture!, size: spriteNode.frame.size)
        spriteNode.physicsBody?.categoryBitMask  = WyPhysicsFlyCategory.Player
        spriteNode.physicsBody?.contactTestBitMask = WyPhysicsFlyCategory.Coin | WyPhysicsFlyCategory.Obstacle | WyPhysicsFlyCategory.Floor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
