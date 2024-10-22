//
//  MainView.swift
//  Reminder
//
//  Created by NERO on 7/3/24.
//

import UIKit
import SnapKit

final class MainView: BaseView {
    private let templateLabel = {
        let label = UILabel()
        label.text = "전체" //임시
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    var listCollectionView = MainCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 15
        let cellSpacing: CGFloat = 15
        let cellCount: CGFloat = 2
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth - (sectionSpacing * 2) - (cellSpacing * 1)) / cellCount
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: width * 0.5)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        return layout
    }
    
    let addToDoButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "plus.circle.fill")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 8
        configuration.title = "새로운 할 일"
        configuration.titleAlignment = .trailing
        configuration.baseForegroundColor = .systemBlue
        button.configuration = configuration
        return button
    }()
    let addFolderButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.title = "폴더 추가"
        configuration.titleAlignment = .trailing
        configuration.baseForegroundColor = .systemBlue
        button.configuration = configuration
        return button
    }()
    
    override func configureHierarchy() {
        [templateLabel, listCollectionView, addToDoButton, addFolderButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        templateLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(4)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        listCollectionView.snp.makeConstraints {
            $0.top.equalTo(templateLabel.snp.bottom)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(addToDoButton.snp.top)
        }
        
        addToDoButton.snp.makeConstraints {
            $0.leading.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(30)
        }
        addFolderButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(30)
        }
        
    }
    
    override func configureView() {
        super.configureView()
    }
}

extension MainView {
    
}

//
//import SwiftUI
//
//struct ViewControllerRepresentable: UIViewControllerRepresentable {
//    typealias UIViewControllerType = MainViewController
//    
//    func makeUIViewController(context: Context) -> UIViewControllerType {
//        return UIViewControllerType()
//    }
//    
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//    }
//}
//
//@available(iOS 13.0.0, *)
//struct ViewPreview: PreviewProvider {
//    static var previews: some View {
//        ViewControllerRepresentable()
//    }
//}
