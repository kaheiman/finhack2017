//
//  ShopDetailViewController.swift
//  finchack2017
//
//  Created by Marcus Man on 9/7/2017.
//  Copyright © 2017 Marcus Man. All rights reserved.
//

import UIKit

class ShopDetailViewController: UIViewController {

    @IBOutlet weak var imagetop: UIImageView!
    @IBOutlet weak var imagebot: UIImageView!

    @IBAction func dismiss_Control(_ sender: Any) {
        print("pop controller2")
        self.dismiss(animated: true, completion: nil)
    }

    var path1 = false

    override func viewDidLoad() {
        super.viewDidLoad()

        print("reload")
        if path1{
            imagetop.image = UIImage(named: "finhack_zara")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
