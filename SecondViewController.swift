//
//  SecondViewController.swift
//  AnimationKPI
//
//  Created by Lina Prosvetova on 19.02.2024.
//

import UIKit

// Анимация констрейнтов
class SecondViewController: UIViewController {
    private lazy var viewForSpringAnimation: UIView = {
            let view: UIView = .init()
        view.backgroundColor = .green
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    private lazy var nextButton: UIButton = {
        let button: UIButton = .init()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.view.backgroundColor = .systemBackground
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(gesture)
        
        setupButton()
        nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        let vc = CABasicAnimationViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func viewTapped() {
        let start = self.viewForSpringAnimation.center
        
//        self.viewForSpringAnimation.frame.origin.x = 0
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.2, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                            self.viewForSpringAnimation.transform =  CGAffineTransform(scaleX: 2, y: 2)
                        }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                            self.viewForSpringAnimation.center =  CGPoint(x: self.view.bounds.midX, y: self.view.bounds.maxY)
                        }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                            self.viewForSpringAnimation.center =  CGPoint(x: self.view.bounds.width, y: start.y)
                        }
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                            self.viewForSpringAnimation.center =  start
                        }
        }, completion: nil)
        
    }
    
    func setupView() {
        view.addSubview(viewForSpringAnimation)
        NSLayoutConstraint.activate([
            viewForSpringAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
            viewForSpringAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            viewForSpringAnimation.widthAnchor.constraint(equalToConstant: 150),
            viewForSpringAnimation.heightAnchor.constraint(equalToConstant: 70),
            
        ])
    }
    
    func setupButton() {
        nextButton.setTitle("Далее", for: .normal)
        nextButton.layer.cornerRadius = 8.0
        nextButton.backgroundColor = .green
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            nextButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
