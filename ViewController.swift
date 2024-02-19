//
//  ViewController.swift
//  AnimationKPI
//
//  Created by Lina Prosvetova on 18.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewForAnimation: UIView!
    
    @IBOutlet weak var viewForKeyframeAnimation: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewForAnimation.frame.origin.x = 100
        self.viewForAnimation.frame.origin.y = 200
        // базовая стандартная анимация
        UIView.animate(withDuration: 2.0, animations: {
            self.viewForAnimation.backgroundColor = .cyan
            self.viewForAnimation.alpha = 0.2
//            self.viewForAnimation.center = self.view.center
            // Аффинные преобразования transform, rotate, scale
            self.viewForAnimation.transform = CGAffineTransform(rotationAngle: -.pi / 2).scaledBy(x: 1.5, y: 1.5).translatedBy(x: 0, y: -50)
        }) { _ in
            // возвращаем объект к первоначальному состоянию до Аффинных трансформаций, тоже может быть заанимирован
            UIView.animate(withDuration: 1.0) {
                self.viewForAnimation.transform = .identity
            }
        }
        
        self.viewForKeyframeAnimation.frame.origin.x = 0
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.2, options: .repeat, animations: {
            self.viewForKeyframeAnimation.frame.origin.x = self.view.bounds.maxX - self.viewForKeyframeAnimation.frame.width
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                self.viewForKeyframeAnimation.backgroundColor = .red
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1.0) {
                self.viewForKeyframeAnimation.transform = .init(rotationAngle: .pi / 2)
            }
        }, completion: nil)
        
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let vc = SecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

