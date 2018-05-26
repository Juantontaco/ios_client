//
//  QRCodeViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/23/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        addVerticalGradient()
        showLogo()
        showLeftBackButton()
        showBlackBackground()
        showBlackBar(withText: "SCAN A ZOOTER TO UNLOCK AND ROLL")
        
        showScooterQRCodeImage()
        
        setUpCamera()
        setUpButtons()
    }
    
    func setUpCamera() {
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return failed() }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return failed()
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        let frameWidth : CGFloat = 280.0
        
        previewLayer.frame = CGRect(x: (view.bounds.width / 2) - (frameWidth / 2), y: (view.bounds.height / 2) - (frameWidth / 2) + 50, width: frameWidth, height: frameWidth)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    
    func failed() {
        toastMessage(message: "Scanning not supported. Please enter code.", danger: false)
        captureSession = nil
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
    
    func found(code: String) {
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
        
        let upperCaseCode = code.uppercased()
        
        print(upperCaseCode)
        
        //networkhelper get scooter by special id code
        //  //set scooter on startRide VC to returned scooter
        //  //move to startRideVC
        
        NetworkHelper().getScooterBySpecialIDCode(specialIDCode: upperCaseCode, completion: { optScooter in
            
            
            if let scooter = optScooter {
                let startRideVC : StartRideViewController = self.storyboard?.instantiateViewController(withIdentifier: "StartRideViewController") as! StartRideViewController
                
                startRideVC.scooter = scooter
                
                startRideVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                
                self.present(startRideVC, animated: true, completion: nil)
            } else {
                self.toastMessage(message: "There was an error retrieving info on this scooter.", danger: false)
                
                if (self.captureSession?.isRunning == false) {
                    self.captureSession.startRunning()
                }
            }
            
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showBlackBackground() {
        let blackBackgroundView : UIView = UIView(frame: CGRect(x: 0, y: 100, width: self.view.bounds.width, height: self.view.bounds.height))
        
        blackBackgroundView.backgroundColor = .black
        
        self.view.addSubview(blackBackgroundView)
    }
    
    func showLeftBackButton() {
        
        let backButtonRect = CGRect(x: 15, y: UIViewController.topOffset + 25, width: 30, height: 30)
        let image = UIImage(named: "backButtonLeft")
        image?.draw(in: backButtonRect)
        
        let leftBackButton = UIButton(frame: backButtonRect)
        leftBackButton.setImage(image, for: .normal)
        
        leftBackButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        
        self.view.addSubview(leftBackButton)
    }
    
    func showScooterQRCodeImage() {
        let imageWidth : CGFloat = 275.0
        let imageRect : CGRect = CGRect(x: (view.bounds.width / 2) - (imageWidth / 2), y: (view.bounds.height / 2) - (imageWidth / 2) - 100, width: imageWidth, height: imageWidth / 2)
        
        let imageView = UIImageView(frame: imageRect)
        
        imageView.image = UIImage(named: "scooterwithqrcode")
        
        imageView.image?.draw(in: imageRect)
        
        view.addSubview(imageView)
    }
    
    func setUpButtons() {
//        CGRect(x: (view.bounds.width / 2) - (frameWidth / 2), y: (view.bounds.height / 2) - (frameWidth / 2) + 50, width: frameWidth, height: frameWidth)
        
        //code button
        let width : CGFloat = 100.0
        let leftRect : CGRect = CGRect(x: (view.bounds.width / 2) - (width / 2) - 100, y: (view.bounds.height / 2) + 200, width: width, height: width / 4)
        let leftButton = UIButton(frame: leftRect)
        
        leftButton.setTitle("CODE", for: .normal)
        leftButton.titleLabel?.font = UIFont(name: "Gill Sans", size: 15)
        
        leftButton.addTarget(self, action: #selector(codeButtonPressed), for: .touchUpInside)
        
        view.addSubview(leftButton)
        
        //light button
        let rightRect : CGRect = CGRect(x: (view.bounds.width / 2) - (width / 2) + 85, y: (view.bounds.height / 2) + 200, width: width, height: width / 4)
        let rightButton = UIButton(frame: rightRect)
        
        rightButton.setTitle("LIGHT", for: .normal)
        rightButton.titleLabel?.font = UIFont(name: "Gill Sans", size: 15)
        
        rightButton.addTarget(self, action: #selector(lightButtonPressed), for: .touchUpInside)
        
        view.addSubview(rightButton)
        
    }
    
    @objc func codeButtonPressed() {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Enter Zooter Code", message: "Enter the code", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "HF9E9W..."
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
            
            if let text = textField?.text {
                self.found(code: text)
            } else {
                self.toastMessage(message: "An error occured checking the code.", danger: true)
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func lightButtonPressed() {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        if (device != nil && device!.hasTorch)  {
            do {
                try device!.lockForConfiguration()
                if (device!.torchMode == AVCaptureDevice.TorchMode.on) {
                    device!.torchMode = AVCaptureDevice.TorchMode.off
                } else {
                    do {
                        try device!.setTorchModeOn(level: 1.0)
                    } catch {
                        print(error)
                    }
                }
                device!.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    @objc func backButtonPressed() {
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
        dismiss(animated: true, completion: nil)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
