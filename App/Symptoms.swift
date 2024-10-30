//
//  Symptoms.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/7/20.
//

import SwiftUI

struct Symptoms: View {
    // MARK: - Properties
    @State var isModal: Bool = false
    @State var symptomsData = SymptomsData()
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(alignment: .leading, spacing: 16, content: {
                    Text("Most common symptoms")
                        .font(.custom("Stolzl-Regular", size: 20))
                        .foregroundColor(Color("appCardColorDarkCyan"))
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(symptomsData.commonSymptoms){ symptom in
                            SymptomCommonView(data: symptom)
                        }
                    }
                    
                    Text("Other common symptoms")
                        .font(.custom("Stolzl-Regular", size: 20))
                        .foregroundColor(Color("appCardColorDarkCyan"))
                    
                    LazyVStack(alignment: .center, spacing: 0, pinnedViews: [], content: {
                        ForEach(self.symptomsData.otherCommonSymptoms) { symptom in
                            VStack(alignment: .center, spacing: 0, content: {
                                HStack(alignment: .center, spacing: nil, content: {
                                    Text(symptom.title)
                                        .font(.custom("SFPro-Regular", size: 17))
                                        .foregroundColor(Color(.label))
                                        .padding(.vertical, 16)
                                    
                                    Spacer()
                                    
                                    Text(String(format:"%.0f", symptom.percent) + "%")
                                        .font(.custom("Stolzl-Regular", size: 15))
                                        .foregroundColor(Color(.systemBackground))
                                        .clipShape(Rectangle())
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 6)
                                        .background(Color("appCardColorRed"))
                                        .cornerRadius(15)
                                })
                                Divider()
                            })
                        }
                    })
                    
                    Text("Other probable symptoms")
                        .font(.custom("Stolzl-Regular", size: 20))
                        .foregroundColor(Color("appCardColorDarkCyan"))
                        .padding(.top)
                    
                    LazyVStack(alignment: .center, spacing: 0, pinnedViews: [], content: {
                        ForEach(self.symptomsData.probableSymptoms) { symptom in
                            VStack(alignment: .center, spacing: 0, content: {
                                HStack(alignment: .center, spacing: nil, content: {
                                    Text("• " + symptom.title)
                                        .font(.custom("SFPro-Regular", size: 17))
                                        .foregroundColor(Color(.label))
                                        .padding(.vertical, 16)
                                    
                                    Spacer()
                                })
                                Divider()
                            })
                        }
                    })
                    
                    Text("Emergency symptoms")
                        .font(.custom("Stolzl-Regular", size: 20))
                        .foregroundColor(Color("appCardColorDarkCyan"))
                        .padding(.top)
                    
                    LazyVStack(alignment: .center, spacing: 0, pinnedViews: [], content: {
                        ForEach(self.symptomsData.emergencySymptoms) { symptom in
                            VStack(alignment: .center, spacing: 0, content: {
                                HStack(alignment: .center, spacing: nil, content: {
                                    Text("• " + symptom.title)
                                        .font(.custom("SFPro-Regular", size: 17))
                                        .foregroundColor(Color(.label))
                                        .padding(.vertical, 16)
                                    
                                    Spacer()
                                })
                                Divider()
                            })
                        }
                    })
                    
                    Button(action: {
                        self.isModal = true
                    }, label: {
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
                            HStack {
                                VStack(alignment: .leading, spacing: 0, content: {
                                    Text("Fight\nAgainst")
                                        .font(.custom("Stolzl-Bold", size: 20))
                                        .foregroundColor(Color(.white))
                                        .multilineTextAlignment(.leading)
                                        .lineSpacing(4)
                                        .padding(.bottom, 4)
                                    Text("Covid-19")
                                        .font(.custom("Stolzl-Bold", size: 20))
                                        .foregroundColor(Color("appCardColorYellow"))
                                        .multilineTextAlignment(.leading)
                                })
                                Spacer()
                            } // HStack
                            .frame(height: (geometry.size.width / 4.5))
                            .padding()
                            .padding(.horizontal)
                            .background(Color("appCardColorDarkCyan"))
                            .cornerRadius(15)
                            
                            HStack {
                                Spacer()
                                Image("battleCoronavirus")
                                    .resizable()
                                    .frame(width: geometry.size.width / 2.7, height: geometry.size.width / 3)
                                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 3, x: -2, y: 0)
                                    .padding(.bottom)
                            } // HStack
                            .padding(.horizontal)
                        }) // ZStack
                    }) // TopButton
                    .frame(maxWidth: geometry.size.width)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 10, x: 0, y: 0)
                    .sheet(isPresented: $isModal, content: {
                        Protection()
                    })
                }) // VStack
                .padding(.horizontal)
                .padding(.top)
            }) // ScrollView
            .padding(.bottom)
        } // GeometryReadr
        .background(Color("mainBackgroundColor"))
    }
}

// MARK: - Preview
//struct Symptoms_Previews: PreviewProvider {
//    static var previews: some View {
//        Symptoms()
//    }
//}
