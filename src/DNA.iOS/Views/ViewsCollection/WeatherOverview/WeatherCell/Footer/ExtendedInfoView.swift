//
//  ExtendedInfoView.swift
//  DNA.iOS
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit
import DNA_iOS_ViewModels

class ExtendedInfoView: UICollectionViewCell {
	
	private lazy var cellCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumInteritemSpacing = 0
		layout.minimumLineSpacing = 0
		layout.sectionInset = UIEdgeInsets(top: 0, left: GlobalConstant.margin.value, bottom: 0, right: GlobalConstant.margin.value)
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = .clear
		cv.showsVerticalScrollIndicator = false
		cv.isScrollEnabled = false
		cv.dataSource = self
		cv.delegate = self
		cv.register(ExtendedDetailCell.self, forCellWithReuseIdentifier: NSStringFromClass(ExtendedDetailCell.self))
		return cv
	}()

    var datasourceItem: [(ExtendedInfo, String)]! {
        didSet{
            guard let _ = datasourceItem  else { return }
			
            self.setupViews()
        }
    }
	
	
	// MARK: - Methods Setup -
	
	func setupViews() {
		self.addSubview(self.cellCollectionView)
		self.cellCollectionView.fillSuperview()
	}
}
