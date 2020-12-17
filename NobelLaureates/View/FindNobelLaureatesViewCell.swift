//
//  FindNobelLaureatesViewCell.swift
//  NobelLaureates
//
//  Created by Surendra Patel on 17/12/20.
//

import UIKit

class FindNobelLaureatesViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var customView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
