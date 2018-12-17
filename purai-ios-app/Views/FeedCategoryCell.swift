//
//  CategoryCell.swift
//  purai-ios-app
//
//  Created by Felipe Mendes on 16/12/18.
//  Copyright © 2018 Felipe Mendes. All rights reserved.
//

import UIKit

class FeedCategoryCell: BaseCategoryCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var homeController : FeedController?
    var categories: [Category]?
    let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .dark
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    func fetchCategories() {
        ApiService.sharedInstance.fetchCategoryEvents { (categories: [Category]) in
            self.categories = categories
            self.collectionView.reloadData()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        fetchCategories()
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(EventCategoryCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !Reachability.isConnectedToNetwork(){
            self.collectionView.setEmptyMessage("Eita, não há conexão com a Internet.")
        } else if (self.categories?.count == nil || self.categories?.count ?? 0 == 0) {
            self.collectionView.setEmptyMessage("Eita, nenhum resultado foi encontrado.")
        } else {
            self.collectionView.restore()
        }
        
        return categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! EventCategoryCell
        cell.category = categories?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width, height: height + 16 + 76)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.homeController?.showDetailController(for: (events?[indexPath.item])!, at: indexPath, of: collectionView)
    }
}
