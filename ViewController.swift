//
//  ViewController.swift
//  AnimationKPI
//
//  Created by Lina Prosvetova on 18.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewForAnimation: UIView!
    
    @IBOutlet weak var viewForSpringAnimation: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewForAnimation.frame.origin.x = 100
        self.viewForAnimation.frame.origin.y = 200
        // базовая стандартная анимация
        UIView.animate(withDuration: 4.0, delay: 0.2, options: .repeat, animations: {
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
        
        self.viewForSpringAnimation.frame.origin.x = 0
        // usingSpringWithDamping коэффициент затухания колебаний чем меньше значение, тем больше колебания
        // initialSpringVelocity скорость c которой  view пройдет заданную дистанцию. Чем меньше тем медленнее
        UIView.animate(withDuration: 10.0, delay: 0.1, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.1, options: .repeat, animations: {
            self.viewForSpringAnimation.frame.origin.x = UIScreen.main.bounds.maxX - self.viewForSpringAnimation.frame.width
        }, completion: nil)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let vc = SecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

