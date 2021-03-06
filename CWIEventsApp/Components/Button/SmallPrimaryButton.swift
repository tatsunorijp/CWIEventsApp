//
//  SmallPrimaryButton.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 09/07/21.
//

import UIKit

class SmallPrimaryButton: BaseButton {
    private let defaultHeight = CGFloat(24)
    
    override func prepareLayout() {
        super.prepareLayout()
        frame.size = CGSize(width: frame.size.width, height: defaultHeight)
        layer.cornerRadius = frame.size.height / 2
        layer.masksToBounds = true
        clipsToBounds = true
        
        backgroundColor = Asset.Colors.primary500.color
        setTitleColor(Asset.Colors.white.color, for: .normal)
        
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }

}
