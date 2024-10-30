//
//  CountryDetailViewModel.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/8/20.
//

import SwiftUI
import MapKit
import SwiftUICharts

class CountryDetailViewModel: ObservableObject {
    private var confirmedChartStyle = ChartStyle(backgroundColor: .white, accentColor: Color(.systemYellow), gradientColor: GradientColor(start: Color(.systemYellow), end: Color(hex: "#ffd166")), textColor: Color(.label), legendTextColor: Color(.secondaryLabel), dropShadowColor: .white)
    private var recoveredChartStyle = ChartStyle(backgroundColor: .clear, accentColor: Color(.systemGreen), gradientColor: GradientColor(start: Color(.systemGreen), end: Color(hex: "#06d6a0")), textColor: Color(.label), legendTextColor: Color(.secondaryLabel), dropShadowColor: .black)
    private var deathChartStyle = ChartStyle(backgroundColor: .clear, accentColor: Color(.systemRed), gradientColor: GradientColor(start: Color(.systemRed), end: Color(hex: "#ef476f")), textColor: Color(.label), legendTextColor: Color(.secondaryLabel), dropShadowColor: .black)
    private var activeChartStyle = ChartStyle(backgroundColor: .clear, accentColor: Color(.systemBlue), gradientColor: GradientColor(start: Color(.systemBlue), end: Color(hex: "#118ab2")), textColor: Color(.label), legendTextColor: Color(.secondaryLabel), dropShadowColor: .black)
    
    @Published var countryCards: [HomeSceneCardModel] = []
    @Published var population: Int = 7792052165
    @Published var chartData: [CountryChartDataModel]
    
    init() {
        let initAnnotation = CountryAnnotation(title: "", subtitle: "", coordinate: CLLocationCoordinate2D(latitude: 38, longitude: 25), flag: "", iso2: "", cases: 0, active: 0, death: 0, recovered: 0, casesPerMillion: 0, activePerMillion: 0, deathPerMillion: 0, recoveredPerMillion: 0)
        population = UserDefaults.standard.integer(forKey: APP_DEFAULT_VALUES.WORLD_POPULATION)
        chartData = [
            CountryChartDataModel(type: "Confirmed cases for the last ", legend: "", Style: confirmedChartStyle, data: [0, 0, 0, 0, 0, 0, 0]),
            CountryChartDataModel(type: "Recovered cases for the last ", legend: "", Style: recoveredChartStyle, data: [0, 0, 0, 0, 0, 0, 0]),
            CountryChartDataModel(type: "Death cases for the last ", legend: "", Style: deathChartStyle, data: [0, 0, 0, 0, 0, 0, 0]),
            CountryChartDataModel(type: "Active cases for the last ", legend: "", Style: activeChartStyle, data: [0, 0, 0, 0, 0, 0, 0])
        ]
        setDataFromAnnotationData(annotation: initAnnotation, isAnime: true)
    }
    
    func setDataFromAnnotationData(annotation: CountryAnnotation, isAnime: Bool) {
        let card1 = HomeSceneCardModel(title: "Confirmed", icon: "bacteria", value: annotation.cases!, perMillion: annotation.casesPerMillion!, color: "#FFD166", isAnime: isAnime)
        let card2 = HomeSceneCardModel(title: "Recovered", icon: "health-care", value: annotation.recovered!, perMillion: annotation.recoveredPerMillion!, color: "#06D6A0", isAnime: isAnime)
        let card3 = HomeSceneCardModel(title: "Death", icon: "death", value: annotation.death!, perMillion: annotation.deathPerMillion!, color: "#EF476F", isAnime: isAnime)
        let card4 = HomeSceneCardModel(title: "Active", icon: "mask", value: annotation.active!, perMillion: annotation.activePerMillion!, color: "#118AB2", isAnime: isAnime)
        let array = [card1, card2, card3, card4]
        self.countryCards = array
    }
    
    func fetchCountryDataForDays(days: Int, iso2: String, annotation: CountryAnnotation) {
        
        let urlStr = CONST_URLS.JHUCSSE_COUNTRY_HISTORICAL + iso2 + "?lastdays=\(days)"
        var legendStr = ""
        switch days {
        case 8:
            legendStr = "7 days."
        case 15:
            legendStr = "14 days."
        case 31:
            legendStr = "30 days."
        default:
            legendStr = ""
        }
        guard let url = URL(string: urlStr) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if (error != nil) {
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        // set Model data
                        let jsonData = try! JSONDecoder().decode(CountryHistoricalDataModel.self, from: data!)
        //                self.parseCountryHistoricalData(data: jsonData, days: days, annotation: annotation)
                        self.parseChartData(data: jsonData, legendStr: legendStr)
                    } else {
                        return
                    }
                }
                
            }
        }.resume()
        
    }
    
