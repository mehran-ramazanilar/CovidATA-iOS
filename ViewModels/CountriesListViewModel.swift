//
//  CountriesListViewModel.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/1/20.
//

import SwiftUI

class CountriesListViewModel: ObservableObject {
    @Published var data: [CountriesListModel]
    
    init() {
        let decoder = JSONDecoder()
           guard
                let url = Bundle.main.url(forResource: "countries", withExtension: "json"),
                let data = try? Data(contentsOf: url),
                let countries = try? decoder.decode([CountriesListModel].self, from: data)
           else {
            self.data = []
            return
           }
        self.data = countries
    }
}
