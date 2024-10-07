//
//  SideMenuView.swift
//  ConvertNote
//
//  Created by Yashom on 05/10/24.
//

import UIKit
import Lottie

class SideMenuView: UIView {
    
    // Image View
//    private let appIconImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "icons_erased")
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    private let animationView: LottieAnimationView = {
        let animation = LottieAnimationView(name: "sidemenu_icon")
        animation.loopMode = .loop
        animation.contentMode = .scaleAspectFit
        animation.play()
        animation.translatesAutoresizingMaskIntoConstraints = false
        return animation
    }()
    
    // Profile Info Button
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Profile Info", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Guide Button
    private let guideButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Guide", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // About Button
    private let aboutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("About", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Log Out Button
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.red, for: .normal)  // Log out button can be red for emphasis
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Set up the UI for the side menu
    private func setupUI() {
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2, height: 0)
        layer.shadowRadius = 4

        // Add subviews
        addSubview(animationView)
        addSubview(profileButton)
        addSubview(guideButton)
        addSubview(aboutButton)
        addSubview(logoutButton)

        // Layout using Auto Layout
        NSLayoutConstraint.activate([
            // App Icon Constraints
            animationView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 100),
            animationView.heightAnchor.constraint(equalToConstant: 100),
            
            // Profile Button Constraints
            profileButton.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 40),
            profileButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            // Guide Button Constraints
            guideButton.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 20),
            guideButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            // About Button Constraints
            aboutButton.topAnchor.constraint(equalTo: guideButton.bottomAnchor, constant: 20),
            aboutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            // Log Out Button Constraints
            logoutButton.topAnchor.constraint(equalTo: aboutButton.bottomAnchor, constant: 20),
            logoutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
    }

    func configureButtonActions(target: Any, profileSelector: Selector, guideSelector: Selector, aboutSelector: Selector, logoutSelector: Selector) {
        profileButton.addTarget(target, action: profileSelector, for: .touchUpInside)
        guideButton.addTarget(target, action: guideSelector, for: .touchUpInside)
        aboutButton.addTarget(target, action: aboutSelector, for: .touchUpInside)
        logoutButton.addTarget(target, action: logoutSelector, for: .touchUpInside)
    }
}

