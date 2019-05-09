//
//  WYTimingFunctions.swif
//  Planner Pet
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

import Foundation
import CoreGraphics

public func WYTimingFunctionLinear(_ t: CGFloat) -> CGFloat {
  return t
}

public func WYTimingFunctionQuadraticEaseIn(_ t: CGFloat) -> CGFloat {
  return t * t
}

public func WYTimingFunctionQuadraticEaseOut(_ t: CGFloat) -> CGFloat {
  return t * (2.0 - t)
}

public func WYTimingFunctionQuadraticEaseInOut(_ t: CGFloat) -> CGFloat {
  if t < 0.5 {
    return 2.0 * t * t
  } else {
    let f = t - 1.0
    return 1.0 - 2.0 * f * f
  }
}

func WYTimingFunctionCubicEaseIn(_ t: CGFloat) -> CGFloat {
  return t * t * t
}

func WYTimingFunctionCubicEaseOut(_ t: CGFloat) -> CGFloat {
  let f = t - 1.0
  return 1.0 + f * f * f
}

public func WYTimingFunctionCubicEaseInOut(_ t: CGFloat) -> CGFloat {
  if t < 0.5 {
    return 4.0 * t * t * t
  } else {
    let f = t - 1.0
    return 1.0 + 4.0 * f * f * f
  }
}

public func WYTimingFunctionQuarticEaseIn(_ t: CGFloat) -> CGFloat {
  return t * t * t * t
}

public func WYTimingFunctionQuarticEaseOut(_ t: CGFloat) -> CGFloat {
  let f = t - 1.0
  return 1.0 - f * f * f * f
}

public func WYTimingFunctionQuarticEaseInOut(_ t: CGFloat) -> CGFloat {
  if t < 0.5 {
    return 8.0 * t * t * t * t
  } else {
    let f = t - 1.0
    return 1.0 - 8.0 * f * f * f * f
  }
}

public func WYTimingFunctionQuinticEaseIn(_ t: CGFloat) -> CGFloat {
  return t * t * t * t * t
}

public func WYTimingFunctionQuinticEaseOut(_ t: CGFloat) -> CGFloat {
  let f = t - 1.0
  return 1.0 + f * f * f * f * f
}

func WYTimingFunctionQuinticEaseInOut(_ t: CGFloat) -> CGFloat {
  if t < 0.5 {
    return 16.0 * t * t * t * t * t
  } else {
    let f = t - 1.0
    return 1.0 + 16.0 * f * f * f * f * f
  }
}

public func WYTimingFunctionSineEaseIn(_ t: CGFloat) -> CGFloat {
  return sin((t - 1.0) * π/2) + 1.0
}

public func WYTimingFunctionSineEaseOut(_ t: CGFloat) -> CGFloat {
  return sin(t * π/2)
}

public func WYTimingFunctionSineEaseInOut(_ t: CGFloat) -> CGFloat {
  return 0.5 * (1.0 - cos(t * π))
}

public func WYTimingFunctionCircularEaseIn(_ t: CGFloat) -> CGFloat {
  return 1.0 - sqrt(1.0 - t * t)
}

public func WYTimingFunctionCircularEaseOut(_ t: CGFloat) -> CGFloat {
  return sqrt((2.0 - t) * t)
}

public func WYTimingFunctionCircularEaseInOut(_ t: CGFloat) -> CGFloat {
  if t < 0.5 {
    return 0.5 * (1.0 - sqrt(1.0 - 4.0 * t * t))
  } else {
    return 0.5 * sqrt(-4.0 * t * t + 8.0 * t - 3.0) + 0.5
  }
}

public func WYTimingFunctionExponentialEaseIn(_ t: CGFloat) -> CGFloat {
  return (t == 0.0) ? t : pow(2.0, 10.0 * (t - 1.0))
}

public func WYTimingFunctionExponentialEaseOut(_ t: CGFloat) -> CGFloat {
  return (t == 1.0) ? t : 1.0 - pow(2.0, -10.0 * t)
}

