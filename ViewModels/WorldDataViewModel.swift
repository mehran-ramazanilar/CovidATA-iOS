//
//  WorldDataViewModel.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 11/30/20.
//

import SwiftUI
import SwiftUICharts

// MARK: - ViewModel for the WorldData model

class WorldDataViewModel: ObservableObject {
    private var confirmedChartStyle = ChartStyle(backgroundColor: Color(.secondarySystemBackground), accentColor: Color(.systemYellow), gradientColor: GradientColor(start: Color(.systemYellow), end: Color(hex: "#ffd166")), textColor: Color(.label), legendTextColor: Color(.secondaryLabel), dropShadowColor: .white)
    private var recoveredChartStyle = ChartStyle(backgroundColor: Color(.secondarySystemBackground), accentColor: Color(.systemGreen), gradientColor: GradientColor(start: Color(.systemGreen), end: Color(hex: "#06d6a0")), textColor: Color(.label), legendTextColor: Color(.secondaryLabel), dropShadowColor: .black)
    private var deathChartStyle = ChartStyle(backgroundColor: Color(.secondarySystemBackground), accentColor: Color(.systemRed), gradientColor: GradientColor(start: Color(.systemRed), end: Color(hex: "#ef476f")), textColor: Color(.label), legendTextColor: Color(.secondaryLabel), dropShadowColor: .black)
    
    @Published var data: WorldDataModel = WorldDataModel(updated: 0, cases: 0, todayCases: 0, deaths: 0, todayDeaths: 0, recovered: 0, todayRecovered: 0, active: 0, critical: 0, casesPerOneMillion: 0, deathsPerOneMillion: 0, tests: 0, testsPerOneMillion: 0, population: 0, oneCasePerPeople: 0, oneDeathPerPeople: 0, oneTestPerPeople: 0, activePerOneMillion: 0, recoveredPerOneMillion: 0, criticalPerOneMillion: 0, affectedCountries: 0)
    @Published var cards: [HomeSceneCardModel] = []
    @Published var population: Int = 7792052165
    @Published var todaysInfo: [WorldTodayDataModel] = [
        WorldTodayDataModel(title: "Today's cases", value: 0),
        WorldTodayDataModel(title: "Today's recovered", value: 0),
        WorldTodayDataModel(title: "Today's deaths", value: 0)
    ]
    @Published var otherStats: [HomeSceneCardModel] = [
        HomeSceneCardModel(title: "Critical Cases", icon: "", value: 0, perMillion: 0, color: "", isAnime: true),
        HomeSceneCardModel(title: "Tested People", icon: "", value: 0, perMillion: 0, color: "", isAnime: true),
    ]
    @Published var chartData: [WorldChartDataModel]
    
    init() {
        chartData = [
            WorldChartDataModel(type: "Confirmed cases for the last ", legend: "", Style: confirmedChartStyle, data: [0, 0, 0, 0, 0, 0, 0]),
            WorldChartDataModel(type: "Recovered cases for the last ", legend: "", Style: recoveredChartStyle, data: [0, 0, 0, 0, 0, 0, 0]),
            WorldChartDataModel(type: "Death cases for the last ", legend: "", Style: deathChartStyle, data: [0, 0, 0, 0, 0, 0, 0])
        ]
        self.setCardsData(data: data, isAnime: false)
    }
    
    var recovered: String {
        return "\(self.data.recovered)"
    }
    
