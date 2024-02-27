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
        
        setupButton()
        nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        animator = UIViewPropertyAnimator(duration: 1.5, curve: .easeInOut, animations: {
            self.viewForAnimation.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            self.viewForAnimation.layer.backgroundColor = UIColor.red.cgColor
            self.viewForAnimation.layer.cornerRadius = 15
        })
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        viewForAnimation.addGestureRecognizer(gesture)
        
        let doubleGesture = UITapGestureRecognizer(target: self, action: #selector(viewDoubleTapped))
        viewForAnimation.addGestureRecognizer(doubleGesture)
        doubleGesture.numberOfTouchesRequired = 2
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        viewForAnimation.addGestureRecognizer(panGesture)
    }
    
    @objc func buttonTapped() {
        guard let vc = ViewTransitionViewController.storyboardInstance() else { return }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func viewTapped() {
        animator.addAnimations {
            self.viewForAnimation.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            self.viewForAnimation.layer.backgroundColor = UIColor.red.cgColor
            self.viewForAnimation.layer.cornerRadius = 15
        }
        animator.startAnimation()
    }
    
    @objc func viewDoubleTapped() {
        animator.addAnimations {
            self.viewForAnimation.transform = .identity
            self.viewForAnimation.layer.backgroundColor = UIColor.systemPurple.cgColor
            self.viewForAnimation.layer.cornerRadius = 15
        }
        animator.startAnimation()
    }
    
    @objc func didPan(_ panGesture: UIPanGestureRecognizer) {
        let newPosition = panGesture.translation(in: self.view)
        let currentX = viewForAnimation.center.x
        let currentY = viewForAnimation.center.y
        let final = view.bounds.height
        
        viewForAnimation.center = CGPoint(x: currentX + newPosition.x, y: currentY + newPosition.y)
        animator.fractionComplete = viewForAnimation.frame.origin.y / final
        panGesture.setTranslation(.zero, in: self.view)
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
