//
//  CountryDataModel.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/1/20.
//

import SwiftUI

// MARK: - Model for a specific country
struct CountryDataModel: Codable, Hashable {
    let updated: Int
    let country: String
    let countryInfo: CountryInfo
    let cases, todayCases, deaths, todayDeaths: Int
    let recovered, todayRecovered, active, critical: Int
    let tests: Int
    let population: Int
    let continent: String
    let oneCasePerPeople, oneDeathPerPeople, oneTestPerPeople, testsPerOneMillion, casesPerOneMillion, deathsPerOneMillion: Double
    let activePerOneMillion, recoveredPerOneMillion, criticalPerOneMillion: Double
}

// MARK: - CountryInfo
struct CountryInfo: Codable, Hashable {
    let id: Int?
    let iso2, iso3: String?
    let lat, long: Double
    let flag: String
}
