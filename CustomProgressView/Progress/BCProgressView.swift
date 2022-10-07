//
//  BCProgressView.swift
//  CustomProgressView
//
//  Created by KwonBeomcheol on 2022/05/12.
//

import UIKit

final class CustomProgressView: UIView {
    
    public var colors: [UIColor] {
        get {
            gradientColors
        }
        
        set {
            if newValue.count == 0 {
                gradientColors = CustomProgressView.white
            } else if newValue.count == 1 {
                newValue.first.map { gradientColors = [$0, $0] }
            } else {
                gradientColors = newValue
            }
        }
    }
    
    private(set) var progress: Float = 0
    
    private var gradientColors: [UIColor] = CustomProgressView.redGradient {
        didSet {
            gradientLayer.colors = gradientColors.map { $0.cgColor }
        }
    }
    
    private let progressLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    
    required override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupLayers()
    }

    func setProgress(_ progress: Float, animated: Bool = true, duration: TimeInterval = 0.25) {
        let validated = validated(progress)
        if animated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.duration = duration
            animation.fromValue = self.progress
            animation.toValue = validated
            animation.fillMode = .both
            animation.isRemovedOnCompletion = false
            progressLayer.add(animation, forKey: "strokeEnd")
        } else {
            setProgressWithoutAnimation(validated)
        }
        self.progress = validated
    }
    
    func setProgress(_ progress: Float, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        setProgress(progress)
        CATransaction.commit()
    }
    
    func resetProgress() {
        setProgressWithoutAnimation(0)
    }
    
    private func removeAllAnimations() {
        progressLayer.removeAllAnimations()
    }
    
    private func setProgressWithoutAnimation(_ progress: Float) {
        let validated = validated(progress)
        progressLayer.removeAllAnimations()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        progressLayer.strokeEnd = CGFloat(validated)
        gradientLayer.mask = progressLayer
        self.progress = validated
        CATransaction.commit()
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
        gradientLayer.colors = gradientColors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.mask = progressLayer
        layer.addSublayer(gradientLayer)
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

extension CustomProgressView {
    
    static var redGradient: [UIColor] {
        [UIColor(r: 255, g: 88, b: 93), UIColor(r: 204, g: 39, b: 176)]
    }
    
    static var white: [UIColor] {
        [.white, .white]
    }
}
