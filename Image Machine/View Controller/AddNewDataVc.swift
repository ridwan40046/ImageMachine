//
//  AddNewDataVc.swift
//  Image Machine
//
//  Created by Ridwan Surya Putra on 11/28/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class AddNewDataVc: UIViewController {
    
    @IBOutlet weak var tv: UITableView!
    
    var MachineToEdit: Machine?
    
    var id : String?;
    var addName : String?;
    var addType : String?;
    var addQrCode : Int32?;
    var addLastSeen : String?;
    var date: NSDate?;

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        var machine: Machine!
        if MachineToEdit == nil {
            machine = Machine(context: context)
        }else {
            machine = MachineToEdit
        }
        
        machine.id = randomString(length: 8)
        
        if let name = addName {
            machine.name_machine = name
        }
        
        if let type = addType {
            machine.type_machine = type
        }
        
        if let qrCode = addQrCode {
            machine.qrCode_machine = qrCode
        }
        
        if let dateMaintenance = date {
            machine.lastSeen = dateMaintenance
        }
          ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func TextFieldChange(_ sender: UITextField) {
        guard let indexPath = sender.indexPath else { return; }
        switch indexPath.row {
        case 0: addName = sender.text
        case 1: addType = sender.text
        case 2: addQrCode = Int32(sender.text ?? "0")
     //   case 3: addLastSeen = sender.text
        default: break;
        }
    }
    
    @IBAction func textFieldDate(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(AddNewDataVc.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        date = dateFormatter.date(from: "BO05151530") as NSDate?
        addLastSeen = dateFormatter.string(from: sender.date)
        tv.reloadData()
    }
}

extension AddNewDataVc: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0: return 4
        case 1: return 1
        default: return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            let cell = tableView.cell("0-0")
            return cell!
        case (0,1):
            let cell = tableView.cell("0-1")
            return cell!
        case (0,2):
            let cell = tableView.cell("0-2")
            return cell!
        case (0,3):
            let cell = tableView.cell("0-3")
            print("last seen : \(addLastSeen)")
            let date = cell?.textField(4)
            date?.text = addLastSeen
            return cell!
        case (1,0):
            let cell = tableView.cell("1-0")
            let btn = cell?.button(10)
            btn?.makeRoundedRect(withCornerRadius: 6)
            return cell!
        default: return UITableViewCell();
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, cellForRowAt: indexPath).height
    }
}

extension AddNewDataVc {
    static var synth : AddNewDataVc{ return UIViewController.instantiate(named: "AddNewDataVc") as! AddNewDataVc; }
    
    //    @discardableResult
    //    func `init` (containerVc: UIViewController? = nil) -> HomeMenuVc {
    //        self.containerVc = containerVc;
    //        return self;
    //    }
}
