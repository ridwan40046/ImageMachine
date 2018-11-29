//
//  Randomizer.swift
//  Digischool Dev
//
//  Created by Martin Tjandra on 22/10/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation
import UIKit

class Randomizer {
    
    enum Gender { case male; case female; case both; }
    
    static private var maleFirstName = [
        "Adi", "Budi", "Charlie", "Dedi", "Fathur", "Galuh", "Hafidz", "Igo", "Jamal",
        "Bambang", "Iman", "Winardi", "Guntur", "Susilo", "Suratman", "Eko", "Agung", "Rudi", "Slamet", "Hengki", "Eli", "Tirto"
    ];
    
    static private var maleMiddleName = [
        "Eka", "Dwi", "Tri"
    ];
    
    static private var maleLastName = [
        "Gunawan", "Setiawan", "Kusuma", "Raharjo", "Purnama", "Tanuwidjaja"
    ];
    
    static private var femaleFirstName = [
        "Dian", "Wangi", "Susanti", "Verawati", "Dewi", "Putri", "Wulan", "Sriningsih", "Vera", "Erlin", "Yenny"
    ];
    
    static private var femaleMiddleName = [
        "Eka", "Dwi", "Tri"
    ];
    
    static private var femaleLastName = [
        "Santoso", "Atmadjaja", "Budiono"
    ];
    
    static private var emailDomain = [
        "yahoo.com", "gmail.com", "outlook.com"
    ];
    
    static func name (gender: Gender = .both) -> String {
        var g = gender;
        if g == .both { g = arc4random()%2 == 0 ? .male : .female; }
        if g == .male {
            let res = maleFirstName.randomItem! + " " +
                (arc4random()%2 == 0 ? maleMiddleName.randomItem! + " " : "") +
                (arc4random()%2 == 0 ? maleLastName.randomItem! + " " : "");
            return res;
        }
        else {
            let res = femaleFirstName.randomItem! + " " +
                (arc4random()%2 == 0 ? femaleMiddleName.randomItem! + " " : "") +
                (arc4random()%2 == 0 ? femaleLastName.randomItem! + " " : "");
            return res;
        }
    }
    
    static func nisn() -> String {
        return "\(arc4random()%1000000 + 1000000)";
    }
    
    static func email() -> String {
        return name().split(separator: " ").joined(separator: ".") + "@" + emailDomain.randomItem!;
    }
    
}
