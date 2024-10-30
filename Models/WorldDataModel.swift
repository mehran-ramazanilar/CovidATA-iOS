//
//  WorldDataModel.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 11/30/20.
//

import SwiftUI

// MARK: - Model for global data

struct WorldDataModel: Codable {
    let updated: Int
    let cases: Int
    let todayCases: Int
    let deaths: Int
    let todayDeaths: Int
    let recovered: Int
    let todayRecovered: Int
    let active: Int
    let critical: Int
    let casesPerOneMillion: Double
    let deathsPerOneMillion: Double
    let tests: Int
    let testsPerOneMillion: Double
    let population: Int
    let oneCasePerPeople: Double
    let oneDeathPerPeople: Double
    let oneTestPerPeople: Double
    let activePerOneMillion: Double
    let recoveredPerOneMillion: Double
    let criticalPerOneMillion: Double
    let affectedCountries: Int
}
