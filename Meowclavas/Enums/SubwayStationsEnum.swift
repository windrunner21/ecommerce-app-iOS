//
//  SubwayStationsEnum.swift
//  Meowclavas
//
//  Created by Imran on 27.12.21.
//

import Foundation

enum SubwayStations: String, CaseIterable, Identifiable {
    case elmler = "Elmler Akademiyasi"
    case nizami = "Nizami"
    case may28 = "28 May"
    case ganjlik = "Ganjlik"
    case narimanov = "Narimanov Narimanov"
    case ulduz = "Ulduz"
    case koroglu = "Koroglu"
    case qarayev = "Qara Qarayev"
    case neftchilar = "Neftchilar"
    case xalqlar = "Xalqlar Dostlugu"
    case ahmadli = "Ahmadli"
    case aslanov = "Hazi Aslanov"
    
    var id: String { self.rawValue }
}
