//
//  SecondViewController.swift
//  AnimationKPI
//
//  Created by Lina Prosvetova on 19.02.2024.
//

import UIKit

class SecondViewController: UIViewController {
    private lazy var viewForAnimation: UIView = {
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
        let start = self.viewForAnimation.center
        
        //        self.viewForSpringAnimation.frame.origin.x = 0
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.2, options: .calculationModeLinear, animations: {
            // withRelativeStartTime время начала анимации 0..1 где 0 - начало общей анимации, 1 - конец общей анимации. Если обща анимаци 2 секунды, то 0.5 значит 1 секунда от начала
            // relativeDuration время за которое анимация достигнет указанного значения
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                self.viewForAnimation.transform =  CGAffineTransform(scaleX: 2, y: 2)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.viewForAnimation.center =  CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.maxY)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                self.viewForAnimation.center =  CGPoint(x: UIScreen.main.bounds.width, y: start.y)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.75) {
                self.viewForAnimation.center =  start
            }
        }, completion: { _ in
            // возвращаем объект к первоначальному состоянию до Аффинных трансформаций, тоже может быть заанимирован
            UIView.animate(withDuration: 1.0) {
                self.viewForAnimation.transform = .identity
            }
        })
    }
    
    func setupView() {
        view.addSubview(viewForAnimation)
        NSLayoutConstraint.activate([
            viewForAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
            viewForAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            viewForAnimation.widthAnchor.constraint(equalToConstant: 150),
            viewForAnimation.heightAnchor.constraint(equalToConstant: 70),
            
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
