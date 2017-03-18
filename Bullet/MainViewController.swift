//
//  ViewController.swift
//  Bullet
//
//  Created by Andrew Jiang on 3/17/17.
//  Copyright © 2017 Andrew Jiang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let notesPageViewController: NotesPageViewController = NotesPageViewController()
    let carouselPageViewController: CarouselPageViewController = CarouselPageViewController()
    let archiveTableViewController: ArchiveTableViewController = ArchiveTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        performSegue(withIdentifier: "mainToNotes", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

