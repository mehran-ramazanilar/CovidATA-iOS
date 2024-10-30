//
//  ProtectionCardsData.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/7/20.
//

import SwiftUI

// MARK: - Protection Cards Data

class ProtectionCardsData {
    var data: [ProtectionCardModel] = [
        ProtectionCardModel(title: "Wash your hands", body: "Clean your hands often. Use soap and water, or an alcohol-based hand rub.", imageName: "washHands"),
        ProtectionCardModel(title: "Social distance", body: "Maintain at least a two meter distance between yourself and others.", imageName: "socialDistance"),
        ProtectionCardModel(title: "Always wear masks", body: "Make wearing a mask a normal part of being around other people.", imageName: "wearMask"),
        ProtectionCardModel(title: "No touching", body: "Don't touch your eyes, mouth and nose.", imageName: "noTouching"),
        ProtectionCardModel(title: "Cover your sneeze", body: "Cover your nose and mouth with your bent elbow or tissue when you cough or sneeze.", imageName: "coverNose")
    ]
}