    func fetchWorldData() {
        let urlStr = "https://corona.lmao.ninja/v2/all?yesterday="
        guard let url = URL(string: urlStr) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if (error != nil) {
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        // set Model data
                        let jsonData = try! JSONDecoder().decode(WorldDataModel.self, from: data!)
                        self.data = jsonData
                        UserDefaults.standard.set(jsonData.population, forKey: APP_DEFAULT_VALUES.WORLD_POPULATION)
                        // set population
                        self.population = jsonData.population
                        // set today's info
                        self.todaysInfo[0].value = self.data.todayCases
                        self.todaysInfo[1].value = self.data.todayRecovered
                        self.todaysInfo[2].value = self.data.todayDeaths
                        // set other stats
                        self.otherStats[0].value = self.data.critical
                        self.otherStats[0].perMillion = self.data.criticalPerOneMillion
                        self.otherStats[1].value = self.data.tests
                        self.otherStats[1].perMillion = self.data.testsPerOneMillion
                        // set cards data
                        self.setCardsData(data: jsonData, isAnime: true)
                    } else {
                        return
                    }
                }
            }
        }.resume()
    }
    
    func setCardsData(data: WorldDataModel, isAnime: Bool) {
        let card1 = HomeSceneCardModel(title: "Confirmed", icon: "bacteria", value: data.cases, perMillion: data.casesPerOneMillion, color: "#FFD166", isAnime: isAnime)
        let card2 = HomeSceneCardModel(title: "Recovered", icon: "heart", value: data.recovered, perMillion: data.recoveredPerOneMillion, color: "#06D6A0", isAnime: isAnime)
        let card3 = HomeSceneCardModel(title: "Death", icon: "death", value: data.deaths, perMillion: data.deathsPerOneMillion, color: "#EF476F", isAnime: isAnime)
        let card4 = HomeSceneCardModel(title: "Active", icon: "mask", value: data.active, perMillion: data.activePerOneMillion, color: "#118AB2", isAnime: isAnime)
        let array = [card1, card2, card3, card4]
        self.cards = array
    }
    
    func fetchGlobalDataForDays(days: Int) {
        let urlStr = CONST_URLS.JHUCSSE_GLOBAL_HISTORICAL + "\(days)"
        guard let url = URL(string: urlStr) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if (error != nil) {
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        // set Model data
                        let jsonData = try! JSONDecoder().decode(WorldHistoricalDataModel.self, from: data!)
                        self.parseGlobalHistoricalData(data: jsonData, days: days)
                    } else {
                        return
                    }
                }
                
            }
        }.resume()
    }
    
    func parseGlobalHistoricalData(data: WorldHistoricalDataModel, days: Int) {
        var casesAtFirst = 0
        var cases = 0
        var recoveredAtFirst = 0
        var recovered = 0
        var deathAtFirst = 0
        var death = 0
        var active = 0
        var index = 0
        let sortedCasesDict = data.cases.sorted { $0.1 < $1.1 }
        for (_, value) in sortedCasesDict {
            if (index == 0) {
                casesAtFirst = value
            }
            if (index == (days - 1)) {
                cases = value
            }
            index = index + 1
        }
        cases = cases - casesAtFirst
        index = 0
        let sortedDeathDict = data.deaths.sorted { $0.1 < $1.1 }
        for (_, value) in sortedDeathDict {
            if (index == 0) {
                deathAtFirst = value
            }
            if (index == (days - 1)) {
                death = value
            }
            index = index + 1
        }
        death = death - deathAtFirst
        index = 0
        let sortedRecoveredDict = data.recovered.sorted { $0.1 < $1.1 }
        for (_, value) in sortedRecoveredDict {
            if (index == 0) {
                recoveredAtFirst = value
            }
            if (index == (days - 1)) {
                recovered = value
            }
            index = index + 1
        }
        recovered = recovered - recoveredAtFirst
        active = cases - (death + recovered)
        let casesPerMillion = self.getPersonPerOneMillion(count: cases)
        let recoveredPerMillion = self.getPersonPerOneMillion(count: recovered)
        let deathPerMillion = self.getPersonPerOneMillion(count: death)
        let activePerMillion = self.getPersonPerOneMillion(count: active)
        let worldData: WorldDataModel = WorldDataModel(updated: 0, cases: cases, todayCases: 0, deaths: death, todayDeaths: 0, recovered: recovered, todayRecovered: 0, active: active, critical: 0, casesPerOneMillion: Double(casesPerMillion), deathsPerOneMillion: Double(deathPerMillion), tests: 0, testsPerOneMillion: 0, population: 0, oneCasePerPeople: 0, oneDeathPerPeople: 0, oneTestPerPeople: 0, activePerOneMillion: Double(activePerMillion), recoveredPerOneMillion: Double(recoveredPerMillion), criticalPerOneMillion: 0, affectedCountries: 0)
        self.setCardsData(data: worldData, isAnime: true)
    }
    
    func getPersonPerOneMillion(count: Int) -> Int {
        let perMillion: Int = (1000000 * count) / self.population
        return perMillion
    }
    
    func fetchGlobalChartDataForDays(days: Int) {
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
        let urlStr = CONST_URLS.JHUCSSE_GLOBAL_HISTORICAL + "\(days)"
        guard let url = URL(string: urlStr) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if (error != nil) {
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        // set Model data
                        let jsonData = try! JSONDecoder().decode(WorldHistoricalDataModel.self, from: data!)
                        self.parseGlobalChartData(data: jsonData, legendStr: legendStr)
                    } else {
                        return
                    }
                }
                
            }
        }.resume()
    }
    
    func parseGlobalChartData(data: WorldHistoricalDataModel, legendStr: String) {
        let casesArr = data.cases.sorted( by: { $0.1 < $1.1 })
        var casesChartData: [Double] = []
        let recoveredArr = data.recovered.sorted( by: { $0.1 < $1.1 })
        var recoveredChartData: [Double] = []
        let deathsArr = data.deaths.sorted( by: { $0.1 < $1.1 })
        var deathsChartData: [Double] = []
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
    }
    
}

