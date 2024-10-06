//
//  LoginViewController.swift
//  ConvertNote
//
//  Created by Yashom on 06/10/24.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    var presenter: LoginPresenterProtocol? { get set }
    func showLoginError(message: String)
}

class LoginViewController: UIViewController, LoginViewProtocol {
    
    var presenter: LoginPresenterProtocol?

    // UI Elements for login
    private let appImageView = UIImageView(image: UIImage(named: "icons_erased"))  // Add your app logo image here
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let signupButton = UIButton(type: .system)

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

        // Configure Email and Password fields
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)

        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: appImageView.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])

        // Configure Login button
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        // Configure Signup button
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.addTarget(self, action: #selector(didTapSignup), for: .touchUpInside)
        view.addSubview(signupButton)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func didTapLogin() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        presenter?.login(email: email, password: password)
    }

    @objc private func didTapSignup() {
        presenter?.navigateToSignup()
    }

    func showLoginError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

