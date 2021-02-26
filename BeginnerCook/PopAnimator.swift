//
//  PopAnimator.swift
//  BeginnerCook
//
//  Created by Lucas Pedrazoli on 26/02/21.
//  Copyright © 2021 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit

class PopAnimator: NSObject,
UIViewControllerAnimatedTransitioning {

  let duration = 1.0
  var presenting = true
  var originFrame = CGRect.zero

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView
    let toView = transitionContext.view(forKey: .to)!

    containerView.addSubview(toView)
    toView.alpha = 0.0
    UIView.animate(withDuration: duration,
      animations: {
        toView.alpha = 1.0
      },
      completion: { _ in
        transitionContext.completeTransition(true)
      }
    )
  }
}
