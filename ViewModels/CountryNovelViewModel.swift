//
//  CountryNovelViewModel.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/3/20.
//

import SwiftUI

class CountryNovelDataModel: ObservableObject {
    @Published var countriesList: [CountryDataModel] = []
    
    init() {
        self.fetchNovelCountriesData()
    }
    
    func fetchNovelCountriesData() {
        
        let urlStr = "https://corona.lmao.ninja/v2/countries?yesterday=false&sort="
        guard let url = URL(string: urlStr) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if (error != nil) {
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    if (httpResponse.statusCode == 200) {
                        // set Model data
                        let jsonData = try! JSONDecoder().decode([CountryDataModel].self, from: data!)
                        self.countriesList = jsonData
                    } else {
                        return
                    }
                }
                
            }
        }.resume()
        
    }
}
