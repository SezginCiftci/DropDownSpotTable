//
//  SectionData.swift
//  DropDownSpotTable
//
//  Created by Sezgin Çiftci on 27.12.2021.
//

import Foundation
import UIKit

struct SectionData {
    
    var open: Bool
    var data: [CellData]
}

struct CellData {
    var title: String
    var featureImage: UIImage
}
