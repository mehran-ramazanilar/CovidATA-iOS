//
//  SymptomsData.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/11/20.
//

import SwiftUI

// MARK: - Symptoms Data

class SymptomsData {
    var commonSymptoms: [SymptomsDataModel] = [
        SymptomsDataModel(title: "Fever", body: "Having a continuous increase in body temperature.", percent: 99),
        SymptomsDataModel(title: "Fatigue", body: "Feeling overtired, with low energy and a desire to sleep.", percent: 71)
    ]
    
    var otherCommonSymptoms: [SymptomsDataModel] = [
        SymptomsDataModel(title: "Dry cough", body: nil, percent: 59),
        SymptomsDataModel(title: "Loss of appetite", body: nil, percent: 40),
        SymptomsDataModel(title: "Body aches", body: nil, percent: 35),
        SymptomsDataModel(title: "Shortness of breath", body: nil, percent: 31),
        SymptomsDataModel(title: "Mucus or phlegm", body: nil, percent: 27)
    ]
    
    var probableSymptoms: [SymptomsDataModel] = [
        SymptomsDataModel(title: "Sore throat", body: nil, percent: 54.0),
        SymptomsDataModel(title: "Headache", body: nil, percent: 50.2),
        SymptomsDataModel(title: "Chills, sometimes with shaking", body: nil, percent: 48.8),
        SymptomsDataModel(title: "Loss of smell or taste", body: nil, percent: 41.0),
        SymptomsDataModel(title: "Congestion or runny nose", body: nil, percent: 34.4),
        SymptomsDataModel(title: "Nausea or vomiting", body: nil, percent: 44),
        SymptomsDataModel(title: "Diarrhea", body: nil, percent: 41)
    ]
    
    var emergencySymptoms: [SymptomsDataModel] = [
        SymptomsDataModel(title: "Trouble breathing", body: nil, percent: 54.0),
        SymptomsDataModel(title: "Chest pain or pressure", body: nil, percent: 50.2),
        SymptomsDataModel(title: "Loss of speech or movement", body: nil, percent: 48.8)
    ]
}
