//
//  ViewController.swift
//  CustomProgressView
//
//  Created by KwonBeomcheol on 2022/05/12.
//

import UIKit

class ViewController: UIViewController {

    let progressView = BCProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    
    
    @IBAction func setProgressMin(_ sender: Any) {
        progressView.setProgress(0)
    }
    
    @IBAction func setProgress10(_ sender: Any) {
        progressView.setProgress(0.1)
    }
    
    
    @IBAction func setProgress40(_ sender: Any) {
        progressView.setProgress(0.4)
    }
    
    
    @IBAction func setProgress90(_ sender: Any) {
        progressView.setProgress(0.9)
    }
    
    
    @IBAction func setProgressMax(_ sender: Any) {
        progressView.setProgress(10)
    }
    
    @IBAction func setProgressRandom(_ sender: Any) {
        progressView.setProgress(CGFloat.random(in: 0...1))
    }
    
    func setupUI() {
        progressView.backgroundColor = .red
                
        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressView)
        
        progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        progressView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }

}

