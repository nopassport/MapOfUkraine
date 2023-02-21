//
//  PopUpTableViewController.swift
//  RozborkaUA
//
//  Created by Volodymyr D on 28.09.2022.
//

import UIKit
import SnapKit

protocol PopUpTableViewControllerDelegate: AnyObject {
//    func didSelect(items: SelectedItem, lastSelected: Choice)
    func didSelect(choice: Choice)
}

class PopUpTableViewController: UIViewController {
    
    weak var delegate: PopUpTableViewControllerDelegate!
 
    private var states: [UkrStates]!
    
    private lazy var contentView: UIView = {
        let view = UIView()
//        view.backgroundColor = .white.withAlphaComponent(0.55)
//        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
//    private lazy var searchBarView : SearchBarView = {
//        let searchBarView = SearchBarView()
//        searchBarView.backgroundColor = .white.withAlphaComponent(0.23)
////        searchBarView.searchBar.delegate = self
//        return searchBarView
//    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifieer")
        tableView.register(StateWhisChecMarkTableViewCell.self, forCellReuseIdentifier: StateWhisChecMarkTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.allowsMultipleSelection = true
        return tableView
    }()
    
    //MARK: Life Cycle
   convenience init(states: [UkrStates], selectedStates: [UkrStates]? = nil) {
        self.init(nibName: nil, bundle: nil)
        self.states = states
        selectedStates?.forEach{
            tableView.selectRow(at: .init(row: $0.id, section: 0), animated: false, scrollPosition: .none)
        }
       
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder: NSCoder) { fatalError( ) }
    deinit { print(String(describing: self), "was deinit") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear.withAlphaComponent(0.001)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true)
    }
 
    
    //MARK: public Metods
    public func buildContentView(size: CGSize, color: UIColor?, alpha: CGFloat, cornRadius: CGFloat,  compl: (_ snapshot: UIView?, _ contentViewFrame: CGRect?) -> Void){
//        view.addSubview(closeButton)
        view.addSubview(contentView)
//        contentView.addSubview(searchBarView)
        contentView.addSubview(tableView)
        contentView.frame = CGRect(origin: .zero,
                                   size: size )
        contentView.center = view.center
        contentView.backgroundColor = color
        contentView.layer.cornerRadius = cornRadius
        contentView.alpha = alpha
        setupConstrains() 
        compl(contentView.snapshotView(afterScreenUpdates: true), contentView.frame )
    }
    
    //MARK: private Metods
    
    // MARK:  Setup Constraints
    private func setupConstrains(){
        tableView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview() 
        }
    }
    
}



// MARK: - TableView data source
extension PopUpTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { states.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StateWhisChecMarkTableViewCell.identifier) as! StateWhisChecMarkTableViewCell
        cell.setCell(withText: states[indexPath.row].state)
        return cell
        
    }
    
}

// MARK: - TableView Delegate
extension PopUpTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelect(choice: .selected(indexPath.row))
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        delegate.didSelect(choice: .deselected(indexPath.row))
    }
 
}
 
