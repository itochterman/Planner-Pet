//
//  WYAnimationComponent.swif
//  Planner Pet
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

import GameplayKit
import SpriteKit

class WYAnimationComponent:GKComponent {
    let textures:[SKTexture]
    let spriteComponent: WYSpriteComponent
    
    init(entity:GKEntity,textures:[SKTexture]) {
        self.spriteComponent = entity.component(ofType: WYSpriteComponent.self)!
        self.textures = textures
        super.init()
    }
    // 翅膀拍动
    func startAnimation(){
        let flyAction = SKAction.animate(with: textures, timePerFrame: TimeInterval(0.02))
        let repeatAction = SKAction.repeatForever(flyAction)
        spriteComponent.node.run(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
