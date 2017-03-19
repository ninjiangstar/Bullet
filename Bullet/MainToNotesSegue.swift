//
//  MainToNotesSegue.swift
//  Bullet
//
//  Created by Andrew Jiang on 3/18/17.
//  Copyright © 2017 Andrew Jiang. All rights reserved.
//

import UIKit

class MainToNotesSegue: UIStoryboardSegue {
 
    override func perform() {
        
        UIView.transition(from: source.view, to: destination.view, duration: 0.3, options: .transitionCrossDissolve) { (finished) in
            self.source.present(self.destination, animated: false, completion: nil)
        }
    }
    
}
