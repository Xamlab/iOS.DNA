//
//  DailyDetailCell.swift
//  DNA.iOS
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit
import DNA_iOS_ViewModels

class DailyDetailCell: UICollectionViewCell {
	
	private let dayLabel: WhiteLabel = {
		let label = WhiteLabel(font: UIFont.systemFont(ofSize: 19))
		return label
	}()
	
	private let temperatureHighLabel: WhiteLabel = {
		let label = WhiteLabel(font: UIFont.systemFont(ofSize: 19))
		return label
	}()
	
	private let temperatureLowLabel: SemiTransparentLabel = {
		let label = SemiTransparentLabel(font: UIFont.systemFont(ofSize: 19))
		return label
	}()
	
	private let weatherIcon: AutoFittingImageView = {
		let imageView = AutoFittingImageView()
		return imageView
	}()

    var datasourceItem: ListItemViewModel! {
        didSet {
            guard let _ = self.datasourceItem  else { return }
			
            self.setupViews()
			
            self.dayLabel.text = self.datasourceItem.weekDay
            self.weatherIcon.image = self.datasourceItem.weatherIcon
            self.temperatureLowLabel.text = self.datasourceItem.lowTemperature
            self.temperatureHighLabel.text = self.datasourceItem.highTemperature
        }
    }
	
	
	// MARK: - Methods Setup -
	
	func setupViews() {
		self.addSubview(self.weatherIcon)
		self.addSubview(self.dayLabel)
		
		self.weatherIcon.anchorCenterSuperview()
		self.weatherIcon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
		self.weatherIcon.equalWidthToHeight()
		
		self.dayLabel.anchorWithConstantsToTop(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: weatherIcon.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 4)
		
		let stackView = UIStackView.setupStackview(leftView: temperatureHighLabel, rightView: temperatureLowLabel, portionleft: 0.5, portionright: 0.5, spacing: 0)
		self.temperatureHighLabel.textAlignment = .left
		self.temperatureLowLabel.textAlignment = .right
		addSubview(stackView)
		stackView.anchorWithConstantsToTop(topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
		stackView.widthAnchor.constraint(equalToConstant: 66).isActive = true
	}
}


// MARK: - ListItemViewModel + UIImage -

fileprivate extension ListItemViewModel {
	var weatherIcon: UIImage? {
		guard let description = self.description else { return nil }
		
		switch self.pod {
		case .d:
			switch description {
			case .brokenClouds: return #imageLiteral(resourceName: "imageRainy")
			case .clearSky: return #imageLiteral(resourceName: "imageSunny")
			case .fewClouds: return #imageLiteral(resourceName: "imageDayPartlyCloudy")
			case .lightSnow: return #imageLiteral(resourceName: "imageNightCloudy")
			case .scatteredClouds: return #imageLiteral(resourceName: "imageDayPartlyCloudy")
			}
		case .n:
			switch description {
			case .brokenClouds: return #imageLiteral(resourceName: "imageNightPartlyCloudy")
			case .clearSky: return #imageLiteral(resourceName: "imageNightClear")
			case .fewClouds: return #imageLiteral(resourceName: "imageNightCloudy")
			case .lightSnow: return #imageLiteral(resourceName: "imageRainy")
			case .scatteredClouds: return #imageLiteral(resourceName: "imageNightCloudy")
			}
		}
	}
}
