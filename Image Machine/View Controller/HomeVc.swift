//
//  HomeVc.swift
//  Image Machine
//
//  Created by Ridwan Surya Putra on 11/28/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class HomeVc : UIViewController {
    @IBOutlet weak var machineData: UIButton!
    @IBOutlet weak var codeReader: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        machineData.makeRoundedRect(withCornerRadius: 6)
        codeReader.makeRoundedRect(withCornerRadius: 6)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @IBAction func btnMachineTapped(_ sender: UIButton) {
        MachineDataVc.synth.show(from: self)
    }
    @IBAction func btnCodeTapped(_ sender: UIButton) {
        CodeReaderVc.synth.show(from: self)
    }
}
