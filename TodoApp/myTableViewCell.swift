//
//  myTableViewCell.swift
//  TodoApp
//
//  Created by t2023-m0078 on 2023/08/01.
//

import Foundation
import UIKit

class myTableViewCell: UITableViewCell {
    
    @IBOutlet weak var check: UILabel!
    
    @IBOutlet weak var checkBox: UIView!
    
    @IBOutlet weak var userTitle: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var userContent: UILabel!
            
    override class func awakeFromNib() {
        super.awakeFromNib()
                
    }
}
