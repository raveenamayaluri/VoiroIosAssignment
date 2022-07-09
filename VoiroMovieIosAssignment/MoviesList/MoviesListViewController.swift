//
//  ViewController.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 08/07/22.
//

import UIKit
import Foundation
import SDWebImage

class MoviesListViewController: UIViewController,UISearchBarDelegate {
    private var viewModel = MoviesListViewModel()
    private var movieListDataSource : MoviesListTableviewDatasource<MoviesListTableViewCell,Movie>!
  
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getNowPlayingMoviesList()
        searchBar.delegate = self
        updateTableviewData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.text = ""
        searchBar.becomeFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {    viewModel.filteredMovies(searchText)
        updateTableviewData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // hides the keyboard.
        
    }
    func updateTableviewData(){
        movieListDataSource = MoviesListTableviewDatasource(cellIdentifier: "MoviesListTableViewCell", items:viewModel.getMoviesList() , configureCell: {(cell ,movie) in
            cell.movieTitle.text = movie.originalTitle
            cell.ratingLabel.text = String(movie.voteAverage)
            cell.MovieImage.sd_setImage(with: URL(string: APIConstants.TMDB_IMAGE_BASE_URL+movie.backdropPath), placeholderImage: UIImage(named: "placeholder.png"))
        })
        self.tableView.dataSource = movieListDataSource
        self.tableView.reloadData()
    }
}
extension MoviesListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        MoveToMovieInformationController()
    }
    func MoveToMovieInformationController(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let newViewController = storyBoard.instantiateViewController(withIdentifier: "MovieInfoViewController") as? MovieInfoViewController else
        {
            fatalError("Restoration ID not found")
        }
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
extension MoviesListViewController: MovieViewModelProtocol {
   
    func didRecieveError(message: String) {
        
    }
    
    func didRecieveMovieInfo(movieInfo: MoviesInfo) {
        DispatchQueue.main.async {
            self.updateTableviewData()
        }
    }
}

