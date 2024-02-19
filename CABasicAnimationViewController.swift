//
//  CABasicAnimationViewController.swift
//  AnimationKPI
//
//  Created by Lina Prosvetova on 19.02.2024.
//

import UIKit

// Создаем анимацию перехода из одной фигуру в другую с помощью CABasicAnimation для объектов CAShapeLayer
class CABasicAnimationViewController: UIViewController {

    private lazy var nextButton: UIButton = {
        let button: UIButton = .init()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var figureOne: CAShapeLayer!
    var figureTwo: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        createShapes()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
        self.view.addGestureRecognizer(gesture)
        
        setupButton()
        nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        let vc = PropertyAnimatorViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func tapped(_ sender: UITapGestureRecognizer) {
        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
        pathAnimation.fromValue = figureOne.path
        figureOne.path = figureTwo.path
        pathAnimation.toValue = figureTwo.path
        pathAnimation.duration = 1.0
//        figureOne.add(pathAnimation, forKey: nil)
        
        let fillColorAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.fillColor))
        fillColorAnimation.fromValue = figureOne.fillColor
        figureOne.fillColor = figureTwo.fillColor
        fillColorAnimation.toValue = figureTwo.fillColor
        
//        figureOne.add(fillColorAnimation, forKey: nil)
        
        let rotateAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        rotateAnimation.valueFunction = CAValueFunction(name: .rotateZ)
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = 4 * Float.pi
        
        let group = CAAnimationGroup()
        group.duration = 1
        group.animations = [pathAnimation, rotateAnimation, fillColorAnimation]
        figureOne.add(group, forKey: nil)
    }
    
    func createShapes() {
        figureOne = CAShapeLayer()
        let rect = CGRect(x: self.view.frame.width / 2 - 50,
                          y: self.view.frame.height / 2 - 50,
                          width: 100,
                          height: 100)
        figureOne.path = UIBezierPath(roundedRect: rect, cornerRadius: 0).cgPath
        figureOne.fillColor = UIColor.red.cgColor
        view.layer.addSublayer(figureOne)
        
        figureOne.frame = self.view.bounds
        
        figureTwo = CAShapeLayer()
        let rectForFigureTwo = CGRect(x: self.view.frame.width / 2 - 75,
                                      y: self.view.frame.height / 2 - 75,
                                      width: 150,
                                      height: 150)
        figureTwo.path = UIBezierPath(ovalIn: rectForFigureTwo).cgPath
        figureTwo.fillColor = UIColor.green.cgColor
//        view.layer.addSublayer(figureTwo)
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
