//
//  Animation+SharedElementTransition.swift
//  elmenus
//
//  Created by Ahmed Madian on 2/22/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import XCoordinator

extension Animation {
    static let sharedElementTransition = Animation(presentation: SharedElementTransitionAnimation.shared, dismissal: SharedElementTransitionAnimation.shared)
}


class SharedElementTransitionAnimation : NSObject, TransitionAnimation {
    var interactionController: PercentDrivenInteractionController?
    
    static var shared = SharedElementTransitionAnimation()
    
    var presenting = false
    
    func start() {
        
    }
    
    func cleanup() {
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        
        if presenting {
            let toView = toViewController.view!
            containerView.addSubview(toView)
            toView.isHidden = true
            
            let homeViewController = toViewController as! NTTransitionHomeViewProtocol
            let homeViewTableView = (toViewController as! NTTransitionHomeViewProtocol).transitionTableView()
            
            homeViewTableView.layoutIfNeeded()
            let indexPath = homeViewController.latestSelectedIndex()
            let listView = homeViewTableView.cellForRow(at: indexPath)
            let leftUpperPoint = listView!.convert(CGPoint(x: 0, y: 0), to: toViewController.view)
            
            listView?.isHidden = true
            
            let snapShot = (listView as! NTTansitionSnapShotProvidorProtocol).snapShotForTransition()
            snapShot.origin(point: CGPoint(x: 8, y: 9+64))
            
            containerView.addSubview(snapShot)
            
            toView.isHidden = false
            
            let whiteViewContainer = UIView(frame: screenBounds)
            whiteViewContainer.backgroundColor = UIColor.white
            containerView.addSubview(snapShot)
            containerView.insertSubview(whiteViewContainer, belowSubview: toView)
            
            UIView.animate(withDuration: animationDuration, animations: {
                snapShot.transform = CGAffineTransform.identity
                snapShot.frame = CGRect(x: leftUpperPoint.x, y: leftUpperPoint.y, width: snapShot.frame.size.width, height: snapShot.frame.size.height)
            }, completion:{finished in
                if finished {
                    listView?.isHidden = false
                    snapShot.removeFromSuperview()
                    whiteViewContainer.removeFromSuperview()
                    transitionContext.completeTransition(true)
                }
            })
            
            self.presenting = false
        }
        else {
            
            let fromView = fromViewController.view
            let toView = toViewController.view
            
            let homeViewController = fromViewController as! NTTransitionHomeViewProtocol
            let homeTableView : UITableView = (fromViewController as! NTTransitionHomeViewProtocol).transitionTableView()
            
            containerView.backgroundColor = UIColor.white
            containerView.addSubview(fromView!)
            containerView.addSubview(toView!)
            
            let cellView = homeTableView.cellForRow(at: homeViewController.latestSelectedIndex())
            
            cellView?.isHidden = true
            
            let leftUpperPoint = cellView!.convert(CGPoint(x: 0, y: 0), to: nil)
            toView?.isHidden = true
            
            let snapShot = (cellView as! NTTansitionSnapShotProvidorProtocol).snapShotForTransition()
            containerView.addSubview(snapShot)
            
            snapShot.origin(point: leftUpperPoint)
            
            UIView.animate(withDuration: animationDuration, animations: {
                snapShot.transform = CGAffineTransform.identity
                snapShot.frame = CGRect(x: 0, y: 0, width: snapShotWidth, height: snapShotHeight)
                
                fromView?.alpha = 1
                
            },completion:{finished in
                if finished {
                    snapShot.removeFromSuperview()
                    toView?.isHidden = false
                    cellView?.isHidden = false
                    fromView?.transform = CGAffineTransform.identity
                    transitionContext.completeTransition(true)
                }
            })
            
            self.presenting = true
        }
        
    }
}


let screenBounds = UIScreen.main.bounds
let screenSize   = screenBounds.size
let screenWidth  = screenSize.width
let animationDuration = 0.45


let snapShotWidth = screenWidth
let snapShotHeight: CGFloat = 300

extension UIView{
    func origin (point : CGPoint){
        frame.origin.x = point.x
        frame.origin.y = point.y
    }
}
