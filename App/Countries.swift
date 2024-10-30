//
//  Countries.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 11/29/20.
//

import SwiftUI
import KingfisherSwiftUI

struct Countries: View {
    
    // MARK: - Properties
    @ObservedObject private var countryNovelViewModel = CountryNovelDataModel()
    @Binding var show : Bool
    @Binding var index : String
    @State private var favoriteColor = 0
    @State var selectedPin: CountryAnnotation?
    @State var isMapSetUp: Bool?
    @State var isModal: Bool = false
    
    // MARK: - Body
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack(alignment: .center, spacing: (self.favoriteColor == 0 ? 8 : 0), content: {
                Picker(selection: $favoriteColor, label: Text("Choose your layout")) {
                                Text("Map View").tag(0)
                                Text("List").tag(1)
                            }
                .background(Color(red: 1, green: 1, blue: 1, opacity: 0.35))
                .pickerStyle(SegmentedPickerStyle())
                .cornerRadius(7)
                .padding(.horizontal)
                .padding(.bottom, (self.favoriteColor == 0 ? 8 : 16))
                
                ZStack() {
                    CountryListView(countriesData: $countryNovelViewModel.countriesList)
                        .opacity(self.favoriteColor == 1 ? 1 : 0)
                    if self.index == "Countries" {
                        MapView(countriesData: $countryNovelViewModel.countriesList, selectedPin: $selectedPin, isMapSetUp: $isMapSetUp)
                            .opacity(self.favoriteColor == 0 ? 1 : 0)
                    }
                    
                    if (selectedPin != nil && self.favoriteColor == 0 && self.index == "Countries") {
                        VStack {
                            Spacer()
                            HStack {
                                VStack(alignment: .leading, spacing: 16, content: {
                                    HStack {
                                        KFImage(URL(string: (self.selectedPin?.flag)!))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 38, height: 25.5  )
                                            .clipped()
                                            .cornerRadius(8)
                                            .padding(.leading)
                                            .padding(.top)
                                        Text((self.selectedPin?.iso2)! + " - " + (self.selectedPin?.title)!)
                                            .font(.custom("Stolzl-Regular", size: 17))
                                            .foregroundColor(Color(.label))
//                                            .padding(.leading)
                                            .padding(.top)
                                    } // HStack
                                    Divider()
                                        .padding(.horizontal)
                                    
                                    HStack(alignment: .center, spacing: 16, content: {
                                        HStack {
                                            Spacer(minLength: 0)
                                            
                                            Text((self.selectedPin?.cases)! == 0 ? "N/A" : "\((self.selectedPin?.cases)!)")
                                                .font(.custom("Stolzl-Regular", size: 15))
                                                .foregroundColor(Color(.systemBackground))
                                            
                                            Spacer(minLength: 0)
                                            
                                            Image("bacteria")
                                                .renderingMode(.template)
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(Color(.systemBackground))
                                            
                                        } // HStack
                                        .frame(minWidth: geometry.size.width / 3, maxWidth: geometry.size.width / 3, alignment: .center)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color("appCardColorYellow"))
                                        .clipShape(RoundedRectangle.init(cornerRadius: 15 ))
                                        .padding(.bottom)
                                        .padding(.leading)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            self.isModal = true
                                        }, label: {
                                            HStack(alignment: .center, spacing: 0, content: {
                                                Text("Details")
                                                    .font(.custom("SFPro-Medium", size: 17))
                                                    .foregroundColor(Color("appCardColorDarkCyan"))
                                                Image(systemName: "chevron.right")
                                                    .font(.custom("SFPro-Medium", size: 17))
                                                    .foregroundColor(Color("appCardColorDarkCyan"))
                                            })
                                        })
                                        .padding(.bottom)
                                        .padding(.trailing)
                                        .sheet(isPresented: $isModal, content: {
                                            CountryDetail(selectedCountry: $selectedPin)
                                                })
                                    }) // HStack
                                    
                                })// VStack
                                Spacer(minLength: 0)
                            } // HStack
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, alignment: .center)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(16)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.2), radius: 10, x: 0, y: 0)
                        } // VStack
                        .padding()
                    } // IF Statement
                    
                        
                }
//                    .edgesIgnoringSafeArea(.bottom)
            })
//            .edgesIgnoringSafeArea(.bottom)
        } // GeometryReader
        .background(Color("appCardColorDarkCyan"))
        .onChange(of: self.index, perform: { value in
            if (self.index != "Countries") {
                self.selectedPin = nil
                self.isMapSetUp = false
            } 
        })
        .disabled(self.show ? true : false)
    }
}

// MARK: - Preview

//struct Countries_Previews: PreviewProvider {
//    static var previews: some View {
//        Countries()
//    }
//}
