//
//  WorldChartDataModel.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/12/20.
//

import SwiftUI
import SwiftUICharts

// MARK: - World Chart Data Model

struct WorldChartDataModel: Identifiable {
    let id = UUID()
    var type: String
    var legend: String
    var Style: ChartStyle
    var data: [Double]
}
