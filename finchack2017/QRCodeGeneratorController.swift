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
    static var qrCocdeStringName: String?
    var databaseURL: String = "https://finhack2017.firebaseio.com/"
    var qrcodeImage: CIImage!
    var effect:UIVisualEffect!
    var rid: String?

    @IBAction func dismiss_controller(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
//    @IBOutlet weak var textField: UITextField!
//    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var visualEffect: UIVisualEffectView!

    @IBAction func popUpAccept(_ sender: Any) {

        DatabaseManager.sharedInstance().acceptInvitation(rid: rid!, uid: QRCodeGeneratorController.qrCocdeStringName!)
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

    override func viewDidAppear(_ animated: Bool) {
        visualEffect.isHidden = true
        // Generate
        let data = QRCodeGeneratorController.qrCocdeStringName?.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)

        let filter = CIFilter(name: "CIQRCodeGenerator")

        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")

        qrcodeImage = filter?.outputImage

        imgQRCode.image = UIImage(ciImage: qrcodeImage)

        //self.textField.delegate = self
        DatabaseManager.sharedInstance().bindInvitations(uid: QRCodeGeneratorController.qrCocdeStringName!, onInvite: oninvite)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        visualEffect.isHidden = true
        popUpView.layer.cornerRadius = 5

    }

    private func oninvite(srid: String){
        print("invited..........")
        rid = srid
        animateIn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func animateIn(){
        visualEffect.isHidden = false
        popUpView.isHidden = false
        self.view.addSubview(popUpView)
        print("popupview: ", popUpView)
        popUpView.center = self.view.center

        popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y:1.3)
        popUpView.alpha = 0

        UIView.animate(withDuration: 0.4){
            self.visualEffect.effect = self.effect
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
        handleTap()


    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secondRoute"{
            popUpView.isHidden = true
            visualEffect.isHidden = true
            let controller = segue.destination as! Map2ViewController
            controller.path1 = true
        }
    }

    func handleTap(){
        (0...15).forEach{ (_) in
            generateAnimatedViews()
            //colorAnimatedViews()
        }
    }

    fileprivate func generateAnimatedViews(){
        let image = drand48() > 0.5 ? #imageLiteral(resourceName: "thumbs_up") : #imageLiteral(resourceName: "heart")
        let imageView = UIImageView(image: image)
        //drand gives you a random number from 0 to 1 -> dimension {20 to 30}
        let dimension = 20 + drand48() * 10
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)

        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath

        animation.duration = 2 + drand48() * 3
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

        imageView.layer.add(animation, forKey:  nil)
        view.addSubview(imageView)
    }

    fileprivate func colorAnimatedViews(){
        let colorKeyframeAnimation = CAKeyframeAnimation(keyPath: "backgroundColor")
        colorKeyframeAnimation.values = [
            UIColor.red.cgColor,
            UIColor.green.cgColor,
            UIColor.blue.cgColor,
            UIColor.cyan.cgColor,
            UIColor.darkGray.cgColor]
        colorKeyframeAnimation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        colorKeyframeAnimation.duration = 1
        view.layer.add(colorKeyframeAnimation, forKey: nil)
    }

}

func customPath() -> UIBezierPath {

    //define a path for you to render
    let path = UIBezierPath()

    path.move(to: CGPoint(x: 0, y: 350 ))

    let endPoint = CGPoint(x: 400, y: 350)

    let randYShipt = drand48() * 100

    let cp1 = CGPoint(x: 100, y: 150 - randYShipt)
    let cp2 = CGPoint(x: 200, y: 350 + randYShipt)

    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}

class CurvedView: UIView{

    override func draw(_ rect: CGRect) {
        //do some fancy thing here

        //path.addLine(to: endPoint) 直線rendering

        let path = customPath()
        path.lineWidth = 3
        //render a line after creating starting and ending point
        path.stroke()
    }
}
