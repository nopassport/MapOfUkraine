//
//  StateWhisChecMarkTableViewCell.swift
//  RozborkaUA
//
//  Created by Volodymyr D on 07.12.2022.
//

import UIKit


class StateWhisChecMarkTableViewCell: UITableViewCell {
    
    static var identifier: String { String(describing: self) }
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
    }
    required init?(coder: NSCoder) { fatalError() }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        accessoryType = selected ? .checkmark : .none
    }
    
    public func setCell(withText text: String?) {
        textLabel?.text = text 
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil 
    }
 
}
