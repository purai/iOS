//
//  BaseCategoryCell.swift
//  purai-ios-app
//
//  Created by Felipe Mendes on 16/12/18.
//  Copyright © 2018 Felipe Mendes. All rights reserved.
//

import UIKit

class BaseCategoryCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class EventCategoryCell: BaseCategoryCell {
    
    var category: Category? {
        didSet {
            titleLabel.text = category?.title
            setupCategoryImage()
            
            if let title = category?.title {
                let size = CGSize(width: frame.width - 16 - 40 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimateRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimateRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 35
                } else {
                    titleLabelHeightConstraint?.constant = 15
                }
            }
        }
    }
    
    func setupCategoryImage() {
        if let categoryImageUrl = category?.category_image {
            categoryImageView.loadImageUsingUrlString(urlString: categoryImageUrl)
        }
    }
    
    let categoryImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.dropShadow(color: .black, opacity: 1, offSet: CGSize.zero, radius: 5)
        return label
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        addSubview(categoryImageView)
        addSubview(titleLabel)
        
        // horizontal constraints
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: categoryImageView)
        addConstraintsWithFormat(format: "H:|-30-[v0]-30-|", views: titleLabel)
        
        // vertical constraints
        addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: categoryImageView)
        addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: titleLabel)
    }
}
