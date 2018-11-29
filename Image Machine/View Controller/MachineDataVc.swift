//
//  MachineDataVc.swift
//  Image Machine
//
//  Created by Ridwan Surya Putra on 11/28/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MachineDataVc: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var sortType: UIButton!
    @IBOutlet weak var addNew: UIButton!
    @IBOutlet weak var sornName: UIButton!
    
    var controller : NSFetchedResultsController<Machine>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  generateTestData()
     //   sortType.makeRoundedRect(withCornerRadius: 6)
     //   sornName.makeRoundedRect(withCornerRadius: 6)
        addNew.makeRoundedRect(withCornerRadius: 6)
        switchSort()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Machine Data"
        tv.reloadData()
    }
    
//    @IBAction func sortByName(_ sender: Any) {
//    }
//
//    @IBAction func sortByTipe(_ sender: Any) {
//
//    }
    
    @IBAction func segmentTapped(_ sender: Any) {
        switchSort()
        tv.reloadData()
    }
    
    @IBAction func addNewTapped(_ sender: Any) {
        AddNewDataVc.synth.show(from: self)
    }
    
    func switchSort(){
        let fetchRequest: NSFetchRequest<Machine> = Machine.fetchRequest()
   //     let dateSort = NSSortDescriptor(key: "lastSeen", ascending: false)
        let nameSort = NSSortDescriptor(key: "name_machine", ascending: true)
        let typeSort = NSSortDescriptor(key: "type_machine", ascending: true)
        
        if segment.selectedSegmentIndex == 0 {
            
            fetchRequest.sortDescriptors = [nameSort]
            
        } else if segment.selectedSegmentIndex == 1 {
            
            fetchRequest.sortDescriptors = [typeSort]
        }
//        } else if segment.selectedSegmentIndex == 2 {
//
//            fetchRequest.sortDescriptors = [typeSort]
//        }
        
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tv.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tv.endUpdates()
    }
    
     func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
            
        case.insert:
            if let indexPath = newIndexPath {
                tv.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tv.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tv.cellForRow(at: indexPath)
                let data = controller.object(at: indexPath )
                let labelName = cell?.label(1)
                let labelType = cell?.label(2)
            
            }
            break
        case.move:
            if let indexPath = indexPath {
                tv.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tv.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        }
    }
    
    func generateTestData() {
        
        let machine = Machine(context: context)
        machine.name_machine = "Asus"
        machine.type_machine = "Komputer"
        machine.qrCode_machine = 123456
        machine.id = "abc123"
        
        let machine1 = Machine(context: context)
        machine1.name_machine = "Toshiba"
        machine1.type_machine = "Komputer"
        machine1.qrCode_machine = 123456
        machine1.id = "abca123"
        
        let machine3 = Machine(context: context)
        machine3.name_machine = "Suzuki"
        machine3.type_machine = "Mobil"
        machine3.qrCode_machine = 123456
        machine3.id = "abc1sdc23"
        
        ad.saveContext()
    }
}

extension MachineDataVc {
    static var synth : MachineDataVc{ return UIViewController.instantiate(named: "MachineDataVc") as! MachineDataVc; }
    
//    @discardableResult
//    func `init` (containerVc: UIViewController? = nil) -> HomeMenuVc {
//        self.containerVc = containerVc;
//        return self;
//    }
}

extension MachineDataVc : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell()
        let data = controller.object(at: indexPath )
        let labelName = cell?.label(1)
        let labelType = cell?.label(2)
        labelName?.text = data.name_machine
        labelType?.text = data.type_machine
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, cellForRowAt: indexPath).height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
//        DetailMachineVc.synth.show(from: self)
        if let objs = controller.fetchedObjects , objs.count > 0 {
            
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "DetailMachineVc", sender: item)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailMachineVc" {
            if let destination = segue.destination as? DetailMachineVc {
                if let machine = sender as? Machine {
                    destination.machineToEdit = machine
                }
            }
        }
        
    }
}
