//
//  CountryHistoricalDataModel.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/8/20.
//

import SwiftUI

// MARK: - Country Historical Data Model

struct CountryHistoricalDataModel: Codable {
    let country: String
    let province: [String]
    let timeline: CountryHistoricalTimeLineDataModel
    
}

struct CountryHistoricalTimeLineDataModel: Codable {
    let cases: [String : Int]
    let deaths: [String : Int]
    let recovered: [String : Int]
}
