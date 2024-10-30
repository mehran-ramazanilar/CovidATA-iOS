//
//  CountryDetail.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/5/20.
//

import SwiftUI
import KingfisherSwiftUI
import SwiftUICharts

struct CountryDetail: View {
    // MARK: - Properties
    @State private var selectedSegment = 0
    @State private var selectedSegmentStrings = ["7 Days", "14 Days", "30 Days"]
    @State var currentViewIndex = 0
    @Binding var selectedCountry: CountryAnnotation?
    @ObservedObject var countryViewModel = CountryDetailViewModel()
    @State var isCardsDataSete = false
    // MARK: - Body
    var body: some View {
        
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 16, content: {
                HStack(alignment: .center, spacing: 0, content: {
                    Spacer(minLength: 0)
                    VStack(alignment: .center, spacing: 8, content: {
                        KFImage(URL(string: (self.selectedCountry?.flag)!))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 27)
                            .clipped()
                            .cornerRadius(8)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.7), radius: 6, x: 0, y: 0)
                        Text((self.selectedCountry?.title)!)
                            .font(.custom("Stolzl-Regular", size: 20))
                            .foregroundColor(Color(.white))
                    }) // VStack
                    Spacer(minLength: 0)
                }) // HStack
//                .padding(.top, geometry.safeAreaInsets.top)
                .padding(.vertical, 16)
                .background(Color("appCardColorDarkCyan"))
                .cornerRadius(28, corners: [.bottomLeft, .bottomRight])
                
                HStack(alignment: .center, spacing: 0, content: {
                    Text(self.currentViewIndex > 3 ? self.countryViewModel.countryCards[currentViewIndex - 4].title : self.countryViewModel.countryCards[currentViewIndex].title)
                        .font(.custom("SFPro-Bold", size: 24))
                        .foregroundColor(self.currentViewIndex > 3 ? Color(hex: self.countryViewModel.countryCards[currentViewIndex - 4].color) : Color(hex: self.countryViewModel.countryCards[currentViewIndex].color))
                    
                    Spacer()
                    
                    Picker(selection: $selectedSegment, label: HStack{
                        Text(selectedSegmentStrings[self.selectedSegment])
                        Image(systemName: "chevron.down")
                            .imageScale(.small)
                    }) {
                        Text(selectedSegmentStrings[0]).tag(0)
                        Text(selectedSegmentStrings[1]).tag(1)
                        Text(selectedSegmentStrings[2]).tag(2)
                    }
                    .pickerStyle(MenuPickerStyle())
                    .clipShape(Rectangle())
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color("appCardColorDarkCyan"))
                    .font(.custom("Stolzl-Book", size: 15))
                    .foregroundColor(Color(.white))
                    .cornerRadius(15)
                    .onChange(of: self.selectedSegment, perform: { value in
                        self.isCardsDataSete = false
                        if (self.selectedSegment == 0) {
                            self.countryViewModel.fetchCountryDataForDays(days: 8, iso2: (self.selectedCountry?.iso2)!, annotation: self.selectedCountry!)
                            self.isCardsDataSete = true
                        }
                        if (self.selectedSegment == 1) {
                            self.countryViewModel.fetchCountryDataForDays(days: 15, iso2: (self.selectedCountry?.iso2)!, annotation: self.selectedCountry!)
                            self.isCardsDataSete = true
                        }
                        if (self.selectedSegment == 2) {
                            self.countryViewModel.fetchCountryDataForDays(days: 31, iso2: (self.selectedCountry?.iso2)!, annotation: self.selectedCountry!)
                            self.isCardsDataSete = true
                        }
                    })
                }) // HStack
                .padding(.horizontal)
                
                GeometryReader { vStackGeometry in
                    VStack(alignment: .center, spacing: 16, content: {
                        
                        LineView(data: (self.currentViewIndex > 3 ? self.countryViewModel.chartData[currentViewIndex - 4].data : self.countryViewModel.chartData[currentViewIndex].data), title: (UIScreen.main.bounds.height == 667 ? nil : ""), legend: (self.currentViewIndex > 3 ? self.countryViewModel.chartData[currentViewIndex - 4].legend : self.countryViewModel.chartData[currentViewIndex].legend), style: (self.currentViewIndex > 3 ? self.countryViewModel.chartData[currentViewIndex - 4].Style : self.countryViewModel.chartData[currentViewIndex].Style))
                            .padding(.horizontal)
//                            .padding(.vertical, 0)
                        
                        Spacer(minLength: 0)
                        
                        if (UIScreen.main.bounds.height > 667) {
                            Text("Country's total Info")
                                .font(.custom("Stolzl-Regular", size: 20))
                                .foregroundColor(Color("appCardColorDarkCyan"))
                        }
                        
                        if (self.isCardsDataSete == true) {
                            CarouselView(currentViewNum: $currentViewIndex, itemHeight: vStackGeometry.size.height / 3, itemWidth: vStackGeometry.size.width / 2, views: [
                                AnyView(SampleHomeInfoCardView(cardData: countryViewModel.countryCards[0])),
                                AnyView(SampleHomeInfoCardView(cardData: countryViewModel.countryCards[1])),
                                AnyView(SampleHomeInfoCardView(cardData: countryViewModel.countryCards[2])),
                                AnyView(SampleHomeInfoCardView(cardData: countryViewModel.countryCards[3])),
                                AnyView(SampleHomeInfoCardView(cardData: countryViewModel.countryCards[0])),
                                AnyView(SampleHomeInfoCardView(cardData: countryViewModel.countryCards[1])),
                                AnyView(SampleHomeInfoCardView(cardData: countryViewModel.countryCards[2])),
                                AnyView(SampleHomeInfoCardView(cardData: countryViewModel.countryCards[3]))
                            ])
                            .frame(height: vStackGeometry.size.height / 3)
                        }
                        
                    })
                }
                .onChange(of: self.currentViewIndex, perform: { value in
                    
                })
                
            }) // VStack
        } // GeometryReader
        .background(Color("countryDetail"))
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            countryViewModel.setDataFromAnnotationData(annotation: selectedCountry!, isAnime: true)
            countryViewModel.fetchCountryDataForDays(days: 8, iso2: (self.selectedCountry?.iso2)!, annotation: self.selectedCountry!)
            isCardsDataSete = true
        })
    }
    
}

// MARK: - Preview

//struct CountryDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        CountryDetail()
//    }
//}

