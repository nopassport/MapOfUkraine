//
//  StatesListView.swift
//  RozborkaUA
//
//  Created by Volodymyr D on 09.12.2022.
//

import UIKit
import SnapKit

protocol StatesListViewDelegate: AnyObject { 
    func addButtonTapped()
    func tappedOnItem(withIndexPath indexPath: IndexPath)
    func delete(item: UkrStates)
}

class StatesListView: UIView {
    
    weak var delegate: StatesListViewDelegate!
    var selectedStates = [UkrStates]() {
        didSet { calculateItemsSize() }
    }
    var sizeOfItems: CGFloat = 20 {
        didSet { collectionView.reloadData() }
    }
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.alpha = 0.4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus.rectangle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28)), for: .normal)
        button.addTarget(self, action: #selector(addButtonHandle), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: createLayout())
        collectionView.register(StateCollectionViewCell.self, forCellWithReuseIdentifier: StateCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
 
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configViews()
    }
    
    public func setCollectionView(withData data: [UkrStates]) {
        selectedStates = data
    }
    
    private func configViews() { 
//        backgroundColor = .cyan.withAlphaComponent(0.3)
        //        alpha = 0.3
        layer.masksToBounds = true
        layer.cornerRadius = 14
        addSubview(collectionView)
        collectionView.addSubview(addButton)
        //        collectionView.frame = bounds
        setupConstraints()
        
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(130),
                                                  heightDimension: .estimated(40))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: itemSize.heightDimension)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            group.interItemSpacing = .fixed(4)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 7, leading: 7, bottom: 7, trailing: 7)
            section.interGroupSpacing = 6
            return section
        }
    }
    
    private func calculateItemsSize() {
        let itemsCount = CGFloat(collectionView.numberOfItems(inSection: 0))
        if itemsCount <= 5 { sizeOfItems = 20.0; return }
        if itemsCount > 26 { sizeOfItems = 5.5; return }
        var steps = [CGFloat]()
        var startStep  = 0.0
        while steps.count != 28 {
            steps.insert(startStep, at: 0)
            startStep += 0.31
        }
        sizeOfItems = (32.5 - steps[Int(itemsCount)] - itemsCount) * 0.7
    }
    
    private func setupConstraints() {
        addButton.snp.makeConstraints { [unowned self] in
            $0.centerY.equalTo(self)
            $0.right.equalTo(self).inset(4)
        }
    }
    
    @objc func addButtonHandle() {
        delegate.addButtonTapped()
    }
    
}


extension StatesListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.tappedOnItem(withIndexPath: indexPath)
    }
}

extension StatesListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { selectedStates.count }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StateCollectionViewCell.identifier, for: indexPath) as! StateCollectionViewCell
        cell.setItem(withText: selectedStates[indexPath.row].state)
        cell.setItemLabel(textSize: sizeOfItems)
        cell.deleteTapped = { [unowned self] in 
            delegate.delete(item: selectedStates[indexPath.row])
        }
        return cell
    }
     
}

extension StatesListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        UICollectionViewFlowLayout.automaticSize
    }
}
