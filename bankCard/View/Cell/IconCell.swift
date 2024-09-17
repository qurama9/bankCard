//
//  IconCell.swift
//  bankCard
//
//  Created by Рамазан Абайдулла on 23.06.2024.
//

import UIKit

class IconCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(44)
        }
        imageView.layer.opacity = 0.2
        return imageView
    }()
    
    private lazy var checkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .white
        imageView.isHidden = true
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        return imageView
    }()
    
    func setCell(icon: UIImage) {
        imageView.image = icon
        self.addSubview(imageView)
        self.addSubview(checkImage)
        
        self.backgroundColor = UIColor(hex: "#1F1F1FFF")
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(-10)
            make.bottom.equalTo(self.snp.bottom).offset(10)
        }
        
        checkImage.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }
    }
    
    func selectItem() {
        checkImage.isHidden = false
    }
    
    func deselectItem() {
        checkImage.isHidden = true
    }
}