//    func parseCountryHistoricalData(data: CountryHistoricalDataModel, days: Int, annotation: CountryAnnotation) {
//        var casesAtFirst = 0
//        var cases = 0
//        var recoveredAtFirst = 0
//        var recovered = 0
//        var deathAtFirst = 0
//        var death = 0
//        var active = 0
//        var index = 0
//        let sortedCasesDict = data.timeline.cases.sorted { $0.1 < $1.1 }
//        for (_, value) in sortedCasesDict {
//            if (index == 0) {
//                casesAtFirst = value
//            }
//            if (index == (days - 1)) {
//                cases = value
//            }
//            index = index + 1
//        }
//        cases = cases - casesAtFirst
//        index = 0
//        let sortedDeathDict = data.timeline.deaths.sorted { $0.1 < $1.1 }
//        for (_, value) in sortedDeathDict {
//            if (index == 0) {
//                deathAtFirst = value
//            }
//            if (index == (days - 1)) {
//                death = value
//            }
//            index = index + 1
//        }
//        death = death - deathAtFirst
//        index = 0
//        let sortedRecoveredDict = data.timeline.recovered.sorted { $0.1 < $1.1 }
//        for (_, value) in sortedRecoveredDict {
//            if (index == 0) {
//                recoveredAtFirst = value
//            }
//            if (index == (days - 1)) {
//                recovered = value
//            }
//            index = index + 1
//        }
//        recovered = recovered - recoveredAtFirst
//        active = cases - (death + recovered)
//        let casesPerMillion = self.getPersonPerOneMillion(count: cases)
//        let recoveredPerMillion = self.getPersonPerOneMillion(count: recovered)
//        let deathPerMillion = self.getPersonPerOneMillion(count: death)
//        let activePerMillion = self.getPersonPerOneMillion(count: active)
//        let countryData = CountryAnnotation(title: annotation.title, subtitle: annotation.subtitle, coordinate: annotation.coordinate, flag: annotation.flag, iso2: annotation.iso2, cases: cases, active: active, death: death, recovered: recovered, casesPerMillion: Double(casesPerMillion), activePerMillion: Double(activePerMillion), deathPerMillion: Double(deathPerMillion), recoveredPerMillion: Double(recoveredPerMillion))
//        self.setDataFromAnnotationData(annotation: countryData, isAnime: true)
//    }
    
    func getPersonPerOneMillion(count: Int) -> Int {
        let perMillion: Int = (1000000 * count) / self.population
        return perMillion
    }
    
    func parseChartData(data: CountryHistoricalDataModel, legendStr: String) {
//        let casesArr = data.timeline.cases.sorted( by: { $0.0 < $1.0 })
        let casesArr = data.timeline.cases.sorted( by: { $0.1 < $1.1 })
        var casesChartData: [Double] = []
        let recoveredArr = data.timeline.recovered.sorted( by: { $0.1 < $1.1 })
        var recoveredChartData: [Double] = []
        let deathsArr = data.timeline.deaths.sorted( by: { $0.1 < $1.1 })
        var deathsChartData: [Double] = []
        var activeChartData: [Double] = []
        var arrIndex = 0
        var tempVal: Double = 0
        // cases data
        for (_, value) in casesArr {
            if (arrIndex == 0) {
                tempVal = Double(value)
            }
            else {
                let temp = Double(value) - tempVal
                casesChartData.append(temp)
                tempVal = Double(value)
            }
            arrIndex = arrIndex + 1
        }
        arrIndex = 0
        self.chartData[0].data = casesChartData
        self.chartData[0].legend = self.chartData[0].type + legendStr
        // recovered data
        for (_, value) in recoveredArr {
            if (arrIndex == 0) {
                tempVal = Double(value)
            }
            else {
                let temp = Double(value) - tempVal
                recoveredChartData.append(temp)
                tempVal = Double(value)
            }
            arrIndex = arrIndex + 1
        }
        arrIndex = 0
        self.chartData[1].data = recoveredChartData
        self.chartData[1].legend = self.chartData[1].type + legendStr
        // deaths data
        for (_, value) in deathsArr {
            if (arrIndex == 0) {
                tempVal = Double(value)
            }
            else {
                let temp = Double(value) - tempVal
                deathsChartData.append(temp)
                tempVal = Double(value)
            }
            arrIndex = arrIndex + 1
        }
        arrIndex = 0
        self.chartData[2].data = deathsChartData
        self.chartData[2].legend = self.chartData[2].type + legendStr
        // active data
        for (index, _) in casesChartData.enumerated() {
            let sum = deathsChartData[index] + recoveredChartData[index]
            let active = casesChartData[index] - sum
            activeChartData.append(active)
        }
        self.chartData[3].data = activeChartData
        self.chartData[3].legend = self.chartData[3].type + legendStr
    }
    
}
