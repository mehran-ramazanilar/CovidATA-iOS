//
//  CountryListView.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/1/20.
//

import SwiftUI
import MapKit

struct CountryListView: View {
    
    // MARK: - Properties
    
    @Binding var countriesData: [CountryDataModel]
    @State private var searchText: String = ""
    @State var isModal: Bool = false
    @State var selectedPin: CountryAnnotation?
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { geometry in
            Color("mainBackgroundColor")
            VStack(alignment: .center, spacing: 0, content: {
                
                SearchBar(text: $searchText)
                    .padding(.horizontal, 8)
                    .padding(.top, 8)
                
                ScrollView {
                    LazyVStack {
                        ForEach(countriesData.filter { $0.country.lowercased().contains(searchText.lowercased()) || searchText.isEmpty }, id:\.self) { country in
                            
                            if (country.countryInfo.iso2 != nil) {
                                HStack {
                                    Text(country.country)
                                        .font(.custom("SFPro-Semibold", size: 17))
                                        .padding(.vertical, 8)
                                    Spacer()
                                    
                                    HStack {
                                        Spacer(minLength: 0)
                                        
                                        Text("\(country.cases)")
                                            .font(.custom("Stolzl-Regular", size: 15))
                                            .foregroundColor(Color(.systemBackground))
                                        
                                        Spacer(minLength: 0)
                                        
                                        Image("bacteria")
                                            .renderingMode(.template)
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color(.systemBackground))
                                        
                                    } // HStack
                                    .frame(minWidth: geometry.size.width / 3.5, maxWidth: geometry.size.width / 3.5, alignment: .center)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color("appCardColorYellow"))
                                    .clipShape(RoundedRectangle.init(cornerRadius: 15 ))
                                    
//                                    Text("\(country.cases)")
//                                        .frame(minWidth: geometry.size.width / 4, maxWidth: geometry.size.width / 4, alignment: .center)
//                                        .font(.custom("Stolzl-Regular", size: 15))
//                                        .foregroundColor(Color(.systemBackground))
//                                        .padding(.horizontal, 16)
//                                        .padding(.vertical, 8)
//                                        .background(Color("appCardColorYellow"))
//                                        .clipShape(RoundedRectangle.init(cornerRadius: 15 ))
                                        
                                } // HStack
                                .contentShape(Rectangle())
                                .padding(.vertical, 8)
                                .onTapGesture(perform: {
                                    self.selectedPin = CountryAnnotation(title: country.country, subtitle: nil, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), flag: country.countryInfo.flag, iso2: country.countryInfo.iso2, cases: country.cases, active: country.active, death: country.deaths, recovered: country.recovered, casesPerMillion: country.casesPerOneMillion, activePerMillion: country.activePerOneMillion, deathPerMillion: country.deathsPerOneMillion, recoveredPerMillion: country.recoveredPerOneMillion)
                                    self.isModal = true
                                })
                                .sheet(isPresented: $isModal, content: {
                                    CountryDetail(selectedCountry: $selectedPin)
                                })
                                
                                Divider()
                            }
                            
                            
                        } // ForEach
                    } // LazyStack
                } // ScrollView
                .padding(.horizontal)
            }) // VStack
        } // GeometryReader
    }
}

// MARK: - Preview

//struct CountryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CountryListView()
//    }
//}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search Country"
        
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }

}
