//
//  NoteViewController.swift
//  ConvertNote
//
//  Created by Yashom on 02/10/24.
//

import UIKit


protocol NoteViewProtocol: AnyObject {
    func displayNoteData(title: String, text: String)
}

class NoteViewController: UIViewController, NoteViewProtocol {
    
    var presenter: NotePresenterProtocol!
    
    private var textView: UITextView!
    private var textField: UITextField!
    
    var noteCell: NoteCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.largeTitleDisplayMode = .never

        setupNavigationBarItem()
        setupTextView()
        setupTextField()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    private func setupNavigationBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
    }

    private func setupTextView() {
        textView = CustomtextView(frame: .zero)
        view.addSubview(textView)
        textView.delegate = self
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.size.height * 0.09),
            textView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -115),
            textView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -56)
        ])
    }
    
    private func setupTextField() {
        textField = CustomTextField(frame: .zero)
        view.addSubview(textField)
        textField.delegate = self
        
        NSLayoutConstraint.activate([
            textField.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -10),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.heightAnchor.constraint(equalToConstant: 30),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -70)
        ])
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func displayNoteData(title: String, text: String) {
        textField.text = title
        textView.text = text
    }
}

extension NoteViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidChange(_ textView: UITextView) {
        presenter.updateNoteText(text: textView.text)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        presenter.updateNoteTitle(title: textField.text ?? "")
    }
}
