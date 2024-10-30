//
//  ProtectionCardModel.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/7/20.
//

import SwiftUI

// MARK: - Protection Card Model

struct ProtectionCardModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let body: String
    let imageName: String
}
