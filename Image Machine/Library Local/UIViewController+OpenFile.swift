//
//  UIViewController+OpenFile.swift
//  Digischool Dev
//
//  Created by Ridwan Surya Putra on 10/29/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation
import UIKit
import Toaster

var openFileHandler = OpenFileHandler()

extension UIViewController {
    
    func openFile(callback: ((Data)-> Void)?){
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: .import)
        
        documentPicker.delegate = openFileHandler
        present(documentPicker, animated: true, completion: nil)
    }

}

class OpenFileHandler: UIViewController, UIDocumentPickerDelegate {

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let cico = url as URL
        var fileData : Data!
        print("1: \(cico)")
        print("2: \(url)")
        print("3: \(url.lastPathComponent)")
        print("4: \(url.pathExtension)")
        
        if FileManager.default.fileExists(atPath: cico.path){
            do {
                fileData = try Data(contentsOf: cico)
                let userDefault = UserDefaults(suiteName: "com.idesolusiasia")
                userDefault?.set(fileData, forKey: "fileData")
                userDefault?.synchronize()
                for el in (userDefault?.dictionaryRepresentation())!{
                    print(el.key)
                }
                let result = userDefault?.value(forKey: "fileData") as? Data;
                //                if let res2 = result { print("data type : \(type(of: res2))"); }
                print("data image: \(result?.string ?? "nil")")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
