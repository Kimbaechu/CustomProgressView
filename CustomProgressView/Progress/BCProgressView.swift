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
    
    var colors: [UIColor] = colorSet {
        didSet { setupLayers() }
    }
    
    private var progressLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    var progress: Float = 0
    
//    convenience init(_ color: UIColor) {
//        self.init(frame: .zero)
//        self.color = color
//    }

    convenience init(_ colors: [UIColor]) {
        self.init(frame: .zero)
        self.colors = colors
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

    func setProgress(_ value: Float, animated: Bool = true, duration: TimeInterval = 0.25) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = progress
        animation.toValue = validated(value)
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        
        progressLayer.add(animation, forKey: "strokeEnd")
        progress = value
    }
    
    func setProgress(_ progress: Float, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        setProgress(progress)
        CATransaction.commit()
    }
    
    func resetProgress() {
        progressLayer.removeAllAnimations()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        progressLayer.strokeEnd = 0
        gradientLayer.mask = progressLayer
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
        progressLayer.strokeColor = UIColor.systemBlue.cgColor
        progressLayer.strokeEnd = 0
        
        layer.addSublayer(progressLayer)
        
        
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.mask = progressLayer
        layer.addSublayer(gradientLayer)
        
        setupProgress(progress)
    }
    
    private func setupProgress(_ progress: Float) {
        setProgress(progress)
    }
    
    private func validated(_ value: Float) -> Float {
        if value < 0 {
            return 0
        } else if value > 1 {
            return 1
        } else {
            return value
        }
    }
    
}

extension BCProgressView {
    static var colorSet: [UIColor] {
        [UIColor(r: 255, g: 88, b: 93), UIColor(r: 204, g: 39, b: 176)]
    }
}
