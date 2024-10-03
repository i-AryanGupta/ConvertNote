//
//  CustomTextView.swift
//  ConvertNote
//
//  Created by Yashom on 03/10/24.
//

import UIKit

class CustomtextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.systemFont(ofSize: 20)
        self.font = font
        self.autocorrectionType = .no
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
