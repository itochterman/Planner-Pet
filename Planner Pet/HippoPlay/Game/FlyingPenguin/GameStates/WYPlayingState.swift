//
//  WYPlayingState.swif
//  Planner Pet
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

import SpriteKit
import GameplayKit

class WYPlayingState :GKState {
    unowned let scene:GameFlyScene
    
    init(scene:SKScene){
        self.scene = scene as! GameFlyScene
        super.init()
    }
    //只调用一次
    override func didEnter(from previousState: GKState?) {
        scene.moveAllowed = true // 开始生成;
        scene.spawningCoins()     // 调用spawingCoins生成
        scene.spawningObstcale(TimeInterval(scene.randomDelay()))
        scene.stopWobble()       // 停止上下浮动
        scene.startAnimation()  // 开始拍打翅膀;
        //初始化向上的速度
        scene.applyInitialImpluse()
        
    }
    override func willExit(to nextState: GKState) {
        
    }
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return (stateClass == WYFallingState.self) || (stateClass == WYGameOverState.self)
    }
    // 每FRAME需要调用
    override func update(deltaTime seconds: TimeInterval) {
        // 继续player时时运行
        scene.applyInstantlyMovement(seconds)
    }
}
