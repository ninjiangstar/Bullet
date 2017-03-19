//
//  ViewController.swift
//  Bullet
//
//  Created by Andrew Jiang on 3/17/17.
//  Copyright © 2017 Andrew Jiang. All rights reserved.
//

import UIKit

class MainViewController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        switch operation {
//        case .push:
//            if toVC is NotesPagingViewController {
//                return NotesToCarouselAnimator()
//            }
//            break
//        case .pop:
//            if
//            break
//        default: break
//        }
//        return nil
    }

}

class MainToNotesAnimator : NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to)!
        let duration = transitionDuration(using: transitionContext)
        
        container.addSubview(fromVC.view)
        container.addSubview(toVC.view)
        
        UIView.transition(from: fromVC.view, to: toVC.view, duration: duration, options: .transitionCrossDissolve) { (finished) in
            transitionContext.completeTransition(true)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    
}

class NotesToCarouselAnimator : NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let container = transitionContext.containerView
//        let fromVC = transitionContext.viewController(forKey: .from)! as! NotesPagingViewController
//        let toVC = transitionContext.viewController(forKey: .to)!
//        let duration = transitionDuration(using: transitionContext)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
}

class CarouselToNotesAnimator : NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let container = transitionContext.containerView
//        let fromVC = transitionContext.viewController(forKey: .from)!
//        let toVC = transitionContext.viewController(forKey: .to)!
//        let duration = transitionDuration(using: transitionContext)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
}

