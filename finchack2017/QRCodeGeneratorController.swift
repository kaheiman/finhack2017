//
//  QRCodeGeneratorController.swift
//  Plusll
//
//  Created by Marcus Man on 8/7/2017.
//  Copyright © 2017 Plusll. All rights reserved.
//

import UIKit
import Firebase

class QRCodeGeneratorController: UIViewController, UITextFieldDelegate{


    //For firebase
    var qrCocdeStringName: String = DatabaseManager.uid
    var databaseURL: String = "https://finhack2017.firebaseio.com/"
    var qrcodeImage: CIImage!
    var effect:UIVisualEffect!

//    @IBOutlet weak var textField: UITextField!
//    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var visualEffect: UIVisualEffectView!

    @IBAction func popUpAccept(_ sender: Any) {

        print("popupaccept button on")
        //self.performSegue(withIdentifier: "secondRoute", sender: self)
    }

    @IBAction func performButtonAction(_ sender: Any) {
//        if qrcodeImage == nil {
//
//            if textField.text == "" {
//                return
//            }else{
//                let data = qrCocdeStringName.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
//
//                let filter = CIFilter(name: "CIQRCodeGenerator")
//
//                filter?.setValue(data, forKey: "inputMessage")
//                filter?.setValue("Q", forKey: "inputCorrectionLevel")
//
//                qrcodeImage = filter?.outputImage
//
//                imgQRCode.image = UIImage(ciImage: qrcodeImage)
//
//                textField.resignFirstResponder()
//            }
//        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        effect = visualEffect.effect
        //visualEffect.effect = nil
        visualEffect.isHidden = true
        popUpView.layer.cornerRadius = 5

        // Generate
        let data = qrCocdeStringName.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)

        let filter = CIFilter(name: "CIQRCodeGenerator")

        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")

        qrcodeImage = filter?.outputImage

        imgQRCode.image = UIImage(ciImage: qrcodeImage)

        //self.textField.delegate = self
        DatabaseManager.sharedInstance().bindInvitations(uid: DatabaseManager.uid, onInvite: oninvite)


    }

    private func oninvite(rid: String){
        print("invited..........")
        animateIn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func animateIn(){
        visualEffect.isHidden = false
        self.view.addSubview(popUpView)
        popUpView.center = self.view.center

        popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y:1.3)
        popUpView.alpha = 0

        UIView.animate(withDuration: 0.4){
            self.visualEffect.effect = self.effect
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secondRoute"{
            let controller = segue.destination as! Map2ViewController
            controller.path1 = true
        }
    }


}
