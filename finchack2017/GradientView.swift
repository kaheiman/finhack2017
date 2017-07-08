//
//  GradientView.swift
//  Plusll
//
//  Created by Marcus Man on 20/3/2017.
//  Copyright © 2017 Plusll. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var FirstColor: UIColor = UIColor.clear{
        didSet{
            updateView()
        }
    }
    @IBInspectable var SecondColor: UIColor = UIColor.clear{
        didSet{
            updateView()
        }
    }
    
    override class var layerClass: AnyClass{
        get{
            return CAGradientLayer.self
        }
    }
    
    func updateView(){
        let layer = self.layer as! CAGradientLayer
        layer.startPoint = CGPoint(x: 0.3,y :0.0)
        layer.endPoint = CGPoint(x: 1.0,y :1.0)
        layer.colors = [FirstColor.cgColor, SecondColor.cgColor]
        // this is work for where the gradient start to begin
        layer.locations = [0.0, 1.0]
    }
}
