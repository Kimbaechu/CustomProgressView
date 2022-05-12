//
//  BCProgressView.swift
//  CustomProgressView
//
//  Created by KwonBeomcheol on 2022/05/12.
//

import UIKit

class BCProgressView: UIView {
    
    var color: UIColor = .systemBlue {
        didSet { setupLayers() }
    }
    
    private var progressLayer = CAShapeLayer()
    
    private var progress: CGFloat = 0
    
    convenience init(_ color: UIColor) {
        self.init(frame: .zero)
        self.color = color
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupLayers()
    }

    func setProgress(_ value: CGFloat, duration: TimeInterval = 0.1) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = progress
        animation.toValue = validated(value)
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        
        progressLayer.add(animation, forKey: "animation")
        progress = value
    }
    
    func resetProgress() {
        progressLayer.removeAllAnimations()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        progressLayer.strokeEnd = 0
        progress = 0
        CATransaction.commit()
    }
    
    func removeAllAnimations() {
        progressLayer.removeAllAnimations()
    }
    
    private func setupLayers() {
        let progressPath = UIBezierPath()
        let width = frame.size.width
        let height = frame.size.height
        let centerY = height/2
        
        progressPath.move(to: CGPoint(x: 0, y: centerY))
        progressPath.addLine(to: CGPoint(x: width, y: centerY))
        
        
        progressLayer.path = progressPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = height
        progressLayer.strokeColor = color.cgColor
        progressLayer.strokeEnd = 0
        
        
        layer.addSublayer(progressLayer)
        setupProgress(progress)
    }
    
    private func setupProgress(_ progress: CGFloat) {
        setProgress(progress)
    }
    
    private func validated(_ value: CGFloat) -> CGFloat {
        if value < 0 {
            return 0
        } else if value > 1 {
            return 1
        } else {
            return value
        }
    }
    
}
