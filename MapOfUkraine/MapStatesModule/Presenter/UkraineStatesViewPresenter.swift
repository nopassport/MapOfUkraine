//
//  UkraineStatesViewPresenter.swift
//  RozborkaUA
//
//  Created by Volodymyr D on 07.12.2022.
//

import Foundation


protocol UkraineStatesViewPresenterOutput{
    var delegate: UkraineStatesViewPresenterInput! { get set }
    func viewDidLoad() 
    func didSelect(did: Choice)
}

protocol UkraineStatesViewPresenterInput: AnyObject  {
    func getData(data: [UkrStates])
    func fillStatesView(withArra arra: [UkrStates])
}





class UkraineStatesViewPresenter {
    
    private var selectedItems = [UkrStates]()
    
    private let states = MockData.shared.states.ukr
    
    weak var delegate: UkraineStatesViewPresenterInput!
    
    
}


extension UkraineStatesViewPresenter: UkraineStatesViewPresenterOutput {
   
    func didSelect(did: Choice) {
        switch did {
        case .selected(let id):
            if let state = (states.filter{ $0.id == id }).first {
                selectedItems.append(state)
            }
        case .deselected(let id):
            selectedItems.enumerated().forEach{ index, selectedItem in
                if selectedItem.id == id {
                    selectedItems.remove(at: index)
                }
            }
        }
        delegate.fillStatesView(withArra: selectedItems)
    }
 
    
    func viewDidLoad() {
        delegate.getData(data: states)
    }
     
    
    
}
