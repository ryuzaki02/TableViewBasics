//
//  AddNewMoviewViewController.swift
//  TableViewBasics
//
//  Created by Aman on 28/07/22.
//

import UIKit

class AddNewMoviewViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var textField: UITextField!
    // New movie added protocol object (optional)
    var delegate: NewMovieAddedProtocol?
    
    //MARK: - View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Initialisers
    
    // Convenience Init method just to pass delegate from other class
    convenience init(delegate: NewMovieAddedProtocol?) {
        self.init()
        self.delegate = delegate
    }
    
    //MARK: - Button Actions
    @IBAction func saveButtonAction(_ sender: UIButton!) {
        view.endEditing(true)
        // Check if textfield is not nil and not empty
        if let movieName = textField.text,
            !movieName.isEmpty {
            // Called delegate method to add new movie
            delegate?.newMovieAdded(newMovie: Movie(movieName: movieName))
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton!) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }

}
