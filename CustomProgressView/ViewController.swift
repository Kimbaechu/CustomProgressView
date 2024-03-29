//
//  ViewController.swift
//  CustomProgressView
//
//  Created by KwonBeomcheol on 2022/05/12.
//

import UIKit

class ViewController: UIViewController {

    let progressView = CustomProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    @IBAction func setProgressMin(_ sender: Any) {
        print(#function)
        progressView.resetProgress()
    }
    
    @IBAction func setProgress10(_ sender: Any) {
        print(#function)
        progressView.setProgress(0.1)
    }
    
    
    @IBAction func setProgress40(_ sender: Any) {
        print(#function)
        progressView.setProgress(0.4)
    }
    
    
    @IBAction func setProgress90(_ sender: Any) {
        print(#function)
        progressView.setProgress(0.9)
    }
    
    
    @IBAction func setProgressMax(_ sender: Any) {
        print(#function)
        progressView.setProgress(1) { [weak self] in
            self?.progressView.resetProgress()
        }
    }
    
    @IBAction func setProgressRandom(_ sender: Any) {
        print(#function)
        
    }
    
    func setupUI() {
        progressView.backgroundColor = UIColor(displayP3Red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3)
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressView)
        
        progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        progressView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }

}

extension UIColor {
    convenience init(r:UInt, g:UInt, b:UInt, alpha:CGFloat = 1.0) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: alpha)
    }
}
