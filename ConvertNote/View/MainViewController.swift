//
//  MainViewController.swift
//  ConvertNote
//
//  Created by Yashom on 02/10/24.
//

import UIKit
protocol MainViewProtocol: AnyObject{
    var presenter: MainPresenterProtocol? { get set }
    func showNotes()                       // Reload the tableView or update UI to display notes
    func showNoNotesLabel(_ show: Bool)    // Show or hide the "No notes yet" label
    func navigateToNoteDetail(noteId: String, noteCell: NoteCell?) // Navigate to the note detail screen
    
}

import UIKit

class MainViewController: UIViewController, MainViewProtocol {
    var presenter: MainPresenterProtocol?
    
    var searchController = UISearchController(searchResultsController: nil)
    var tableView: UITableView?
    let label = UILabel()
    let button = AddButton()
    
    // Computed property to determine if the user is currently searching
        private var isSearching: Bool {
            return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupSearchController()
        setupNavigationController()
        setupTableView()
        setupButton()
        setupLabel()
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            // Reload notes every time the view appears
            presenter?.refreshNotes()  // Ensure the presenter reloads the latest notes
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
    }
    
    private func setupButton() {
        view.addSubview(button)
        button.setButtonConstraints(view: view)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func setupLabel() {
        view.addSubview(label)
        label.text = "  "
        label.font = .systemFont(ofSize: 20)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 30),
            label.widthAnchor.constraint(equalToConstant: 120),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNavigationController() {
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    func showNotes() {
        tableView?.reloadData()
    }
    
    func showNoNotesLabel(_ show: Bool) {
        label.isHidden = !show
    }
    
    @objc private func didTapButton() {
        presenter?.didTapAddButton()
    }
    
    func navigateToNoteDetail(noteId: String, noteCell: NoteCell?) {
        // Use the router to create and configure the NoteViewController
        let noteVC = NoteRouter.createNoteModule(noteId: noteId, noteCell: noteCell)
        navigationController?.pushViewController(noteVC, animated: true)
    }

}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        presenter?.searchNotes(text: text)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        let tableView = UITableView(frame: .zero)
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.id)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.separatorColor = .systemGray3
        self.tableView = tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter?.numberOfRows(isSearching: isSearching))!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.id, for: indexPath) as? NoteCell else {
            return UITableViewCell()
        }
        presenter?.configureCell(cell: cell, index: indexPath.row, isSearching: isSearching)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Get the selected NoteCell
            guard let noteCell = tableView.cellForRow(at: indexPath) as? NoteCell else {
                return
            }

            // Pass the index and the selected noteCell to the presenter
        presenter?.didSelectNoteAt(index: indexPath.row, isSearching: isSearching, noteCell: noteCell)
        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                    presenter?.deleteNoteAt(index: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
    }
}

