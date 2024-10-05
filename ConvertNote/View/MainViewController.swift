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

class MainViewController: UIViewController, MainViewProtocol{
    var presenter: MainPresenterProtocol?
    
    var searchController = UISearchController(searchResultsController: nil)
    var tableView: UITableView?
    var collectionView: UICollectionView?
    let label = UILabel()
    let button = AddButton()
    
    var isGridView = false // Track the current view (grid or list)
    var isMenuOpen = false  // Track whether the side menu is open or not
    var sideMenuView: SideMenuView!
    
    // Computed property to determine if the user is currently searching
        private var isSearching: Bool {
            return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSearchController()
        setupNavigationController()
        setupToggleButton()
        setupSideMenu()
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
    
    
    
    private func showTableView() {
            collectionView?.removeFromSuperview()
            collectionView = nil
            setupTableView()
            tableView?.isHidden = false
            tableView?.reloadData()
            view.bringSubviewToFront(button)
        }
    
    private func showCollectionView() {
            tableView?.removeFromSuperview()
            tableView = nil
            setupCollectionView()
            collectionView?.isHidden = false
            collectionView?.reloadData()
            view.bringSubviewToFront(button)
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
        view.bringSubviewToFront(button)
    }
    
    @objc private func didTapButton() {
        presenter?.didTapAddButton()
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"),
                                                                   style: .plain,
                                                                   target: self,
                                                                   action: #selector(toggleMenu))
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func setupToggleButton() {
            let toggleButton = UIBarButtonItem(
                title: "Grid View", // Initial title
                style: .plain,
                target: self,
                action: #selector(didTapToggleButton)
            )
            navigationItem.rightBarButtonItem = toggleButton
        }
    
    @objc private func didTapToggleButton() {
            isGridView.toggle() // Toggle between list and grid view
            navigationItem.rightBarButtonItem?.title = isGridView ? "List View" : "Grid View"
            
            if isGridView {
                showCollectionView()
            } else {
                showTableView()
            }
        }
    
    private func setupSideMenu() {
        guard let window = UIApplication.shared.windows.first else { return }

        // Side Menu Initialization (off-screen)
        sideMenuView = SideMenuView(frame: CGRect(x: -250, y: 0, width: 250, height: window.frame.height))
        
        // Add side menu to the window (instead of the main view)
        window.addSubview(sideMenuView)
        
        // Configure button actions for side menu buttons
        sideMenuView.configureButtonActions(target: self, profileSelector: #selector(showProfileInfo), guideSelector: #selector(showGuide), aboutSelector: #selector(showAbout), logoutSelector: #selector(logout))
        
        setupTapGestureRecognizer()
    }

    
    func showNotes() {
        if isGridView {
            collectionView?.reloadData()
        }
        else {
            tableView?.reloadData()
        }
    }
    
    func showNoNotesLabel(_ show: Bool) {
        label.isHidden = !show
    }
    
    // Toggle the side menu visibility
    @objc private func toggleMenu() {
        isMenuOpen = !isMenuOpen
        let menuXPosition = isMenuOpen ? 0 : -250
        
        // Make sure the side menu is above everything, including the navigation bar
        view.bringSubviewToFront(sideMenuView)
        navigationController?.view.bringSubviewToFront(sideMenuView)  // Ensure sideMenuView is above navigation bar
        
        UIView.animate(withDuration: 0.3, animations: {
            self.sideMenuView.frame.origin.x = CGFloat(menuXPosition)
            self.view.layoutIfNeeded()  // Update the layout
        })
    }



        // Profile Info Action
        @objc private func showProfileInfo() {
            print("Profile Info Tapped")
            toggleMenu()  // Close menu after selection
        }

        // Guide Action
        @objc private func showGuide() {
            print("Guide Tapped")
            toggleMenu()  // Close menu after selection
        }

        // About Action
        @objc private func showAbout() {
            print("About Tapped")
            toggleMenu()  // Close menu after selection
        }

        // Log Out Action
        @objc private func logout() {
            print("Log Out Tapped")
            toggleMenu()  // Close menu after selection
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

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Setup CollectionView
        private func setupCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: view.frame.size.width / 2 - 16, height: 150)
            layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: NoteCollectionViewCell.id)
            collectionView.delegate = self
            collectionView.dataSource = self
            view.addSubview(collectionView)
            self.collectionView = collectionView
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
                collectionView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRows(isSearching: isSearching) ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionViewCell.id, for: indexPath) as? NoteCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let note = presenter?.getNoteAt(index: indexPath.row, isSearching: isSearching) {
                // Configure the cell with the note and pass the delete action
                cell.configure(note: note, deleteAction: { [weak self] in
                    // Handle delete action
                    self?.presenter?.deleteNoteAt(index: indexPath.row)
                    self?.collectionView?.reloadData()  // Reload the collection view after deletion
                })
            }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectNoteAt(index: indexPath.row, isSearching: isSearching, noteCell: nil)
    }
}

extension MainViewController: UIGestureRecognizerDelegate {

    func setupTapGestureRecognizer() {
        guard let window = UIApplication.shared.windows.first else { return }
        
        // Add gesture recognizer to detect taps outside the menu
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideMenu))
        tapGesture.cancelsTouchesInView = false  // Ensure table view can still receive taps
        tapGesture.delegate = self  // Set delegate to handle gesture behavior
        window.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTapOutsideMenu() {
        if isMenuOpen {
            toggleMenu()  // Close the side menu if open
        }
    }

    // Ensure that the tap gesture does not prevent other gestures (such as table view cell taps)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // If the tap is inside the side menu, ignore the gesture to allow interaction with side menu items
        if let view = touch.view, view.isDescendant(of: sideMenuView) {
            return false  // Ignore taps inside the side menu
        }
        return true  // Allow taps outside the side menu to close it
    }
}

