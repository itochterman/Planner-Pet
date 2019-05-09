//
//  WYConstant.swif
//  Planner Pet
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//
import UIKit
import SpriteKit
import CoreGraphics

// 物理标识;
struct WyPhysicsFlyCategory {
    
    static let None: UInt32      = 0x1 << 1
    static let Player: UInt32    = 0x1 << 2
    static let Obstacle: UInt32  = 0x1 << 3
    static let Coin:UInt32       = 0x1 << 4
    static let Ground: UInt32    = 0x1 << 5
    static let Floor: UInt32     = 0x1 << 6
    static let PlayerLose:UInt32 = 0x1 << 7
    static let Crown:UInt32      = 0x1 << 8
}
// UI图层位置;
enum LayerFly:CGFloat {
    case Background
    case Cloud
    case Mountain
    case Tree
    case Obstacle
    case Player
}
