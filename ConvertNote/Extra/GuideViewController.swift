//
//  GuideViewController.swift
//  ConvertNote
//
//  Created by Yashom on 05/10/24.
//

import UIKit

class GuideViewController: UIViewController {

    // Scrollable text view for displaying the guide
    private let guideTextView: UITextView = {
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
        title = "User Guide"

        // Customize navigation bar appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.label]
        
        setupTextView()
        displayGuideContent()
    }
    
    // Set up the text view layout
    private func setupTextView() {
        view.addSubview(guideTextView)
        
        // Auto Layout for the text view to fill the entire screen
        NSLayoutConstraint.activate([
            guideTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            guideTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            guideTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            guideTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Method to display the guide content
    private func displayGuideContent() {
        let guideText = """
        Welcome to My Notes! This guide will help you get started with adding, editing, and organising your notes. Let’s dive in!

        Getting Started

        1. Opening the App
           - Launch the app from your device. You’ll be greeted by the home screen displaying your notes.

        Adding a Note

        1. Create a New Note
           - Click on the “Add Note” icon (usually a plus sign or a pencil icon) located at the top of the screen.
        2. Enter Note Details
           - Title: In the title field, type a concise title for your note.
           - Description: In the description area, enter the details of your note. You can add as much text as needed.
        3. Save Your Note
           - Once you’ve filled in the title and description, click on the **“Save”** button to store your note.

        Editing a Note

        1. Select the Note to Edit
           - Tap on the note you wish to edit. This will open the note in edit mode.
        2. Make Changes
           - Update the title or description as needed.
        3. Save Changes
           - After editing, click the **“Save”** button to update your note.

        Deleting a Note

        1. Choose the Note to Delete
           - Navigate to the note you want to delete and open it.
        2. Delete the Note
           - Click on the **“Delete”** icon (usually a trash can) to remove the note. Confirm your choice if prompted.

        Viewing Notes

        1. Switching Views
           - You can view your notes in two different layouts: **List View** and **Grid View**.
           - To change the view, look for the view toggle icon (it might look like a list or grid).
           - Click on the icon to switch between views according to your preference.

        Organizing Your Notes

        - Rearranging Notes: You can drag and drop notes in List View to organise them as you like.
        - Searching for Notes: Use the search bar at the top to quickly find a specific note by typing keywords from the title or description.

        Tips for Using the App

        - Regularly Save Your Work: Always make sure to save your changes before closing the app to avoid losing any information.
        - Use Descriptive Titles: Help yourself find notes easily by using clear and descriptive titles.
        - Explore Features: Don’t hesitate to explore other features of the app as you become more comfortable!

        Getting Help

        If you encounter any issues or have questions about the app, feel free to reach out to our support team via the Help section in the app.

        Enjoy using My NOTES to keep your thoughts organised and accessible! Happy note-taking!
        """
        
        // Customize text formatting for the guide
        let attributedText = NSMutableAttributedString(string: guideText)
        
        // Apply bold and larger font size to section headings
        let boldFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        let boldAttributes: [NSAttributedString.Key: Any] = [.font: boldFont]

        let sections = ["Getting Started", "Adding a Note", "Editing a Note", "Deleting a Note", "Viewing Notes", "Organizing Your Notes", "Tips for Using the App", "Getting Help"]
        for section in sections {
            let range = (guideText as NSString).range(of: section)
            attributedText.addAttributes(boldAttributes, range: range)
        }
        
        guideTextView.attributedText = attributedText
    }
}

