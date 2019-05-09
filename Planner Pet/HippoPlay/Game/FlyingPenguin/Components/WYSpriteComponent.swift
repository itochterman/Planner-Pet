//
//  WYSpriteComponent.swif
//  Planner Pet
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

import SpriteKit
import GameplayKit

// node可被重复使用;
class WYSpriteComponent :GKComponent {
    let node:SKSpriteNode
    init(entity:GKEntity,texture:SKTexture,size:CGSize) {
        node = SKSpriteNode(texture: texture, color: SKColor.clear, size: size)
        node.entity = entity
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
