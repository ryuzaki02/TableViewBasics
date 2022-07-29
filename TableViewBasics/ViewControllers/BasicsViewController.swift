//
//  BasicsViewController.swift
//  TableViewBasics
//
//  Created by Aman on 28/07/22.
//

import UIKit

protocol NewMovieAddedProtocol {
    func newMovieAdded(newMovie: Movie)
}

class BasicsViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!

    // Identifiers for cell and controllers
    private let cellIdentifier = "MovieTableViewCell"
    private let addNewViewControllerIdentifier = "AddNewMoviewViewController"
    // Lazy view model object, initalise when in use
    lazy var viewModel = MovieViewModel()
    
    //MARK: - Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //table view initialisation
        tableView.dataSource = self
        tableView.isEditing = true
    }
    
    //MARK: - Segue methods
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        if identifier == addNewViewControllerIdentifier {
            // Initialise Add new moview view controller
            // Set delegate to self to get call backs
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: addNewViewControllerIdentifier) as! AddNewMoviewViewController
            vc.delegate = self
            present(vc, animated: true, completion: nil)
        }
    }
    
    //MARK: - Button Actions
    @IBAction func plusButtonAction(_ sender: UIButton!) {
        performSegue(withIdentifier: addNewViewControllerIdentifier, sender: nil)
    }
}

extension BasicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Returns number of cells as movies
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Setup cell with particular movie name
        // Set text label to movie name
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.movies[indexPath.row].movieName
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Remove movie after drag
        viewModel.movies.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Move cell to drag and drop as per user action
        let movedObject = viewModel.movies[sourceIndexPath.row]
        // Remove cell from the initial position
        viewModel.movies.remove(at: sourceIndexPath.row)
        // Insert cell to the position selected
        viewModel.movies.insert(movedObject, at: destinationIndexPath.row)
    }
}

extension BasicsViewController: NewMovieAddedProtocol {
    // This function called when new movie added from Add New movie controller
    // Parameters: newMovie - a type of Movie Object
    func newMovieAdded(newMovie: Movie) {
        viewModel.addMovie(movie: newMovie)
        tableView.reloadData()
    }
}

