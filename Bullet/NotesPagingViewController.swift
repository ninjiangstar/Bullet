//
//  NotesPagingViewController.swift
//  Bullet
//
//  Created by Andrew Jiang on 3/18/17.
//  Copyright © 2017 Andrew Jiang. All rights reserved.
//

import UIKit

class NotesPagingViewController: UIViewController, UIGestureRecognizerDelegate {

    // this is a custom NotesPageView implementation based on:
    // http://www.tothenew.com/blog/paging-with-uiscreenedgepangesturerecognizer/
    
    enum Direction {
        case left
        case right
    }
    
    let notesStoryboard: UIStoryboard! = UIStoryboard(name: "Notes", bundle: nil)
    
    var centerNotesViewController: NotesViewController?
    var leftNotesViewController: NotesViewController?
    var rightNotesViewController: NotesViewController?
    
    var leftEdgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer?
    var rightEdgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        addGestureRecognizers()
        centerNotesViewController = createViewController(getPageModel())
        addChildViewController(centerNotesViewController!)
        self.view.addSubview(centerNotesViewController!.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addGestureRecognizers() {
        leftEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleLeftEdgePan))
        leftEdgePanGestureRecognizer!.edges = .left
        leftEdgePanGestureRecognizer!.delegate = self
        view.addGestureRecognizer(leftEdgePanGestureRecognizer!)
        
        rightEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleRightEdgePan))
        rightEdgePanGestureRecognizer!.edges = .right
        rightEdgePanGestureRecognizer!.delegate = self
        view.addGestureRecognizer(rightEdgePanGestureRecognizer!)
    }
    
    func handleLeftEdgePan(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        let translation: CGPoint = recognizer.translation(in: recognizer.view)
        
        switch recognizer.state {
        case .began: return edgePanGestureBegan(direction: .left, translation: translation, with: recognizer)
        case .changed: return edgePanGestureChanged(direction: .left, translation: translation, with: recognizer)
        case .ended: return edgePanGestureEnded(direction: .left, translation: translation, with: recognizer)
        default: break
        }
    }
    
    func handleRightEdgePan(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        let translation: CGPoint = recognizer.translation(in: recognizer.view)
        
        switch recognizer.state {
        case .began: return edgePanGestureBegan(direction: .right, translation: translation, with: recognizer)
        case .changed: return edgePanGestureChanged(direction: .right, translation: translation, with: recognizer)
        case .ended: return edgePanGestureEnded(direction: .right, translation: translation, with: recognizer)
        default: break
        }
    }
    
    private func edgePanGestureBegan(direction: Direction, translation: CGPoint, with recognizer: UIScreenEdgePanGestureRecognizer) {
        
        let otherNotesViewController = createViewController(getPageModel())
        addChildViewController(otherNotesViewController)
        let otherNotesView = otherNotesViewController.view!
        view.addSubview(otherNotesViewController.view)
        otherNotesView.isUserInteractionEnabled = false
        self.view.isUserInteractionEnabled = false
        
        // create shadow
        otherNotesView.layer.masksToBounds = false
        otherNotesView.layer.shadowColor = UIColor.black.cgColor
        otherNotesView.layer.shadowOffset = CGSize(width: 0, height: 0)
        otherNotesView.layer.shadowRadius = 8
        otherNotesView.layer.shadowOpacity = 0.05;
        otherNotesView.layer.shadowPath = UIBezierPath(rect: otherNotesView.bounds).cgPath
        
        // save temporarily
        switch direction {
        case .left:
            leftNotesViewController = otherNotesViewController
            break
        case .right:
            rightNotesViewController = otherNotesViewController
            break
        }
    }
    
    private func edgePanGestureChanged(direction: Direction, translation: CGPoint, with recognizer: UIScreenEdgePanGestureRecognizer) {
        let centerNotesView = centerNotesViewController!.view!
        let otherNotesView = direction == .left ? leftNotesViewController!.view! : rightNotesViewController!.view!
        let multiplier: CGFloat = direction == .left ? 1.0 : -1.0
        
        let translationPercent = translation.x / centerNotesView.frame.width * multiplier
        if translationPercent > 0 {
            centerNotesView.frame.origin.x = translation.x / 3
            otherNotesView.frame.origin.x = -multiplier * otherNotesView.frame.width + translation.x
            otherNotesView.layer.shadowOpacity = Float(translationPercent / 2) + Float(0.05)
        }
    }
 
    private func edgePanGestureEnded(direction: Direction, translation: CGPoint, with recognizer: UIScreenEdgePanGestureRecognizer) {
        let centerNotesView = centerNotesViewController!.view!
        let otherNotesViewController = direction == .left ? leftNotesViewController! : rightNotesViewController!
        let otherNotesView = otherNotesViewController.view!
        let multiplier: CGFloat = direction == .left ? 1.0 : -1.0
        
        otherNotesView.isUserInteractionEnabled = true
        self.view.isUserInteractionEnabled = true

        let translationPercent = translation.x / centerNotesView.frame.width * multiplier
        let initialVelocity = recognizer.velocity(in: self.view).x * multiplier
        
        if translationPercent > 0.5 || initialVelocity > 1000 {
            // move forward
            animateTransition(animations: {
                centerNotesView.frame.origin.x = multiplier * centerNotesView.frame.width / 4
                otherNotesView.frame.origin.x = 0
                otherNotesView.layer.shadowOpacity = 0.55
            }, completion: { completed in
                // reset references
                centerNotesView.removeFromSuperview()
                self.centerNotesViewController!.removeFromParentViewController()
                self.centerNotesViewController = direction == .left ? self.leftNotesViewController : self.rightNotesViewController
                switch direction {
                case .left: self.leftNotesViewController = nil; break
                case .right: self.rightNotesViewController = nil; break
                }
            })
        } else {
            // move backwards
            animateTransition(animations: {
                centerNotesView.frame.origin.x = 0
                otherNotesView.frame.origin.x = -multiplier * otherNotesView.frame.width
                otherNotesView.layer.shadowOpacity = 0.05
            }, completion: { completed in
                // reset references
                otherNotesView.removeFromSuperview()
                otherNotesViewController.removeFromParentViewController()
                switch direction {
                case .left: self.leftNotesViewController = nil; break
                case .right: self.rightNotesViewController = nil; break
                }
            })
        }
    }
    
    private func animateTransition(animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: animations, completion: completion)
    }
 
    private func getPageModel() -> Page {
        let entry1 = Entry(type: .paragraph, text: "hello world")
        let entry2 = Entry(type: .notes, text: "another hello world")
        let entry3 = Entry(type: .task, text: "another hello world")
        let page = Page()
        page.entries = [entry1, entry2, entry3]
        return page
    }
    
    private func createViewController(_ page: Page) -> NotesViewController {
        let notesViewController = notesStoryboard.instantiateInitialViewController() as! NotesViewController
        notesViewController.page = page
        return notesViewController
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
