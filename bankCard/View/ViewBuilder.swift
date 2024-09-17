//
//  ViewBuilder.swift
//  bankCard
//
//  Created by Рамазан Абайдулла on 21.06.2024.
//

import UIKit
import SnapKit

class ViewBuilder: NSObject {
    
    private let manager = ViewManager.shared
    private var card = UIView()
    private var balance: Float = 9.990
    private var numberCard: Int = 1234
    
    private var colorsCollection: UICollectionView!
    private var imageCollection: UICollectionView!
    
    var controller: UIViewController
    var view: UIView
    
    var cardColor: [String] = ["#16A085FF", "#003F32FF"] {
        willSet {
            if let colorView = view.viewWithTag(7) {
                let gradient = manager.getGradient(colors: newValue)
                card.layer.sublayers?.remove(at: 0)
                card.layer.insertSublayer(gradient, at: 0)
            }
        }
    }
    
    var cardIcon: UIImage = .icon1 {
        willSet {
            if let imageView = view.viewWithTag(8) as? UIImageView {
                imageView.image = newValue
            }
        }
    }
    
    init(controller: UIViewController) {
        self.controller = controller
        self.view = controller.view
    }
    
    lazy private var pageTitle: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.numberOfLines = 0
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    func setPageTitle(title: String) {
        pageTitle.text = title
        view.addSubview(pageTitle)
        
        NSLayoutConstraint.activate([
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    
    func getCard() {
       card = manager.getCard(colors: cardColor, balance: balance, cardNumber: numberCard, image: cardIcon)
        
        view.addSubview(card)
        
        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            card.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 30)
        ])
        
    }
    
    func getColorSLider(){
        let colorTitle = manager.slideTitle(titleText: "Выберите цвет")
        
        colorsCollection = manager.getCollection(id: RestoreIDs.colors.rawValue, delegate: self, dataSource: self)
        colorsCollection.register(ColorCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(colorsCollection)
        view.addSubview(colorTitle)
        
        NSLayoutConstraint.activate([
            colorTitle.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 50),
            colorTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            colorTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            colorsCollection.topAnchor.constraint(equalTo: colorTitle.bottomAnchor, constant: 20),
            colorsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setIconSlider() {
        let iconSliderTitle = manager.slideTitle(titleText: "Выберите иконку")
        
        imageCollection = manager.getCollection(id: RestoreIDs.images.rawValue, delegate: self, dataSource: self)
        imageCollection.register(IconCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(imageCollection)
        view.addSubview(iconSliderTitle)
        
        NSLayoutConstraint.activate([
            iconSliderTitle.topAnchor.constraint(equalTo: colorsCollection.bottomAnchor, constant: 40),
            iconSliderTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            iconSliderTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            imageCollection.topAnchor.constraint(equalTo: iconSliderTitle.bottomAnchor, constant: 20),
            imageCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setDescriptionText () {
        let descriptionText: UILabel = {
            let text = UILabel()
            text.text = "А ты сегодня чесал жопу? Если не чесал, то сейчас же печешы. И не забудь почесать завтра тоже"
            text.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            text.textColor = UIColor(hex: "#6F6F6FFF")
            text.numberOfLines = 0
            text.setLineHeight(lineHeight: 5)
            
            return text
        }()
        
        view.addSubview(descriptionText)
        
        descriptionText.snp.makeConstraints { make in
            make.top.equalTo(imageCollection.snp.bottom).offset(40)
            make.leading.equalTo(view.snp.leading).offset(30)
            make.trailing.equalTo(view.snp.trailing).offset(-30)
        }
    }
}

extension ViewBuilder: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.restorationIdentifier {
        case RestoreIDs.colors.rawValue:
            return manager.colors.count
        case RestoreIDs.images.rawValue:
            return manager.images.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.restorationIdentifier {
        case RestoreIDs.colors.rawValue:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ColorCell {
                let color = manager.colors[indexPath.item]
                cell.setCell(colors: color)
                return cell
            }
        case RestoreIDs.images.rawValue:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? IconCell {
                let icon = manager.images[indexPath.item]
                cell.setCell(icon: icon)
                return cell
            }
        default:
            return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case RestoreIDs.colors.rawValue:
            let colors = manager.colors[indexPath.item]
            self.cardColor = colors
            
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCell
            cell?.selectItem()
            
        case RestoreIDs.images.rawValue:
            let images = manager.images[indexPath.item]
            self.cardIcon = images
            
            let cell = collectionView.cellForItem(at: indexPath) as? IconCell
            cell?.selectItem()
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case RestoreIDs.colors.rawValue:
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCell
            cell?.deselectItem()
        case RestoreIDs.images.rawValue:
            let cell = collectionView.cellForItem(at: indexPath) as? IconCell
            cell?.deselectItem()
        default:
            return
        }
    }
    
}

enum RestoreIDs: String {
    case colors, images
}
