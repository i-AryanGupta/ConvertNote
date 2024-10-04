//
//  AddButton.swift
//  ConvertNote
//
//  Created by Yashom on 03/10/24.
//

import UIKit

class AddButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImage(UIImage(systemName: "note.text.badge.plus"), for: .normal) // sf symbol - rectangle.stack.badge.plus
        self.contentVerticalAlignment = .fill
        self.contentHorizontalAlignment = .fill
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setButtonConstraints(view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45).isActive = true
    }

}
