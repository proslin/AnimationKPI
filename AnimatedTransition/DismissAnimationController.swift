//
//  DismissAnimationController.swift
//  AnimationKPI
//
//  Created by Lina Prosvetova on 19.02.2024.
//

import UIKit

class DismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    private let destinationFrame: CGRect
    let dismissDuration = 0.15
    
    init(destinationFrame: CGRect) {
        self.destinationFrame = destinationFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return dismissDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
          let toVC = transitionContext.viewController(forKey: .to),
          let snapshot = fromVC.view.snapshotView(afterScreenUpdates: true)
          else {
            return
        }

        let containerView = transitionContext.containerView
        containerView.addSubview(snapshot)
        fromVC.view.isHidden = true

        UIView.animate(withDuration: dismissDuration, delay: 0, options: .curveEaseOut, animations: {
            snapshot.frame = self.destinationFrame
//            snapshot.alpha = 0
        },
          completion: { _ in
            fromVC.view.isHidden = false
            snapshot.removeFromSuperview()
            if transitionContext.transitionWasCancelled {
              toVC.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    
}

