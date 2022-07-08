//
//  ViewController.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 08/07/22.
//

import UIKit
import Foundation

class MoviesListViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
}

