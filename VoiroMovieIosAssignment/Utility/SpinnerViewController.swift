//
//  SpinnerViewController.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 10/07/22.
//

import UIKit

protocol SpinnerProtocl {
    func showLoading()
    func hideLoading()
}

class SpinnerViewController: UIViewController {
    
    var spinner = UIActivityIndicatorView.init(style: .large)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        spinner.color = .white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
