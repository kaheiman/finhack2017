//
//  RoudButton.swift
//  Plusll
//
//  Created by Marcus Man on 20/3/2017.
//  Copyright © 2017 Plusll. All rights reserved.
//

import UIKit

@IBDesignable
class RoudButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var mybackgroundColor: UIColor = UIColor.clear {
        didSet{
            self.layer.backgroundColor = mybackgroundColor.cgColor
        }
    }
    //TOP LEFT BOTTOM RIGHT
    /**
    @IBInspectable var imageLeft: CGFloat = 0 {
        didSet{
            self.imageEdgeInsets = UIEdgeInsetsMake(5, imageLeft , 5, self.imageEdgeInsets.right)
        }
    }

    @IBInspectable var imageRight: CGFloat = 0 {
        didSet{
            self.imageEdgeInsets = UIEdgeInsetsMake(5, self.imageEdgeInsets.left, 5, imageRight)
        }
    }
    */
}
