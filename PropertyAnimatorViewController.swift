//
//  PropertyAnimatorViewController.swift
//  AnimationKPI
//
//  Created by Lina Prosvetova on 19.02.2024.
//

import UIKit

// UIViewPropertyAnimator
class PropertyAnimatorViewController: UIViewController {
    private lazy var viewForAnimation: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let button: UIButton = .init()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var animator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.view.backgroundColor = .systemBackground
        
        //        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        //        self.view.addGestureRecognizer(gesture)
        
        setupButton()
        nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
//        animator = UIViewPropertyAnimator
    }
    
    @objc func buttonTapped() {
        guard let vc = AnimatedTransitionViewController.storyboardInstance() else { return }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func setupView() {
        view.addSubview(viewForAnimation)
        NSLayoutConstraint.activate([
            viewForAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            viewForAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewForAnimation.widthAnchor.constraint(equalToConstant: 200),
            viewForAnimation.heightAnchor.constraint(equalToConstant: 100),
            
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
