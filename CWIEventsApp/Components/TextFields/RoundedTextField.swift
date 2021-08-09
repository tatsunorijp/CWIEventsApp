//
//  RoundedTextField.swift
//  BaseMVVM
//
//  Created by Wellington Tatsunori Asahide on 25/06/21.
//

import Foundation
import UIKit

class RoundedTextField: BaseTextField {
    private let defaultHeight = CGFloat(40)
    private let halfHeight = CGFloat(20)
    
    override var padding: UIEdgeInsets {
        UIEdgeInsets(
            top: 0, left: halfHeight, bottom: 0, right: halfHeight
        )
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame.size.height = defaultHeight
        
        borderStyle = .none
        layer.cornerRadius = defaultHeight / 2
        layer.borderWidth = 0.5
        font = font?.withSize(17)
    }
}
