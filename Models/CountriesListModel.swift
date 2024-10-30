//
//  CountriesListModel.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/1/20.
//

import SwiftUI

// MARK: - Model for the countries json file

struct CountriesListModel: Codable, Hashable {
    let Country: String
    let Slug: String
    let ISO2: String
    let latlng: [Double]
}
