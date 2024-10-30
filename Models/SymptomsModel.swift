//
//  SymptomsModel.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/11/20.
//

import SwiftUI

// MARK: - Symptoms page data model

struct SymptomsDataModel: Identifiable {
    let id = UUID()
    let title: String
    let body: String?
    let percent: Double
}
