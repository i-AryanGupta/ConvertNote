//
//  ProfileViewController.swift
//  ConvertNote
//
//  Created by Yashom on 07/10/24.
//

import UIKit
import Lottie

class ProfileViewController: UIViewController {

    // UI Elements
    private let animationView = LottieAnimationView(name: "account") // Lottie Animation View
    private let usernameLabel = UILabel()
    private let emailLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        loadProfileData()
    }

    // Set up the UI layout
    private func setupUI() {
        // Configure Lottie Animation View
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundColor = .systemBlue
        animationView.play() // Start the animation
        view.addSubview(animationView)

        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 100),
            animationView.widthAnchor.constraint(equalToConstant: 100)
        ])

        // Configure Username Label
        usernameLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        usernameLabel.textColor = .label
        view.addSubview(usernameLabel)

        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 20),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        // Configure Email Label
        emailLabel.font = .systemFont(ofSize: 18, weight: .regular)
        emailLabel.textColor = .systemGray
        view.addSubview(emailLabel)

        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    // Load the current user's profile data
    private func loadProfileData() {
        guard let currentUser = CoreDataManager.shared.currentUser else {
            // Handle case where no user is logged in
            usernameLabel.text = "No User"
            emailLabel.text = "Not logged in"
            return
        }

        // Populate the labels with the user's data
        usernameLabel.text = currentUser.username
        emailLabel.text = currentUser.email
    }
}

