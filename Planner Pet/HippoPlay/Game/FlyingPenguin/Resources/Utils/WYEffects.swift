//
//  WYEffects.swif
//  Planner Pet
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

import SpriteKit

open class WYEffects {
  unowned var node: SKNode
  var duration: TimeInterval
  open var timingFunction: ((CGFloat) -> CGFloat)?

  public init(node: SKNode, duration: TimeInterval) {
    self.node = node
    self.duration = duration
    timingFunction = WYTimingFunctionLinear
  }

  open func update(_ t: CGFloat) {
    // subclasses implement this
  }
}

/**
 * Moves a node from its current position to a new position.
 */
open class WYMoveEffect: WYEffects {
  var startPosition: CGPoint
  var delta: CGPoint
  var previousPosition: CGPoint
  
  public init(node: SKNode, duration: TimeInterval, startPosition: CGPoint, endPosition: CGPoint) {
    previousPosition = node.position
    self.startPosition = startPosition
    delta = endPosition - startPosition
    super.init(node: node, duration: duration)
  }
  
  open override func update(_ t: CGFloat) {
    // This allows multiple SKTMoveEffect objects to modify the same node
    // at the same time.
    let newPosition = startPosition + delta*t
    let diff = newPosition - previousPosition
    previousPosition = newPosition
    node.position += diff
  }
}

/**
 * Scales a node to a certain scale factor.
 */
open class WYScaleEffect: WYEffects {
  var startScale: CGPoint
  var delta: CGPoint
  var previousScale: CGPoint

  public init(node: SKNode, duration: TimeInterval, startScale: CGPoint, endScale: CGPoint) {
    previousScale = CGPoint(x: node.xScale, y: node.yScale)
    self.startScale = startScale
    delta = endScale - startScale
    super.init(node: node, duration: duration)
  }

  open override func update(_ t: CGFloat) {
    let newScale = startScale + delta*t
    let diff = newScale / previousScale
    previousScale = newScale
    node.xScale *= diff.x
    node.yScale *= diff.y
  }
}

/**
 * Rotates a node to a certain angle.
 */
open class WYRotateEffect: WYEffects {
  var startAngle: CGFloat
  var delta: CGFloat
  var previousAngle: CGFloat

  public init(node: SKNode, duration: TimeInterval, startAngle: CGFloat, endAngle: CGFloat) {
    previousAngle = node.zRotation
    self.startAngle = startAngle
    delta = endAngle - startAngle
    super.init(node: node, duration: duration)
  }

  open override func update(_ t: CGFloat) {
    let newAngle = startAngle + delta*t
    let diff = newAngle - previousAngle
    previousAngle = newAngle
    node.zRotation += diff
  }
}

/**
 * Wrapper that allows you to use SKTEffect objects as regular SKActions.
 */
public extension SKAction {
  public class func actionWithEffect(_ effect: WYEffects) -> SKAction {
    return SKAction.customAction(withDuration: effect.duration) { node, elapsedTime in
      var t = elapsedTime / CGFloat(effect.duration)

      if let timingFunction = effect.timingFunction {
        t = timingFunction(t)  // the magic happens here
      }

      effect.update(t)
    }
  }
}
