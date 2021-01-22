//
//  MatchTransitionAnimator.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimovon 10/15/20.
//

import UIKit

class MatchTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var isPresenting: Bool = true
    
    private let duration: TimeInterval = 1
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.isPresenting {
            self.present(using: transitionContext)
        } else {
            self.dismiss(using: transitionContext)
        }
    }
    
    private func present(using transitionContext: UIViewControllerContextTransitioning) {
        let conteinerView =  transitionContext.containerView
        
        guard let presentingController = transitionContext.viewController(forKey: .from),
              let presentingView = transitionContext.view(forKey: .from),
              let headerPresentingView = presentingView.viewWithTag(11),
              let logoPresentingView = presentingView.viewWithTag(22),
              let sharePresentingView = presentingView.viewWithTag(33) else {
            transitionContext.completeTransition(false)
            return
        }
        
        guard let presentedController = transitionContext.viewController(forKey: .to),
              let presentedView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        guard let sublayers = headerPresentingView.layer.sublayers,
              let gradientLayer = sublayers.first else {
            transitionContext.completeTransition(false)
            return
        }
        
        conteinerView.insertSubview(presentedView, aboveSubview: presentingView)
        presentedView.alpha = 0
        headerPresentingView.layer.masksToBounds = false
        
        let topViewsOffset = headerPresentingView.convert(headerPresentingView.bounds, to: presentingView).origin.y
        presentingController.navigationController?.view.frame = CGRect(
            x: 0, y: 0,
            width: presentingView.frame.width,
            height: presentingView.frame.height + topViewsOffset)
        
        UIView.animate(withDuration: 0.3) {
            presentingController.navigationController?.view.transform =
                CGAffineTransform(translationX: 0, y: -(topViewsOffset))
            
            sharePresentingView.alpha = 0
            logoPresentingView.alpha = 0
            
            UIView.animate(withDuration: 0.5) {
                gradientLayer.transform = CATransform3DMakeScale(1.1, 1, 1)
            }
        } completion: { (finished) in
            
            presentedView.transform = CGAffineTransform(translationX: 0, y: topViewsOffset)
            UIView.animate(withDuration: 0.5) {
                presentedView.alpha = 1
            } completion: { (finished) in
                presentingController.navigationController?.view.transform = .identity
                presentingController.navigationController?.view.frame = CGRect(
                    x: 0, y: 0,
                    width: presentingView.frame.width,
                    height: presentingView.frame.height - topViewsOffset)
                headerPresentingView.layer.masksToBounds = true
                gradientLayer.transform = CATransform3DIdentity
                sharePresentingView.alpha = 1
                logoPresentingView.alpha = 1
                transitionContext.completeTransition(finished)
            }
        }

        
        /*conteinerView.insertSubview(presentedView, aboveSubview: presentingView)
        presentedView.alpha = 0
        
        UIView.animate(withDuration: self.duration) {
            presentedView.alpha = 1
            headerPresentingView.transform = CGAffineTransform(
                scaleX: 1.15, y: 1.15).translatedBy(x: 0, y: -100)
            logoPresentingView.transform = CGAffineTransform(translationX: 200, y: -100)
        } completion: { (finished) in
            headerPresentingView.transform = .identity
            logoPresentingView.transform = .identity
            transitionContext.completeTransition(finished)
        }*/
    }
    
    private func dismiss(using transitionContext: UIViewControllerContextTransitioning) {
        let conteinerView =  transitionContext.containerView
        
        guard let dismissedView = transitionContext.view(forKey: .from),
              let headerDissmisedView = dismissedView.viewWithTag(1) else {
            transitionContext.completeTransition(false)
            return
        }
        
        guard let logoDissmisedView = transitionContext.viewController(forKey: .from)?
                .navigationController?.navigationBar.viewWithTag(22) else {
            transitionContext.completeTransition(false)
            return
        }
        
        guard let presentedView = transitionContext.view(forKey: .to),
              let headerPresentedView = presentedView.viewWithTag(1) else {
            transitionContext.completeTransition(false)
            return
        }

        conteinerView.addSubview(presentedView)
        presentedView.alpha = 0
        headerDissmisedView.layer.cornerRadius = 20
        
        UIView.animate(withDuration: self.duration) {
            presentedView.alpha = 1
            headerDissmisedView.transform =
                CGAffineTransform(scaleX: 0.9, y: 0.85)
                .translatedBy(x: 0, y: headerPresentedView.center.y)
            logoDissmisedView.transform = CGAffineTransform(translationX: -200, y: 200)
        } completion: { (finished) in
            headerDissmisedView.transform = .identity
            logoDissmisedView.transform = .identity
            headerDissmisedView.layer.cornerRadius = 0
            transitionContext.completeTransition(finished)
        }
        
    }
    
}
