//
//  CGFloat+Extension.swif
//  Planner Pet
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//
import CoreGraphics
import SpriteKit
/**   π as a CGFloat 180度 */
let π = CGFloat(Double.pi)

public extension CGFloat {

    /**
     * 角度转化为弧度.
     */
    public func degreesToRadians() -> CGFloat {
        return π * self / 180.0
    }
    
    /**
     * 弧度转化为角度.
     */
    public func radiansToDegrees() -> CGFloat {
        return self * 180.0 / π
    }

    /**
     *  0.0 and 1.0 随机数.
     */
    
    /**
     *   min...max 的随机数.
     */
    public static func random(_ min: CGFloat, max: CGFloat) -> CGFloat {
        assert(min < max)
        return CGFloat.random() * (max - min) + min
    }
    
}

public extension CGFloat {
    
    #if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
    #endif
    
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(min < max)
        return CGFloat.random() * (max - min) + min
    }
    
}
