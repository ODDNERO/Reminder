//
//  MainCollectionView.swift
//  Reminder
//
//  Created by NERO on 7/3/24.
//

import UIKit

class MainCollectionView: UICollectionView {
    init(layout: () -> UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout())
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
