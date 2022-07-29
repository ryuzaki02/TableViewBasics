//
//  AddNewMoviewViewController.swift
//  TableViewBasics
//
//  Created by Aman on 28/07/22.
//

import UIKit

class AddNewMoviewViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    var delegate: NewMovieAddedProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self
    }
    
    convenience init(delegate: NewMovieAddedProtocol?) {
        self.init()
        self.delegate = delegate
    }
    
    //MARK: - Button Actions
    @IBAction func saveButtonAction(_ sender: UIButton!) {
        view.endEditing(true)
        if let movieName = textField.text {
            delegate?.newMovieAdded(newMovie: Movie(movieName: movieName))
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton!) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }

}

extension AddNewMoviewViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
