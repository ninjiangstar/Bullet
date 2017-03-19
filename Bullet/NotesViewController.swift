//
//  NotesViewController.swift
//  Bullet
//
//  Created by Andrew Jiang on 3/17/17.
//  Copyright © 2017 Andrew Jiang. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UIGestureRecognizerDelegate {

    var page: Page?
    var containerController: NotesTableViewController?
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var containerView: UIView!

    @IBAction func infoButton(_ sender: Any) {
    
    }
    
    var tapBarViewGestureRecognizer: UITapGestureRecognizer?
    var panViewGestureRecognizer: UIPanGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        primaryLabel.text = page?.title
        primaryLabel.font = primaryLabel.font.withSize(15)
        secondaryLabel.text = page?.subtitle
        secondaryLabel.font = secondaryLabel.font.withSize(12)
    
        tapBarViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapBarViewGesture))
        panViewGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panViewGesture))
        panViewGestureRecognizer!.delegate = self
        
        barView.addGestureRecognizer(tapBarViewGestureRecognizer!)
        self.view.addGestureRecognizer(panViewGestureRecognizer!)
    }
    
    func handleTapBarViewGesture(_ recognizer: UITapGestureRecognizer) {
        print("HEY")
    }
    
    func panViewGesture(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .changed {
            if let controller = containerController {
                if controller.isDraggingDownAtTop {
                    print("SEGUE THAT SHIT")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "notesTableViewEmbed" {
            if segue.destination is NotesTableViewController {
                let controller = segue.destination as! NotesTableViewController
                controller.page = self.page
                self.containerController = controller
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
