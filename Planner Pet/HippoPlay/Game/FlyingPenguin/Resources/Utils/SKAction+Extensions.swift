//
//  SKAction+Extensions.swif
//  Planner Pet
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

import SpriteKit

public extension SKAction {
  
  public class func afterDelay(_ delay: TimeInterval, performAction action: SKAction) -> SKAction {
    return SKAction.sequence([SKAction.wait(forDuration: delay), action])
  }

  
  public class func afterDelay(_ delay: TimeInterval, runBlock block: @escaping () -> Void) -> SKAction {
    return SKAction.afterDelay(delay, performAction: SKAction.run(block))
  }

  /**
   * Removes the node from its parent after the specified delay.
   */
  public class func removeFromParentAfterDelay(_ delay: TimeInterval) -> SKAction {
    return SKAction.afterDelay(delay, performAction: SKAction.removeFromParent())
  }
    
  /**
   * Creates an action to perform a parabolic jump.
   */
  public class func jumpToHeight(_ height: CGFloat, duration: TimeInterval, originalPosition: CGPoint) -> SKAction {
    return SKAction.customAction(withDuration: duration) {(node, elapsedTime) in
      let fraction = elapsedTime / CGFloat(duration)
      let yOffset = height * 4 * fraction * (1 - fraction)
      node.position = CGPoint(x: originalPosition.x, y: originalPosition.y + yOffset)
    }
  }
}
