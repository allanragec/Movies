//
//  TokenCollectionViewCell.swift
//  Movies
//
//  Created by Allan Melo on 15/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

class TokenCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView?
    @IBOutlet weak var titleLabel: UILabel?

    var measuredSize: CGSize {
        let maxWidth: CGFloat = 200
        let lineHeight: CGFloat = 13
        let paddingText: CGFloat = 12
        let tokenHeight: CGFloat = 20

        guard let text = titleLabel?.text,
            let font = titleLabel?.font else {
            return CGSize.zero
        }

        let constraint = CGSize(width: maxWidth, height: lineHeight)
        let context = NSStringDrawingContext()

        let boundingBox = text
            .boundingRect(with: constraint,
                          options: .usesLineFragmentOrigin,
                          attributes: [NSAttributedString.Key.font: font],
                          context: context).size

        return CGSize(width: boundingBox.width + paddingText, height: tokenHeight)
    }

    override func awakeFromNib() {
        containerView?.layer.borderColor = UIColor.white.cgColor
    }

    func configure(title: String) {
        titleLabel?.text = title
    }
}
