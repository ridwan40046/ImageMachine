//
//  CodeReaderVc.swift
//  Image Machine
//
//  Created by Ridwan Surya Putra on 11/28/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AMPopTip
import CoreData

class CodeReaderVc: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var scanningView: UIView!
    @IBOutlet weak var resultScan: UILabel!
    
    var captureSession = AVCaptureSession();
    var videoPreviewLayer : AVCaptureVideoPreviewLayer?;
    var qrCodeFrameView : UIView?;
    var container : UIViewController?;
    var qrCodeResult: String?;
    var controller : NSFetchedResultsController<Machine>!
    
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.pdf417,
                                      AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.dataMatrix,
                                      AVMetadataObject.ObjectType.interleaved2of5,
                                      AVMetadataObject.ObjectType.qr]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initScanning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Scan QRCode"
        scanAgainBtnTapped()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Util.backgroundThread {
            self.scanStopRunning();
        }
    }
    @IBAction func scanAgainBtnTapped() {
        captureSession.startRunning();
        qrCodeFrameView?.frame = CGRect.zero;
    }
    
    @IBAction func submitBtnTapped(){
//        if let objs = controller.fetchedObjects, objs.count > 0 {
//            DetailMachineVc.synth.show(from: self)
//        }
        DetailMachineVc.synth.show(from: self)
    }
    func scanStopRunning() {
        captureSession.stopRunning();
    }
    
    func cameraWithPosition(_ position: AVCaptureDevice.Position) -> AVCaptureDevice?
    {
        let deviceDescoverySession =
            AVCaptureDevice.DiscoverySession.init(
                deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],
                mediaType: AVMediaType.video,
                position: AVCaptureDevice.Position.unspecified)
        
        for device in deviceDescoverySession.devices {
            if device.position == position {
                return device
            }
        }
        
        return nil
    }
    func initScanning(){
        // Get the back-facing camera for capturing videos
        guard let captureDevice = cameraWithPosition(.back) else {
            scanningView.showPopTip("Failed to get the camera device", dir: .down);
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            //            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = scanningView.layer.bounds
        scanningView.layer.addSublayer(videoPreviewLayer!)
        
        // Move the message label and top bar to the front
        //        view.bringSubview(toFront: messageLabel)
        //        view.bringSubview(toFront: topbar)
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            scanningView.addSubview(qrCodeFrameView)
            scanningView.bringSubview(toFront: qrCodeFrameView)
        }
    }
}

extension CodeReaderVc: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata (or barcode) then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                //                launchApp(decodedURL: metadataObj.stringValue!)
                resultScan.text = metadataObj.stringValue
                resultScan.animateShake();
                scanningView.alpha = 0;
                UIView.animate(withDuration: 1) { self.scanningView.alpha = 1; }
                //scanAgainBtn.isHidden = false;
                captureSession.stopRunning();
                
                self.submitBtnTapped();
            }
        }
    }
    
}

extension CodeReaderVc {
    static var synth : CodeReaderVc{ return UIViewController.instantiate(named: "CodeReaderVc") as! CodeReaderVc; }
    
    //    @discardableResult
    //    func `init` (containerVc: UIViewController? = nil) -> HomeMenuVc {
    //        self.containerVc = containerVc;
    //        return self;
    //    }
}
