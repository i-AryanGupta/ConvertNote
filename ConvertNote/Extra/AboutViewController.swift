//
//  AboutViewController.swift
//  ConvertNote
//
//  Created by Yashom on 06/10/24.
//

import UIKit

class AboutViewController: UIViewController {

    // Scrollable text view for displaying the About content
    private let aboutTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false  // Disable editing
        textView.isSelectable = false  // Disable text selection
        textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textView.textColor = .label
        textView.backgroundColor = .clear
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)  // Add padding around the text
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "About"

        // Customize navigation bar appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.label]
        
        setupTextView()
        displayAboutContent()
    }
    
    // Set up the text view layout
    private func setupTextView() {
        view.addSubview(aboutTextView)
        
        // Auto Layout for the text view to fill the entire screen
        NSLayoutConstraint.activate([
            aboutTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            aboutTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboutTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aboutTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Method to display the About content
    private func displayAboutContent() {
        let aboutText = """
        About My Notes

        Developer: Aryan Gupta

        My Notes is a powerful and intuitive note-taking application designed to help you capture and organize your thoughts seamlessly. Built using UIKit with a programmatic UI approach, this app ensures a smooth and responsive user experience.

        Key Features:
        - Effortless Note Creation: Add notes quickly with a clear title and detailed description.
        - Flexible Editing Options: Edit or delete notes with ease, keeping your information up-to-date.
        - Dynamic Viewing: Switch between List and Grid views to find your notes in the format that suits you best.
        - User-Centric Design: Designed with a focus on simplicity and usability, making note-taking a breeze.

        Architecture:
        My Notes is built using the VIPER architecture, promoting a clear separation of concerns. This architecture enhances scalability and maintainability, ensuring that the app remains robust and efficient as it evolves.

        Whether you’re a student, professional, or anyone in between, My Notes is your go-to solution for managing notes effortlessly.

        Thank you for choosing My Notes! We hope it enhances your productivity and creativity.
        """
        
        // Customize text formatting for the About section
        let attributedText = NSMutableAttributedString(string: aboutText)
        
        // Apply bold and larger font size to section headings
        let boldFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        let boldAttributes: [NSAttributedString.Key: Any] = [.font: boldFont]

        let sections = ["About My Notes", "Developer", "Key Features", "Architecture"]
        for section in sections {
            let range = (aboutText as NSString).range(of: section)
            attributedText.addAttributes(boldAttributes, range: range)
        }
        
        aboutTextView.attributedText = attributedText
    }
}

