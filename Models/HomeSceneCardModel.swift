//
//  HomeSceneCardModel.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/2/20.
//

import SwiftUI

struct HomeSceneCardModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let icon: String
    var value: Int
    var perMillion: Double
    let color: String
    var isAnime: Bool
}
