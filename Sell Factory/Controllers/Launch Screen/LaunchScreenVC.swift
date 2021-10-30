//
//  LaunchScreenVC.swift
//  Sell Factory
//
//  Created by Pranav Badgi on 6/29/21.
//

import UIKit
import Firebase


class LaunchScreenVC: UIViewController {
    
    //MARK: - Properties
    private let imageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        image.image = UIImage(named: "logoTransparent")
        return image
    }()
    

    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(imageView)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.animate()
        })
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.center = view.center
    }
    
    
    
    
    
    
    
    //MARK: - Helpers
    private func animate() {
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width*2.5
            let diffx = size - self.view.frame.size.width
            let diffy = self.view.frame.size.height - size
            self.imageView.frame = CGRect(x: -(diffx/2),
                                          y: diffy/2,
                                          width: size,
                                          height: size)
        })
        
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
                    if Auth.auth().currentUser == nil {
                        //user is not logged in... go to login Screen
                        let vc = UINavigationController(rootViewController: LoginVC())
                        vc.modalPresentationStyle = .fullScreen
                        vc.modalTransitionStyle = .crossDissolve
                        self.present(vc, animated: true)
                    } else {
                        //user is logged in Go to home Screen
                        let vc = UINavigationController(rootViewController: HomeVC())
                        vc.modalPresentationStyle = .fullScreen
                        vc.modalTransitionStyle = .crossDissolve
                        self.present(vc, animated: true)
                    }
                })
            }
        })
    }
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    
    
    
    
    
}
