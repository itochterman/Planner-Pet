//
//  CGVector+Extensions.swif
//  Planner Pet
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

import CoreGraphics
import SpriteKit

public extension CGVector {
  
  public init(point: CGPoint) {
    self.init(dx: point.x, dy: point.y)
  }
    
  public init(angle: CGFloat) {
    self.init(dx: cos(angle), dy: sin(angle))
  }

  public mutating func offset(_ dx: CGFloat, dy: CGFloat) -> CGVector {
    self.dx += dx
    self.dy += dy
    return self
  }
    
  public func length() -> CGFloat {
    return sqrt(dx*dx + dy*dy)
  }

  
  public func lengthSquared() -> CGFloat {
    return dx*dx + dy*dy
  }

  
  func normalized() -> CGVector {
    let len = length()
    return len>0 ? self / len : CGVector.zero
  }

  
  public mutating func normalize() -> CGVector {
    self = normalized()
    return self
  }

  
  public func distanceTo(_ vector: CGVector) -> CGFloat {
    return (self - vector).length()
  }

  
  public var angle: CGFloat {
    return atan2(dy, dx)
  }
}


public func + (left: CGVector, right: CGVector) -> CGVector {
  return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
}


public func += (left: inout CGVector, right: CGVector) {
  left = left + right
}


public func - (left: CGVector, right: CGVector) -> CGVector {
  return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
}


public func -= (left: inout CGVector, right: CGVector) {
  left = left - right
}

/**
 * Multiplies two CGVector values and returns the result as a new CGVector.
 */
public func * (left: CGVector, right: CGVector) -> CGVector {
  return CGVector(dx: left.dx * right.dx, dy: left.dy * right.dy)
}

/**
 * Multiplies a CGVector with another.
 */
public func *= (left: inout CGVector, right: CGVector) {
  left = left * right
}

/**
 * Multiplies the x and y fields of a CGVector with the same scalar value and
 * returns the result as a new CGVector.
 */
public func * (vector: CGVector, scalar: CGFloat) -> CGVector {
  return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
}

/**
 * Multiplies the x and y fields of a CGVector with the same scalar value.
 */
public func *= (vector: inout CGVector, scalar: CGFloat) {
  vector = vector * scalar
}

/**
 * Divides two CGVector values and returns the result as a new CGVector.
 */
public func / (left: CGVector, right: CGVector) -> CGVector {
  return CGVector(dx: left.dx / right.dx, dy: left.dy / right.dy)
}

/**
 * Divides a CGVector by another.
 */
public func /= (left: inout CGVector, right: CGVector) {
  left = left / right
}

/**
 * Divides the dx and dy fields of a CGVector by the same scalar value and
 * returns the result as a new CGVector.
 */
public func / (vector: CGVector, scalar: CGFloat) -> CGVector {
  return CGVector(dx: vector.dx / scalar, dy: vector.dy / scalar)
}

/**
 * Divides the dx and dy fields of a CGVector by the same scalar value.
 */
public func /= (vector: inout CGVector, scalar: CGFloat) {
  vector = vector / scalar
}

/**
 * Performs a linear interpolation between two CGVector values.
 */
public func lerp(_ start: CGVector, end: CGVector, t: CGFloat) -> CGVector {
  return start + (end - start) * t
}
