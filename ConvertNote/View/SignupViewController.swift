//
//  SignupViewController.swift
//  ConvertNote
//
//  Created by Yashom on 06/10/24.
//

import UIKit

protocol SignupViewProtocol: AnyObject {
    var presenter: SignupPresenterProtocol? { get set }
    func showSignupError(message: String)
}

class SignupViewController: UIViewController, SignupViewProtocol {
    
    var presenter: SignupPresenterProtocol?

    // UI Elements for signup
    private let appImageView = UIImageView(image: UIImage(named: "icons_erased"))  // Add your app logo image here
    private let usernameTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let signupButton = UIButton(type: .system)
    private let loginButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        // Configure App Logo
        appImageView.contentMode = .scaleAspectFit
        view.addSubview(appImageView)
        appImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            appImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appImageView.heightAnchor.constraint(equalToConstant: 120),
            appImageView.widthAnchor.constraint(equalToConstant: 120)
        ])

        // Configure Username, Email and Password fields
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)

        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: appImageView.bottomAnchor, constant: 40),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])

        // Configure Signup button
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.addTarget(self, action: #selector(didTapSignup), for: .touchUpInside)
        view.addSubview(signupButton)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        // Configure Login button
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func didTapSignup() {
        let username = usernameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        presenter?.signup(username: username, email: email, password: password)
    }

    @objc private func didTapLogin() {
        presenter?.navigateToLogin()
    }

    func showSignupError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
