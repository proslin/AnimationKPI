//
//  PresentAnimationController.swift
//  AnimationKPI
//
//  Created by Lina Prosvetova on 19.02.2024.
//

import UIKit

class PresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum ExpandTransitionMode: Int {
        case Present, Dismiss
    }
    let presentDuration = 0.4
    let dismissDuration = 0.15
    
    var openingFrame: CGRect
    
    var transitionMode: ExpandTransitionMode = .Present
    
    var topView: UIView!
    var bottomView: UIView!
    
    init(originFrame: CGRect) {
        self.openingFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if (transitionMode == .Present) {
            return presentDuration
        } else {
            return dismissDuration
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let snapshot = toViewController.view.snapshotView(afterScreenUpdates: true) else { return }
        
        let containerView = transitionContext.containerView
        snapshot.frame = openingFrame
//        snapshot.alpha = 0.0
        containerView.addSubview(toViewController.view)
        containerView.addSubview(snapshot)
        toViewController.view?.isHidden = true
        
        UIView.animate(withDuration: presentDuration, animations: {
            snapshot.frame = (transitionContext.finalFrame(for: toViewController))
//            snapshot.alpha = 1.0
        }, completion: { _ in
            toViewController.view.isHidden = false
            snapshot.removeFromSuperview()
            if transitionContext.transitionWasCancelled {
                toViewController.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
