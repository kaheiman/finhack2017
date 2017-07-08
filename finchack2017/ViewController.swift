//
//  ViewController.swift
//  Plusll
//
//  Created by Marcus Man on 20/3/2017.
//  Copyright © 2017 Plusll. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var icon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DispatchQueue.main.async(execute: {
            if self.icon != nil {
                UIView.animate(withDuration: 2, delay: 0.25, options: [.autoreverse, .repeat], animations: {
                    self.icon.frame.origin.x += 60
                    //self.icon.frame.size.width += 15
                    //self.icon.frame.size.height += 15
                })
            }
        })
        // Do any additional setup after loading the view, typically from a nib.
        
//        let newLayer = CAGradientLayer()
//        newLayer.colors = [UIColor(red:1.00, green:0.47, blue:0.60, alpha:1.0).cgColor, UIColor(red:1.00, green:0.89, blue:0.73, alpha:1.0).cgColor]
//        
//        newLayer.frame = view.frame
//        
//        view.layer.insertSublayer(newLayer, at: 0)
    }


}

