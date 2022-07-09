//
//  MovieInfoViewController.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 08/07/22.
//

import UIKit

class MovieInfoViewController: UIViewController {

    var movieId:Int!
    private var viewModel = MovieInfoViewModel()

    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTile: UILabel!
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Movie Details"
        viewModel.delegate = self
        viewModel.getMovieDetails(movieId: movieId)
        // Do any additional setup after loading the view.
    }
    
    func setMovieDetails(selectedMovie:MovieDetails) {
        durationTimeLabel.text =  viewModel.getMovieRunTime(runTime: selectedMovie.runtime)
        releaseDate.text = selectedMovie.releaseDate
        movieTile.text = selectedMovie.title
        movieImage.sd_setImage(with: URL(string: ApiConstants.TMDB_IMAGE_BASE_URL+selectedMovie.backdropPath),placeholderImage: UIImage(named: "placeholder.png"))
        genresLabel.text = viewModel.getMovieGenres(genres: selectedMovie.genres)
        ratingLabel.text = "\(selectedMovie.voteAverage) & \(selectedMovie.voteCount) votes"
        languageLabel.text = viewModel.getMovieLanguages(spokenLanguages: selectedMovie.spokenLanguages)
        aboutLabel.text = selectedMovie.overview
        castLabel.text = viewModel.getMovieCasts(cast: selectedMovie.credits.cast)
    }
}

extension MovieInfoViewController:MovieInfoViewModelProtocol{
    func didRecieveMovieInfo(movieDetails: MovieDetails) {
        DispatchQueue.main.async {
            self.setMovieDetails(selectedMovie: movieDetails)
        }
    }
    
    func didRecieveError(message: String) {
        
    }
    
    
}
