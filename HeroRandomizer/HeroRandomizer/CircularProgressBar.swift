//
//  CircularProgressBar.swift
//  HeroRandomizer
//
//  Created by Asanbay on 29.11.2024.
//

import UIKit

class CircularProgressBar: UIView {
    
    private var shapeLayer: CAShapeLayer!
    private var trackLayer: CAShapeLayer!
    
    var progress: CGFloat = 0 {
        didSet {
            shapeLayer.strokeEnd = progress
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        let radius = min(bounds.width, bounds.height) / 2 - 10
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        let trackPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
        
        trackLayer = CAShapeLayer()
        trackLayer.path = trackPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 15
        trackLayer.strokeEnd = 2.0
        layer.addSublayer(trackLayer)
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = trackPath.cgPath
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 15
        shapeLayer.strokeEnd = 0.0
        layer.addSublayer(shapeLayer)
    }
    
    func setProgress(_ progress: CGFloat) {
        self.progress = progress
    }
}