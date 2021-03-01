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
  var dismissCompletion: (() -> Void)?

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView
    let herbView = presenting ?
      transitionContext.view(forKey: .to)! :
      transitionContext.view(forKey: .from)!

    let initialFrame = presenting ? originFrame : herbView.frame
    let finalFrame = presenting ? herbView.frame : originFrame
    let xScaleFactor = presenting ?
      initialFrame.width / finalFrame.width :
      finalFrame.width / initialFrame.width
    let yScaleFactor = presenting ?
      initialFrame.height / finalFrame.height :
      finalFrame.height / initialFrame.height

    let scaleTransform = CGAffineTransform(scaleX: xScaleFactor,
                                           y: yScaleFactor)
    if presenting {
      herbView.transform = scaleTransform
      herbView.center = CGPoint(x: initialFrame.midX,
                                y: initialFrame.midY)
      herbView.clipsToBounds = true
    }

    if let toView = transitionContext.view(forKey: .to) {
      containerView.addSubview(toView)
    }
    containerView.bringSubviewToFront(herbView)
    UIView.animate(withDuration: duration,
                   delay: 0.0,
                   usingSpringWithDamping: 0.4,
                   initialSpringVelocity: 0.0,
                   animations: {
                    herbView.transform = self.presenting ?
                                        CGAffineTransform.identity :
                                        scaleTransform
                    herbView.center = CGPoint(x: finalFrame.midX,
                                              y:finalFrame.midY)
                    }, completion: { _ in
                        transitionContext.completeTransition(true)
                        if !self.presenting {
                          self.dismissCompletion?()
                        }
                      })

  }


//fade in transition
//  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//    let containerView = transitionContext.containerView
//    let toView = transitionContext.view(forKey: .to)!
//
//    containerView.addSubview(toView)
//    toView.alpha = 0.0
//    UIView.animate(withDuration: duration,
//      animations: {
//        toView.alpha = 1.0
//      },
//      completion: { _ in
//        transitionContext.completeTransition(true)
//      }
//    )
//  }
}
