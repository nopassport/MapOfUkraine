//
//  UkraineMapView.swift
//  RozborkaUA
//
//  Created by Volodymyr D on 02.12.2022.
//

import UIKit
import PocketSVG

protocol UkraineMapViewDelegate{
//    func didSelect(states: Set<Int>)
    func didSelectOnMap(choise: Choice)
}

final class UkraineMapView: UIView {
    
    var mapDelegate: UkraineMapViewDelegate?
    private let urlSVGAdress = Bundle.main.url(forResource: "ukraine-cropped", withExtension: "svg")
    private var states: [UkrStates]!
    private var statesShapesView = UIView()
     
    
    convenience init(states: [UkrStates]) {
        let viewWidth = UIScreen.main.bounds.width * 0.9
        self.init(frame: CGRect(origin: .zero,
                                size: CGSize(width: viewWidth,
                                             height: viewWidth * 0.665849674)))
        self.states = states
    }
    override init(frame: CGRect) { super.init(frame: frame) }
    required init?(coder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configViews() 
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: statesShapesView) else { return }
        toggleColorShapeLayer(inPoint: point )
    }
    
    private func configViews() {
        guard let backgrounView = createBackgroundView() else { return }
        addSubview(backgrounView)
        backgrounView.addSubview(statesShapesView)
        if let statesLayer = createLayerWithShapesOfStates() {
            statesShapesView.layer.addSublayer(statesLayer)
        }
    }
       
    private func createLayerWithShapesOfStates() -> CALayer? {
        guard let bundleURLwithSVGFile = urlSVGAdress else { return nil }
        let statesLayer = CALayer()
        SVGBezierPath.pathsFromSVG(at: bundleURLwithSVGFile).enumerated().forEach { (ind, path) in
            statesLayer.addShape(withPath: path.cgPath ,
                                 shapeId: String(ind),
                                 screenWidth: UIScreen.main.bounds.width,
                                 fillColor: .blueSelectColorWithAlpha(),
                                 strokeColor: UIColor.white.cgColor)
        }
        return statesLayer
    }
    
    private func createBackgroundView() -> UIView? {
        guard let bundleURLwithSVGFile = urlSVGAdress else { return nil }
        let imageView = SVGImageView(contentsOf: bundleURLwithSVGFile)
        imageView.fillColor = .green.withAlphaComponent(0.5)
        imageView.frame = bounds
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
     
    private func toggleColorShapeLayer(inPoint point: CGPoint ) {
        guard let subShapesLayers = statesShapesView.layer.sublayers?.first?.sublayers else { return }
        subShapesLayers.forEach { [unowned self] in
            guard
                let shapeLay = ($0 as? CAShapeLayer),
                let path = shapeLay.path,
                path.contains(point)
            else { return }
            let index =  shapeLay.accessibilityLabel!.toInt()
//            print( self.states[index].state  , " <---- shapeLabel")
            if shapeLay.fillColor == .blueSelectColorWithAlpha() {
                shapeLay.fillColor = .zeroAlpha()
                mapDelegate?.didSelectOnMap(choise: .selected(index))
            }else if shapeLay.fillColor == .zeroAlpha() {
                shapeLay.fillColor = .blueSelectColorWithAlpha()
                mapDelegate?.didSelectOnMap(choise: .deselected(index))
            }
          
        }
    }


    public func toggleColorShapeLayerWithIndex(choice: Choice) {
        guard let subShapesLayers = statesShapesView.layer.sublayers?.first?.sublayers else { return }
        subShapesLayers.forEach{
            guard let shapeLay = ($0 as? CAShapeLayer), let ind = shapeLay.accessibilityLabel?.toInt() else { return }
            switch choice {
            case .selected(let id):
                if ind == id { shapeLay.fillColor = .zeroAlpha() }
            case .deselected(let id):
                if ind == id { shapeLay.fillColor = .blueSelectColorWithAlpha() }
            } 
        }
    }
    
}
