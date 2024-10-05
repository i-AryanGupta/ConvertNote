//
//  NoteCollectionViewCell.swift
//  ConvertNote
//
//  Created by Yashom on 04/10/24.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    static let id = "NoteCollectionViewCell"

    let titleLabel = UILabel()
    let textLabel = UILabel()
    let deleteButton = UIButton()
    
    //clousure handle delete
    var deleteAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        shadow()
        
        // color to see placement
//       titleLabel.backgroundColor = .red
//       textLabel.backgroundColor = .green
//       contentView.backgroundColor = .yellow
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.numberOfLines = 6
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textLabel)
        
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = .systemRed  // Set a red color for the trash icon
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(deleteButton)
        
        // delete action
        deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)

        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        textLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        textLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        NSLayoutConstraint.activate([
            // Title Label Constraints
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            // Text Label Constraints
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            textLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            // Delete Button Constraints
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            deleteButton.widthAnchor.constraint(equalToConstant: 24),
            deleteButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

//    func configure(note: Note?) {
//        titleLabel.text = note?.title
//        textLabel.text = note?.text
//    }
    
    func configure(note: Note?, deleteAction: @escaping () -> Void) {
            titleLabel.text = note?.title
            textLabel.text = note?.text
            self.deleteAction = deleteAction
        }
    
    // delete action
        @objc private func didTapDelete() {
            deleteAction?()  // Call the delete action closure when tapped
        }
    
    func shadow(){
        self.layer.shadowColor = UIColor.systemGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.clipsToBounds = false
    }
}

