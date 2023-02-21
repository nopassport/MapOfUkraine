//
//  StateCollectionViewCell.swift
//  RozborkaUA
//
//  Created by Volodymyr D on 09.12.2022.
//

import UIKit

class StateCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String { String(describing: self) }
 
    private lazy var textLabel: UILabel = {
        let label = UILabel()//frame: bounds) 
//        label.bounds = CGRect(origin: .zero, size: CGSize(width: ., height: <#T##CGFloat#>))
//        label.font = UIFont().withSize(44)
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(closeButtonDidTapp), for: .touchUpInside)
        return button
    }()
    
    var deleteTapped: (() -> Void)? = nil
    
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white.withAlphaComponent(0.2)
        layer.cornerRadius = 12
        clipsToBounds = true
//        setItemLabel(textSize: 20)//20
        contentView.addSubview(textLabel)
        contentView.addSubview(closeButton)
        setConstraints()
    }
    required init?(coder: NSCoder) { fatalError() }
 
 
 
     
    
    //MARK: - Metods
    public func setItem(withText text: String?) {
        textLabel.text = text
    }
    
    public func setItemLabel(textSize size: CGFloat) {
        textLabel.font = textLabel.font.withSize(size) 
        closeButton.setImage(UIImage(systemName: "xmark",withConfiguration: UIImage.SymbolConfiguration(pointSize: size)), for: .normal)
//        print(#function, size)
        layoutSubviews()
    }
     
    private func setConstraints() {
        textLabel.snp.makeConstraints{ [unowned self] in
            $0.bottom.equalTo(self.contentView.snp.bottom)
            $0.top.equalTo(self.contentView.snp.top)
            $0.left.equalTo(self.contentView.snp.left).inset(8)
//            $0.width.equalTo(100)
        }
        closeButton.snp.makeConstraints{ [unowned self] in
//            $0.size.equalTo(12)
//            $0.top.bottom.equalTo(self.contentView)
            $0.centerY.equalTo(textLabel.snp.centerY)
            $0.left.equalTo(self.textLabel.snp.right).inset(-6)
            $0.right.equalTo(self.contentView.snp.right).inset(8)
        }
    }
   
    @objc private func closeButtonDidTapp() {
        print(#function)
      deleteTapped?()
    }
    
    
}
