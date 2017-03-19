//
//  NotesTableCell.swift
//  Bullet
//
//  Created by Andrew Jiang on 3/18/17.
//  Copyright © 2017 Andrew Jiang. All rights reserved.
//

import UIKit

class NotesTableCell: UITableViewCell, UITextViewDelegate {

    private var _entry: Entry?
    var tableViewController: NotesTableViewController?
    @IBOutlet weak var notesTextView: UITextView!
    
    var entry: Entry? {
        set {
            attachModel(newValue)
        }
        get {
            return _entry
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        notesTextView.delegate = self
        notesTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        notesTextView.font = notesTextView.font?.withSize(18)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func attachModel(_ entry: Entry?) {
        self._entry = entry
        notesTextView.text = entry?.text
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // calculate if the text view will change height
        let initialHeight = textView.frame.size.height
        let calculatedHeight = textView.sizeThatFits(textView.frame.size).height
        
        if initialHeight != calculatedHeight {
            // disables and then enables animations to prevent unexpected visual behavior
            UIView.setAnimationsEnabled(false)
            
            self.tableViewController?.tableView.beginUpdates()
            self.tableViewController?.tableView.endUpdates()
            
            // todo: modify scrolling logic
            
            UIView.setAnimationsEnabled(true)
        }
        
        // modify model
        entry?.text = notesTextView.text
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "" {
            if range.length == 0 {
                tableViewController?.removeRowAt(self)
                return false
            }
        } else if text == "\n" {
            tableViewController?.insertRowAfter(self)
            return false
        }
        return true
    }

}
