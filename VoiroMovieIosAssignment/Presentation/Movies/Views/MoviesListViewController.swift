//
//  MoviesListViewController.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 08/07/22.
//

import UIKit
import Foundation
import SDWebImage

class MoviesListViewController: UIViewController,UISearchBarDelegate {
    
    //MARK: Properties
    private var viewModel = MovieListViewModel()
    private var spinner: SpinnerViewController!
    private var movieListDataSource : MoviesListTableviewDatasource<MoviesListTableViewCell,Movie>!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        // Get Movies List from API service
        showLoading()
        viewModel.getNowPlayingMoviesList()
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTableviewData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filteredMovies(searchText)
        updateTableviewData()
    }
    
    func clearSearch(){
        viewModel.filteredMovies("")
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func updateTableviewData(){
        movieListDataSource = MoviesListTableviewDatasource(cellIdentifier: "MoviesListTableViewCell", items:viewModel.getMoviesList() , configureCell: {(cell ,movie) in
            cell.movieTitle.text = movie.originalTitle
            cell.ratingLabel.text = String(movie.voteAverage)
            cell.MovieImage.sd_setImage(with: URL(string: Strings.APIConstants.TMDB_IMAGE_BASE_URL+movie.backdropPath), placeholderImage: UIImage(named: "Movie_placeholder.png"))
        })
        self.tableView.dataSource = movieListDataSource
        self.tableView.reloadData()
    }
}

extension MoviesListViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let movie = viewModel.getMoviesList()[indexPath.row]
        clearSearch()
        MoveToMovieInformationController(movie)
    }
    
    private func MoveToMovieInformationController(_ movie:Movie){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else
        {
            fatalError("Restoration ID not found")
        }
        viewController.movieId = movie.id
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MoviesListViewController: MovieListViewModelProtocol {
    
    func didRecieveError(message: String) {
        DispatchQueue.main.async {
            self.showLoading()
            Alert.present(title: "Alert", message: message, from: self)
        }
    }
    
    func didRecieveMovieInfo() {
        DispatchQueue.main.async {
            self.hideLoading()
            self.updateTableviewData()
        }
    }
}

extension MoviesListViewController: SpinnerProtocl {
    func showLoading() {
        spinner = SpinnerViewController()
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

