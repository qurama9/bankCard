//
//  ViewController.swift
//  bankCard
//
//  Created by Рамазан Абайдулла on 21.06.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private lazy var builder = {
        return ViewBuilder(controller: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#141414FF")
        builder.setPageTitle(title: "Создай свою карточку")
        builder.getCard()
        builder.getColorSLider()
        builder.setIconSlider()
        builder.setDescriptionText()
    }


}

