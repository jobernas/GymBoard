//
//  GymTableViewCell.swift
//  GymBoard
//
//  Created by João Luís on 07/03/17.
//  Copyright © 2017 JoBernas. All rights reserved.
//

import UIKit

class GymTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelValue: UILabel!
    
    var entry: Entry? {
        didSet{
            updateUI()
        }
    }
    
    /**
     * Update View Cell UI
     */
    private func updateUI(){
        labelTitle?.text = "\(entry!.label)"
        labelValue?.text = "\(entry!.value) \(entry!.unit)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
