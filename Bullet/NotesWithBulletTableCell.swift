//
//  NotesWithBulletTableCell.swift
//  Bullet
//
//  Created by Andrew Jiang on 3/18/17.
//  Copyright © 2017 Andrew Jiang. All rights reserved.
//

import UIKit

class NotesWithBulletTableCell: NotesTableCell {

    @IBOutlet weak var bulletImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func attachModel(_ entry: Entry?) {
        super.attachModel(entry)
        
        
        bulletImageView.isHidden = false
        if let entry = entry {
            switch entry.type as Entry.EntryType {
            case .notes:
                bulletImageView.image = #imageLiteral(resourceName: "note")
                break
            case .task:
                bulletImageView.image = #imageLiteral(resourceName: "task")
                break
            case .completedTask:
                bulletImageView.image = #imageLiteral(resourceName: "completed")
                break
            case .event:
                bulletImageView.image = #imageLiteral(resourceName: "event")
            default:
                bulletImageView.isHidden = true
                break
            }
        }
    }
    
}
