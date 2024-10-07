//
//  SplashViewController.swift
//  ConvertNote
//
//  Created by Yashom on 04/10/24.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    let animationView: LottieAnimationView = {
        let animation = LottieAnimationView(name: "splash_animation")
        animation.loopMode = .loop
        animation.contentMode = .scaleAspectFit
        animation.play()
        animation.translatesAutoresizingMaskIntoConstraints = false
        return animation
    }()

    
//    let logoImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "icons_erased")
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "My Notes"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let developerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "\"By Aryan Gupta\""
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white  // Set the background color for the splash screen
        setupLogo()
    }

    // Set up the logo image view constraints to center it
    private func setupLogo() {
//        view.addSubview(logoImageView)
        view.addSubview(appNameLabel)
        view.addSubview(developerNameLabel)
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            // for image view
            animationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//          logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 250),  // Adjust the size of the logo as needed
            animationView.heightAnchor.constraint(equalToConstant: 250),
            
            //for appname
            appNameLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 16),
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            appNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // for developer name
            //developerNameLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 8),
            developerNameLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            developerNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            developerNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            developerNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    // Public function to transition to the main view controller after a delay
    func transitionToMainView(window: UIWindow?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {  // 2-second delay for splash screen
            guard let window = window else { return }
            
            if CoreDataManager.shared.currentUser == nil {
                            // No user is logged in, so show the Login screen
                            let loginViewController = LoginRouter.createLoginModule()
                            window.rootViewController = UINavigationController(rootViewController: loginViewController)
                        } else {
                            // User is logged in, so show the Main screen
                            let mainViewController = MainRouter.createMainModule()
                            window.rootViewController = UINavigationController(rootViewController: mainViewController)
                        }

                        // Animate the transition
                        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
                    }
    }
}
