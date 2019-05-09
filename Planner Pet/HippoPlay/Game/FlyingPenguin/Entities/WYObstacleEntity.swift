//
//  WYObstacleEntity.swif
//  Planner Pet
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

import SpriteKit
import GameplayKit

class WYObstacleEntity:GKEntity {
    var spriteCom:WYSpriteComponent! // 精灵组件本身
    // var moveComponent:MoveComponent?  // 没有移动的功能
    init(imageName:String) {
        super.init()
        let texture = SKTexture(imageNamed: imageName)
        spriteCom = WYSpriteComponent(entity: self, texture: texture, size: texture.size())
        addComponent(spriteCom)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
