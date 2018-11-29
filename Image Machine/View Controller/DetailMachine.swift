//
//  DetailMachine.swift
//  Image Machine
//
//  Created by Ridwan Surya Putra on 11/28/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DetailMachineVc: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var tv: UITableView!
    var machineToEdit: Machine?
    var imagePicker: UIImagePickerController!
    
    var id : String?;
    var addName : String?;
    var addType : String?;
    var addQrCode : Int32?;
    var addLastSeen : String?;
    var date1: Date?
    var imageMachine: UIImageView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if machineToEdit != nil {
            loadItemData()
        }
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    func loadItemData(){
       // print("test : \(machineToEdit?.name_machine)")
        if let machine = machineToEdit {
            id = machineToEdit?.id
            addName = machineToEdit?.name_machine
            addType = machineToEdit?.type_machine
            addQrCode = machineToEdit?.qrCode_machine
            date1 = machineToEdit?.lastSeen! as Date?
            imageMachine?.image = machine.toImage?.image as? UIImage
        }
    }
    @IBAction func TextFieldChange(_ sender: UITextField) {
        guard let indexPath = sender.indexPath else { return; }
        switch indexPath.row {
        case 0: id = sender.text
        case 1: addName = sender.text
        case 2: addType = sender.text
        case 3: addQrCode = Int32(sender.text ?? "0")
      //  case 4: addLastSeen = sender.text
        default: break;
        }
    }
    @IBAction func btnEditTapped(_ sender: UIButton) {
        var machine: Machine!
        
        let picture = Image(context: context)
        picture.image = imageMachine?.image
        
        if machineToEdit == nil {
            machine = Machine(context: context)
        }else {
            machine = machineToEdit
        }
        
        machine.toImage = picture
        
        if let name = addName {
            machine.name_machine = name
        }
        
        if let type = addType {
            machine.type_machine = type
        }
        
        if let qrCode = addQrCode {
            machine.qrCode_machine = qrCode
        }
        if let dateMaintenance = date1 {
            machine.lastSeen = dateMaintenance as NSDate
        }
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnDeleteTapped(_ sender: UIButton) {
        if machineToEdit != nil {
            context.delete(machineToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func textFieldDate(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(DetailMachineVc.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        date1 = dateFormatter.date(from: "BO05151530")
        addLastSeen = dateFormatter.string(from: sender.date)
//        tv.reloadData()
    }
    
    @IBAction func btnImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
         imageMachine?.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
extension DetailMachineVc: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0: return 5
        case 1: return 1
        case 2: return 1
        case 3: return 1
        default: return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            let cell = tableView.cell("0-0")
            let idMachine = cell?.textField(9)
            //    print("nama\(addName)")
            idMachine?.text = id
            return cell!
        case (0,1):
            let cell = tableView.cell("0-1")
            let name = cell?.textField(10)
        //    print("nama\(addName)")
            name?.text = addName
            return cell!
        case (0,2):
            let cell = tableView.cell("0-2")
            let type = cell?.textField(11)
            type?.text = addType
            return cell!
        case (0,3):
            let cell = tableView.cell("0-3")
            let qrCode = cell?.textField(12)
            qrCode?.text = "\(addQrCode ?? 0)"
            return cell!
        case (0,4):
            let cell = tableView.cell("0-4")
            let dateMaintenance = cell?.textField(13)
            dateMaintenance?.text = date1?.stringOfDate
            return cell!
        case (1,0):
            let cell = tableView.cell("1-0")
            let btn = cell?.button(10)
            let image = cell?.image(100)
            image?.image = imageMachine?.image ?? UIImage(named: "No-image-available.jpg")
            btn?.makeRoundedRect(withCornerRadius: 6)
            return cell!
        case (2,0):
            let cell = tableView.cell("2-0")
            let btn = cell?.button(20)
            btn?.makeRoundedRect(withCornerRadius: 6)
            return cell!
        case (3,0):
            let cell = tableView.cell("3-0")
            let btn = cell?.button(30)
            btn?.makeRoundedRect(withCornerRadius: 6)
            return cell!
        default: return UITableViewCell();
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, cellForRowAt: indexPath).height
    }
}

extension DetailMachineVc {
    static var synth : DetailMachineVc{ return UIViewController.instantiate(named: "DetailMachineVc") as! DetailMachineVc; }
    
    //    @discardableResult
    //    func `init` (containerVc: UIViewController? = nil) -> HomeMenuVc {
    //        self.containerVc = containerVc;
    //        return self;
    //    }
}
