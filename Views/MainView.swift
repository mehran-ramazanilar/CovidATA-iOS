//
//  MainView.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 11/29/20.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Properties
    
    @Binding var show : Bool
    @Binding var index : String
    @State var home: Home?
    @State var countries: Countries?
    
    // MARK: - Body
    
    var body : some View {
        
        VStack(spacing: 0) {
            
            // MARK: - Top Nav Section
            ZStack{
                
                HStack{
                    
                    Button(action: {
                        
                        withAnimation(.spring()){
                            
                            self.show.toggle()
                        }
                        
                    }) {
                        
                        Image("menu")
                            .resizable()
                            .frame(width: 18, height: 14)
                            .foregroundColor(Color("appCardColorDarkCyan"))
                            .padding(.horizontal, 9)
                            .padding(.vertical, 11)
                            .background(Color(.systemBackground))
                            .cornerRadius(8, corners: .allCorners)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("")
                        .resizable()
                        .frame(width: 18, height: 18)
                            .foregroundColor(Color(.label))
                    }
                } // HStack
                
                Text(index)
                    .font(Font.custom("SFPro-Semibold", size: 24))
                    .foregroundColor(self.index == "Symptoms" ? Color(hex: "#073B4C") : Color(.systemBackground))
            } // ZStack
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            // MARK: - App Pages
            ZStack{
                
                home.opacity(self.index == "Overview" ? 1 : 0)
                countries.opacity(self.index == "Countries" ? 1 : 0)
                Symptoms().opacity(self.index == "Symptoms" ? 1 : 0)
            } // ZStack
            
        } // VStack
        .onAppear(perform: {
            home = Home(show: $show)
            countries = Countries(show: $show, index: $index)
        })
//        .background(Color("mainBackgroundColor"))
//        .background(Color(hex: "#073B4C"))
        .background(self.index == "Symptoms" ? Color("mainBackgroundColor") : Color(hex: "#073B4C"))
        .cornerRadius(self.show ? 15 : 0)
        .highPriorityGesture(self.show ? TapGesture()
                                .onEnded{ _ in
                                    withAnimation(.spring()){
                                        self.show.toggle()
                                    }
            } : nil)
        .highPriorityGesture(self.show ? DragGesture()
                                .onEnded{ value in
                                    if value.translation.width < 0 {
                                        withAnimation(.spring()){
                                            self.show.toggle()
                                        }
                                    }
            } : nil)
    }
}
