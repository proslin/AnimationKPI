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
        UIView.animate(withDuration: 2.0,
                               delay: 0.1,
                               usingSpringWithDamping: 0.1,
                               initialSpringVelocity: 0.1,
                               options: .curveLinear,
                               animations: {
                    self.viewForSpringAnimation.frame.origin.x = self.view.bounds.maxX - self.viewForSpringAnimation.frame.width - 10
                }, completion: nil)
    }
    
    func setupView() {
        view.addSubview(viewForSpringAnimation)
        NSLayoutConstraint.activate([
            viewForSpringAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            viewForSpringAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewForSpringAnimation.widthAnchor.constraint(equalToConstant: 300),
            viewForSpringAnimation.heightAnchor.constraint(equalToConstant: 200),
            
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