public func WYTimingFunctionExponentialEaseInOut(_ t: CGFloat) -> CGFloat {
  if t == 0.0 || t == 1.0 {
    return t
  } else if t < 0.5 {
    return 0.5 * pow(2.0, 20.0 * t - 10.0)
  } else {
    return 1.0 - 0.5 * pow(2.0, -20.0 * t + 10.0)
  }
}

public func WYTimingFunctionElasticEaseIn(_ t: CGFloat) -> CGFloat {
  return sin(13.0 * π/2 * t) * pow(2.0, 10.0 * (t - 1.0))
}

public func WYTimingFunctionElasticEaseOut(_ t: CGFloat) -> CGFloat {
  return sin(-13.0 * π/2 * (t + 1.0)) * pow(2.0, -10.0 * t) + 1.0
}

public func WYTimingFunctionElasticEaseInOut(_ t: CGFloat) -> CGFloat {
  if t < 0.5 {
    return 0.5 * sin(13.0 * π * t) * pow(2.0, 20.0 * t - 10.0)
  } else {
    return 0.5 * sin(-13.0 * π * t) * pow(2.0, -20.0 * t + 10.0) + 1.0
  }
}

public func WYTimingFunctionBackEaseIn(_ t: CGFloat) -> CGFloat {
  let s: CGFloat = 1.70158
  return ((s + 1.0) * t - s) * t * t
}

public func WYTimingFunctionBackEaseOut(_ t: CGFloat) -> CGFloat {
  let s: CGFloat = 1.70158
  let f = 1.0 - t
  return 1.0 - ((s + 1.0) * f - s) * f * f
}

public func WYTimingFunctionBackEaseInOut(_ t: CGFloat) -> CGFloat {
  let s: CGFloat = 1.70158
  if t < 0.5 {
    let f = 2.0 * t
    return 0.5 * ((s + 1.0) * f - s) * f * f
  } else {
    let f = 2.0 * (1.0 - t)
    return 1.0 - 0.5 * ((s + 1.0) * f - s) * f * f
  }
}

public func WYTimingFunctionExtremeBackEaseIn(_ t: CGFloat) -> CGFloat {
  return (t * t - sin(t * π)) * t
}

public func WYTimingFunctionExtremeBackEaseOut(_ t: CGFloat) -> CGFloat {
  let f = 1.0 - t
  return 1.0 - (f * f - sin(f * π)) * f
}

public func WYTimingFunctionExtremeBackEaseInOut(_ t: CGFloat) -> CGFloat {
  if t < 0.5 {
    let f = 2.0 * t
    return 0.5 * (f * f - sin(f * π)) * f
  } else {
    let f = 2.0 * (1.0 - t)
    return 1.0 - 0.5 * (f * f - sin(f * π)) * f
  }
}

public func WYTimingFunctionBounceEaseIn(_ t: CGFloat) -> CGFloat {
  return 1.0 - WYTimingFunctionBounceEaseOut(1.0 - t)
}

public func WYTimingFunctionBounceEaseOut(_ t: CGFloat) -> CGFloat {
  if t < 1.0 / 2.75 {
    return 7.5625 * t * t
  } else if t < 2.0 / 2.75 {
    let f = t - 1.5 / 2.75
    return 7.5625 * f * f + 0.75
  } else if t < 2.5 / 2.75 {
    let f = t - 2.25 / 2.75
    return 7.5625 * f * f + 0.9375
  } else {
    let f = t - 2.625 / 2.75
    return 7.5625 * f * f + 0.984375
  }
}

public func WYTimingFunctionBounceEaseInOut(_ t: CGFloat) -> CGFloat {
  if t < 0.5 {
    return 0.5 * WYTimingFunctionBounceEaseIn(t * 2.0)
  } else {
    return 0.5 * WYTimingFunctionBounceEaseOut(t * 2.0 - 1.0) + 0.5
  }
}

public func WYTimingFunctionSmoothstep(_ t: CGFloat) -> CGFloat {
  return t * t * (3 - 2 * t)
}

public func WYCreateShakeFunction(_ oscillations: Int) -> (CGFloat) -> CGFloat {
  return {t in -pow(2.0, -10.0 * t) * sin(t * π * CGFloat(oscillations) * 2.0) + 1.0}
}
