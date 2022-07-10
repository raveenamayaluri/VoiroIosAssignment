//
//  MovieDetailViewController.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 08/07/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieId:Int!
    
    private var viewModel = MovieDetailViewModel()
    private var spinner = SpinnerViewController()
    
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
        self.title = "Movie Details"
        viewModel.delegate = self
        
        showLoading()
        viewModel.getMovieDetails(movieId: movieId)
    }
    
    func setMovieDetails() {
        
        guard let selectedMovie = viewModel.getSelectedMovieDetail() else {
            return
        }
        durationTimeLabel.text =  viewModel.getMovieRunTime(runTime: selectedMovie.runtime)
        releaseDate.text = viewModel.getFormattedDateFromString(dateString: selectedMovie.releaseDate)
        movieTile.text = selectedMovie.title
        movieImage.sd_setImage(with: URL(string: Strings.APIConstants.TMDB_IMAGE_BASE_URL+selectedMovie.backdropPath),placeholderImage: UIImage(named: "Movie_placeholder.png"))
        genresLabel.text = viewModel.getMovieGenres(genres: selectedMovie.genres)
        ratingLabel.text = "\(selectedMovie.voteAverage) & \(selectedMovie.voteCount) votes"
        languageLabel.text = viewModel.getMovieLanguages(spokenLanguages: selectedMovie.spokenLanguages)
        aboutLabel.text = selectedMovie.overview
        castLabel.text = viewModel.getMovieCasts(cast: selectedMovie.credits.cast)
    }
}

extension MovieDetailViewController:MovieDetailViewModelProtocol{
    
    func didRecieveMovies() {
        DispatchQueue.main.async {
            self.hideLoading()
            self.setMovieDetails()
        }
    }
    
    func didRecieveError(message: String) {
        DispatchQueue.main.async {
            self.hideLoading()
            Alert.present(title: "Alert", message: message, from: self)
        }
    }
}

extension MovieDetailViewController: SpinnerProtocl {
    
    func showLoading() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    
    func hideLoading() {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
}
