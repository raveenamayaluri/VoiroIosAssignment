//
//  Alert.swift
//  VoiroMovieIosAssignment
//
//  Created by Raveena on 09/07/22.
//
import UIKit

struct Alert {
    static func present(title: String?, message: String, from controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // making a "ok" acton button
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("ok button pressed")
        }
        alertController.addAction(okAction)
        
        // present the alert
        controller.present(alertController, animated: true, completion: nil)
    }
}
