//
//  BaseWorkoutCell.swift
//  Workout
//
//  Created by Рустам Амирханов on 04.04.2020.
//  Copyright © 2020 IDOLE. All rights reserved.
//

import UIKit

class BaseWorkoutCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
}
