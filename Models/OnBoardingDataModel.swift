//
//  OnBoardingDataModel.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/12/20.
//

import SwiftUI

// MARK: - OnBoarding data model

struct OnBoardingDataModel: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let body: String
}
