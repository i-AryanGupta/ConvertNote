//
//  CustomTextField.swift
//  ConvertNote
//
//  Created by Yashom on 03/10/24.
//

import UIKit

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.boldSystemFont(ofSize: 28)
        self.font = font
        self.autocorrectionType = .no
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.gray
        ]
        self.attributedPlaceholder = NSAttributedString(string: "Title", attributes: attributes)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
