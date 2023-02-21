//
//  SecTryDrawViewController.swift
//  RozborkaUA
//
//  Created by Volodymyr D on 16.11.2022.
//

import UIKit
import SnapKit
 
class UkraineStatesViewController: UIViewController {
    
    var presenter: UkraineStatesViewPresenterOutput! {
        didSet { presenter.delegate = self }
    }
    
    private var listOfStates: [UkrStates]!
    
    private var statesLayersOfUkraine: UkraineMapView!
    private var statesListView: StatesListView!

    private var popUpTableViewSnapShot: UIView?
    private var popUpTableViewFrame: CGRect?
    
    deinit { print(String(describing: self), "waas deinit") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configListView()
        configStatesMapView(withData: listOfStates)
        setupConstraints()
    }
 
    private func configStatesMapView(withData data: [UkrStates]) {
        statesLayersOfUkraine = .init(states: data)
        statesLayersOfUkraine.center = view.center
        statesLayersOfUkraine.mapDelegate = self
        view.addSubview(statesLayersOfUkraine)
    }
    
    private func configListView() {
        statesListView = .init()
        statesListView.delegate = self
        statesListView.backgroundColor = .cyan.withAlphaComponent(0.3)
        view.addSubview(statesListView)
    }
     
    private func setupConstraints() {
        statesListView.translatesAutoresizingMaskIntoConstraints = false
        statesListView.snp.makeConstraints{ [unowned self] in
            $0.width.equalTo(self.statesLayersOfUkraine)
            $0.top.equalTo(self.statesLayersOfUkraine.snp.bottom).offset(8)
            $0.height.equalTo(111)
            $0.centerX.equalTo(self.view)
        }
    }
     
}


//MARK: Presenter
extension UkraineStatesViewController: UkraineStatesViewPresenterInput {
    func getData(data: [UkrStates]) {
        listOfStates = data
    }
 
    func fillStatesView(withArra arra: [UkrStates]) {
        statesListView.setCollectionView(withData: arra)
        
    }
}

//MARK: UkraineMap View Delegate
extension UkraineStatesViewController: UkraineMapViewDelegate {
    func didSelectOnMap(choise: Choice) {
        presenter.didSelect(did: choise)
    }
     
}

//MARK: PopUpTable Controller Delegate
extension UkraineStatesViewController: PopUpTableViewControllerDelegate {
    func didSelect(choice: Choice) {
        presenter.didSelect(did: choice)
        statesLayersOfUkraine.toggleColorShapeLayerWithIndex(choice: choice)
        
    }
    
}
 
//MARK: StatesListView Delegate
extension UkraineStatesViewController: StatesListViewDelegate {
    func delete(item: UkrStates) {
        presenter.didSelect(did: .deselected(item.id))
        statesLayersOfUkraine.toggleColorShapeLayerWithIndex(choice: .deselected(item.id))
    }
    
 
    func tappedOnItem(withIndexPath indexPath: IndexPath) {
    
    }
    
    func addButtonTapped() {
        statesListView.isHidden = true
        let popUpVC = PopUpTableViewController(states: listOfStates,
                                               selectedStates: statesListView.selectedStates)
        popUpVC.buildContentView(size: CGSize(width: view.bounds.width * 0.7,
                                              height: view.bounds.height * 0.7),
                                 color: statesListView.backgroundColor,
                                 alpha: statesListView.alpha,
                                 cornRadius: statesListView.layer.cornerRadius){ [unowned self] snapshot, contentViewFrame in
            popUpTableViewSnapShot = snapshot
            popUpTableViewFrame = contentViewFrame
        }
        popUpVC.modalPresentationStyle = .custom
        popUpVC.transitioningDelegate = self
        popUpVC.delegate = self
        present(popUpVC, animated: true)
    }
}

//MARK: UIViewControllerTransitioning Delegate
extension UkraineStatesViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? { self }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? { self }
    
}
//MARK: UIViewControllerAnimatedTransitioning
extension UkraineStatesViewController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval { 0.5 }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromView = transitionContext.viewController(forKey: .from)?.view,
            let toVC = transitionContext.viewController(forKey: .to)
        else { return }
        let isPresenting = fromView == view
        let toVCStatesVC = (toVC as? UkraineStatesViewController)
        
        toVCStatesVC?.statesListView.isHidden = true
        
        transitionContext.containerView.addSubview(popUpTableViewSnapShot!)
        if isPresenting {
            transitionContext.containerView.addSubview(toVC.view)
            toVC.view.isHidden = true
        }else{
            fromView.isHidden = true
        }
        popUpTableViewSnapShot?.frame = isPresenting ? statesListView.frame : popUpTableViewFrame!
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) { [unowned self] in
            popUpTableViewSnapShot?.frame = isPresenting ? popUpTableViewFrame! : statesListView.frame
        } completion: { [unowned self] compl in
            toVC.view.isHidden = false
            if !isPresenting { statesListView.isHidden = false }
            popUpTableViewSnapShot?.removeFromSuperview()
            transitionContext.completeTransition(compl)
        } 
    }
    
}
