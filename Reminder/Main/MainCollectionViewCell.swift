//
//  MainCollectionViewCell.swift
//  Reminder
//
//  Created by NERO on 7/3/24.
//

import UIKit
import SnapKit

final class MainCollectionViewCell: UICollectionViewCell {
    private let symbolImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 16.5 //임시
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.textColor = .systemCyan
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let countLabel = {
        let label = UILabel()
        label.textColor = .systemIndigo
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainCollectionViewCell {
    private func configureHierarchy() {
        [symbolImageView, titleLabel, countLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func configureLayout() {
        symbolImageView.snp.makeConstraints {
            $0.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            $0.size.equalTo(35)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(15)
        }
    }
    
    private func configureView() {
        self.backgroundColor = .customSky
        self.layer.cornerRadius = 13
        self.clipsToBounds = true
    }
}

extension MainCollectionViewCell {
    func update(category: MainListCategory, count: Int?) {
        let attribute = category.attribute
        symbolImageView.image = attribute.symbolImage
        symbolImageView.backgroundColor = attribute.color
        titleLabel.text = attribute.title
        countLabel.text = count?.formatted() ?? ""
    }
}
