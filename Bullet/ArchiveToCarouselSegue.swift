//
//  ArchiveToCarouselSegue.swift
//  Bullet
//
//  Created by Andrew Jiang on 3/18/17.
//  Copyright © 2017 Andrew Jiang. All rights reserved.
//

import UIKit

class ArchiveToCarouselSegue: UIStoryboardSegue {

    override func perform() {
        // perform segue without stacking
        // http://stackoverflow.com/questions/20108587/bi-directional-storyboard-travel-without-stacking
        if let parent = source.parent {
            parent.addChildViewController(destination)
            destination.view.frame = parent.view.bounds
            
            source.willMove(toParentViewController: nil)
            parent.transition(from: source, to: destination, duration: 0.6, options: .transitionCrossDissolve, animations: nil, completion: { finished in
                self.source.removeFromParentViewController()
                self.destination.didMove(toParentViewController: parent)
                self.constrainView(self.destination.view, equalTo: parent.view)
            })
        }
    }
    
    /// constrains child view to parent view
    func constrainView(_ childView: UIView, equalTo parentView: UIView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        let constrainCenterX = NSLayoutConstraint(item: childView, attribute: .centerX, relatedBy: .equal, toItem: parentView, attribute: .centerX, multiplier: 1, constant: 0)
        let constrainCenterY = NSLayoutConstraint(item: childView, attribute: .centerY, relatedBy: .equal, toItem: parentView, attribute: .centerY, multiplier: 1, constant: 0)
        let constrainWidth = NSLayoutConstraint(item: childView, attribute: .width, relatedBy: .equal, toItem: parentView, attribute: .width, multiplier: 1, constant: 0)
        let constrainHeight = NSLayoutConstraint(item: childView, attribute: .height, relatedBy: .equal, toItem: parentView, attribute: .height, multiplier: 1, constant: 0)
        
        parentView.addConstraints([constrainCenterX, constrainCenterY, constrainWidth, constrainHeight])
    }
    
}
