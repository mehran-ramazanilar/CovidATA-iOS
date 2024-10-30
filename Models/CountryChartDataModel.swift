//
//  CountryChartDataModel.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/9/20.
//

import SwiftUI
import SwiftUICharts

struct CountryChartDataModel: Identifiable {
    let id = UUID()
    var type: String
    var legend: String
    var Style: ChartStyle
    var data: [Double]
}
