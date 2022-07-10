//
//  MoviesListTableViewCell.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 08/07/22.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var MovieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
