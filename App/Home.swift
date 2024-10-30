//
//  Home.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 11/29/20.
//

import SwiftUI
import SwiftUICharts

struct Home: View {
    
    // MARK: - Properties
    @Binding var show : Bool
    @ObservedObject var worldData = WorldDataViewModel()
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    var columnsOtherStat = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
    @State private var selectedTab = 0
    @State private var selectedChartTab = 0
    @State private var selectedSegment = 0
    @State private var selectedSegmentStrings = ["7 Days", "14 Days", "30 Days"]
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { geometry in
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    Picker(selection: $selectedTab, label: Text("Choose your report"), content: {
                        Text("Total").tag(0)
                        Text("24 Hours").tag(1)
                        Text("7 Days").tag(2)
                        Text("30 Days").tag(3)
                    })
                    
                    .foregroundColor(.blue)
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color(red: 1, green: 1, blue: 1, opacity: 0.35))
                    .cornerRadius(7)
                    .padding(.horizontal)
                    .padding(.top)
                    .onChange(of: self.selectedTab, perform: { value in
                        if (value == 0) {
                            self.worldData.fetchWorldData()
                        }
                        if (value == 1) {
                            self.worldData.fetchGlobalDataForDays(days: 2)
                        }
                        if (value == 2) {
                            self.worldData.fetchGlobalDataForDays(days: 7)
                        }
                        if (value == 3) {
                            self.worldData.fetchGlobalDataForDays(days: 30)
                        }
                    })
                    
                    
                    LazyVGrid(columns: columns,spacing: 20) {
                        
                        ForEach(worldData.cards, id: \.self){ card in
                            SampleHomeInfoCardView(cardData: card)
                        }
                    } // LazyVGrid
                    .padding(.horizontal)
                    .padding(.vertical)
                } // VStack
                .padding(.bottom, 8)
                .background(Color(hex: "073B4C"))
                
                VStack(alignment: .center) {
                    Text("Today's Statistics")
                        .font(.custom("Stolzl-Regular", size: 20))
                        .foregroundColor(Color("appCardColorDarkCyan"))
                    
                    VStack(alignment: .center, spacing: 0, content: {
                        ForEach(self.worldData.todaysInfo) { today in
                            VStack(alignment: .center, spacing: 0, content: {
                                HStack(alignment: .center, spacing: nil, content: {
                                    Text(today.title)
                                        .font(.custom("SFPro-Regular", size: 17))
                                        .foregroundColor(Color(.label))
                                        .padding(.vertical, 16)
                                    
                                    Spacer()
                                    
                                    Text("\(today.value)")
                                        .frame(width: geometry.size.width / 5)
                                        .font(.custom("Stolzl-Regular", size: 15))
                                        .foregroundColor(Color(.secondaryLabel))
                                        .clipShape(Rectangle())
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 6)
                                        .background(Color(.secondarySystemBackground))
                                        .cornerRadius(15)
                                        
                                })
                                Divider()
                            }) // VStack
                        } // ForEach (Today)
                    })
                    
                    Text("Other Statistics")
                        .font(.custom("Stolzl-Regular", size: 20))
                        .foregroundColor(Color("appCardColorDarkCyan"))
                        .padding()
                    
                    LazyVGrid(columns: columnsOtherStat, spacing: 16) {
                        ForEach(worldData.otherStats, id: \.self){ card in
                            OtherStatCardView(cardData: card)
                        }
                    } // LazyVGrid
                    
                    VStack(alignment: .center, spacing: 0, content: {
                        Divider()
                        HStack(alignment: .center, spacing: nil, content: {
                            Text("Affected Countries")
                                .font(.custom("SFPro-Regular", size: 17))
                                .foregroundColor(Color(.label))
                                .padding(.vertical, 16)
                            
                            Spacer()
                            
                            Text("\(self.worldData.data.affectedCountries)")
                                .frame(width: geometry.size.width / 5)
                                .font(.custom("Stolzl-Regular", size: 15))
                                .foregroundColor(Color(.white))
                                .clipShape(Rectangle())
                                .padding(.horizontal, 20)
                                .padding(.vertical, 6)
                                .background(Color("appCardColorBlue"))
                                .cornerRadius(15)
                                
                        })
                        Divider()
                    }) // VStack
                    .padding(.vertical)
                    
                    Text("Global Historical Data")
                        .font(.custom("Stolzl-Regular", size: 20))
                        .foregroundColor(Color("appCardColorDarkCyan"))
                    
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
                    .padding(.top)
                    .onChange(of: self.selectedSegment, perform: { value in
                        if (self.selectedSegment == 0) {
                            self.worldData.fetchGlobalChartDataForDays(days: 8)
                        }
                        if (self.selectedSegment == 1) {
                            self.worldData.fetchGlobalChartDataForDays(days: 15)
                        }
                        if (self.selectedSegment == 2) {
                            self.worldData.fetchGlobalChartDataForDays(days: 31)
                        }
                    })
                    
                    Picker(selection: $selectedChartTab, label: Text("Choose your report"), content: {
                        Text("Confirmed").tag(0)
                        Text("Recovered").tag(1)
                        Text("Deaths").tag(2)
                    })
                    .foregroundColor(.blue)
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color(red: 7/255, green: 59/255, blue: 76/255, opacity: 0.7))
                    .cornerRadius(7)
                    
                    LineView(data: self.worldData.chartData[selectedChartTab].data, title: nil, legend: self.worldData.chartData[selectedChartTab].legend, style: self.worldData.chartData[selectedChartTab].Style)
                        .padding(.horizontal)
//                        .padding(.bottom)
                        .background(Color(.secondarySystemBackground))
                        .frame(width: geometry.size.width - 32, height: geometry.size.height / 2)
                        .cornerRadius(15)
//                        .padding(.horizontal)
                    
                } // VStack
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                .background(Color("mainBackgroundColor"))
                .cornerRadius(28, corners: [.topLeft, .topRight])
                .cornerRadius(0, corners: [.bottomLeft, .bottomRight])
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 15, x: 0, y: -3)
                
            } // ScrollView
            .onAppear(perform: {
                UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                UISegmentedControl.appearance().layer.masksToBounds = true
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 7/255, green: 59/255, blue: 76/255, alpha: 1)], for: .selected)
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemGroupedBackground], for: .normal)
                
                self.worldData.fetchWorldData()
                self.worldData.fetchGlobalChartDataForDays(days: 8)
            })
            .disabled(self.show ? true : false)
            .background(Color(hex: "073B4C"))
            
        } // GeometryReader
        
    }
}

// MARK: - Preview

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}
