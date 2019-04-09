//
//  SetTableViewCell.swift
//  fitnesstracker
//
//  Created by Katie Wilcox on 4/9/19.
//  Copyright © 2019 Andi Cho. All rights reserved.
//

import UIKit

class SetTableViewCell: UITableViewCell {

    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    
    func setUpCell(set: Set){
        weightLabel.text = "\(set.weights) lbs"
        repsLabel.text = "\(set.reps) reps"

    }
    

}
