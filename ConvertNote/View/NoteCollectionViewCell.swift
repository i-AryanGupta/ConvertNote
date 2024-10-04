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
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        textLabel.font = UIFont.systemFont(ofSize: 14)
        textLabel.numberOfLines = 3
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(note: Note?) {
        titleLabel.text = note?.title
        textLabel.text = note?.text
    }
    
    func shadow(){
        self.layer.shadowColor = UIColor.systemGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.clipsToBounds = false
    }
}

