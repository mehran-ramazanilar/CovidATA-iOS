//
//  WorldHistoricalDataModel.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/8/20.
//

import SwiftUI

// MARK: - Global Historical Data Model

struct WorldHistoricalDataModel: Codable {
    let cases: [String : Int]
    let deaths: [String : Int]
    let recovered: [String : Int]
}
