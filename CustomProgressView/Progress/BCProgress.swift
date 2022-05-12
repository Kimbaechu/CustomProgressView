//
//  BCProgress.swift
//  CustomProgressView
//
//  Created by KwonBeomcheol on 2022/05/12.
//

import UIKit

public class BCProgress: UIView {
    
    private var backgroundView = UIView()
    private var progress: CGFloat = 0
    private var progressLayer = CAShapeLayer()
    
    
    convenience private init() {
        self.init(frame: .zero)
    }

    required internal init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setupLayers() {
        let pathProgress = UIBezierPath(rect: <#T##CGRect#>)
    }
    
    private func setupProgress(_ progress: CGFloat) {

        setProgress(progress)
    }
    
    func setProgress(_ value: CGFloat, duration: TimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = progress
        animation.toValue = value
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false

        progress = value
    }
}
