//
//  WorldTodayDataModel.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/12/20.
//

import SwiftUI

// MARK: - Today's data model

struct WorldTodayDataModel: Identifiable {
    let id = UUID()
    let title: String
    var value: Int
}
