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

//    @IBOutlet weak var textField: UITextField!
//    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var imgQRCode: UIImageView!

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

    private func oninvite(){
        print("invited..........")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
