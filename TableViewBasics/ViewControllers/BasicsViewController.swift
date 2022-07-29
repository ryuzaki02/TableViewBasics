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
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = "MovieTableViewCell"
    private let addNewViewControllerIdentifier = "AddNewMoviewViewController"
    lazy var viewModel = MovieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = true
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        if identifier == addNewViewControllerIdentifier {
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

extension BasicsViewController: UITableViewDelegate {
    
}

extension BasicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.movies[indexPath.row].movieName
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        let movedObject = viewModel.movies[sourceIndexPath.row]
        viewModel.movies.remove(at: sourceIndexPath.row)
        viewModel.movies.insert(movedObject, at: destinationIndexPath.row)
    }
}

extension BasicsViewController: NewMovieAddedProtocol {
    func newMovieAdded(newMovie: Movie) {
        viewModel.addMovie(movie: newMovie)
        tableView.reloadData()
    }
}

