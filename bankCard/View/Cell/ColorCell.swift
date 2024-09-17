//
//  ColorCell.swift
//  bankCard
//
//  Created by Рамазан Абайдулла on 23.06.2024.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    private lazy var checkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .white
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(24)
        }
        imageView.isHidden = true
        
        return imageView
    }()
    
    func setCell(colors: [String]) {
        let gradient = ViewManager.shared.getGradient(frame: CGRect(origin: .zero, size: CGSize(width: 62, height: 62)), colors: colors)
        self.layer.addSublayer(gradient)
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        self.addSubview(checkImage)
        checkImage.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }
    }
    
    func selectItem(){
        checkImage.isHidden = false
    }
    
    func deselectItem(){
        checkImage.isHidden = true
    }
}
