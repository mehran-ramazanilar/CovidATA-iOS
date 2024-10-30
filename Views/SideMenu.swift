//
//  SideMenu.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 11/29/20.
//

import SwiftUI

struct SideMenu: View {
    
    // MARK: - Properties
    
    @State var index = "Overview"
    @State var show = false
    @State var data = SideMenuData().data
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    // MARK: - Body
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack{
                
//                (self.show ? Color("sideMenuColor") : Color("mainBackgroundColor")).edgesIgnoringSafeArea(.all)
                (self.show ? Color("sideMenuColor") : (self.index == "Symptoms" ? Color("mainBackgroundColor") : Color(hex: "#073B4C"))).edgesIgnoringSafeArea(.all)
                
                ZStack(alignment: .leading) {
                    
                    VStack(alignment : .leading,spacing: 25) {
                        
                        // MARK: - SideMenu top app info
                        HStack(spacing: 15){
                            
                            Image("logo1024")
                            .resizable()
                                .frame(width: geometry.size.width / 6.3, height: geometry.size.width / 6.3)
                            .cornerRadius(12)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                
                                Text("CovidATA")
                                    .font(.custom("SFPro-Bold", size: 20))
                                    .foregroundColor(Color(.label))
                                
                                Text("Latest Covid-19 Data")
                                    .font(.custom("SFPro-Medium", size: 15))
                                    .foregroundColor(Color(.secondaryLabel))
                            } // VStack
                        } // HStack
                        .padding(.bottom, 50)

                        // MARK: - SideMenu page buttons
                        ForEach(data,id: \.self){i in
                            
                            Button(action: {
                                
                                self.index = i
                                
                                withAnimation(.spring()){
                                    
                                    self.show.toggle()
                                }
                                
                            }) {
                                
                                HStack{
                                    
                                    Capsule()
                                    .fill(self.index == i ? Color.orange : Color.clear)
                                    .frame(width: 5, height: 30)
                                    
                                    Text(i)
                                        .padding(.leading)
                                        .foregroundColor(Color(.label))
                                        .font(self.index == i ? .custom("SFPro-Semibold", size: 17) : .custom("SFPro-Regular", size: 17))
                                    
                                } // HStack
                            }
                        }
                        
                        Spacer()
                    } // VStack
                    .padding(.leading)
                    .padding(.top)
                    .scaleEffect(self.show ? 1 : 0)
                    
                    ZStack(alignment: .topTrailing) {
                        
                        // MARK: - Scaled down scene
                        MainView(show: self.$show,index: self.$index)
                            .scaleEffect(self.show ? 0.8 : 1)
                            .offset(x: self.show ? 150 : 0,y : self.show ? 50 : 0)
                            .shadow(color: self.colorScheme == ColorScheme.light ? Color(red: 0, green: 0, blue: 0, opacity: 0.15) : Color(red: 0, green: 0, blue: 0, opacity: 1),
                                    radius: self.show ? 10 : 0,
                                    x: 0,
                                    y: 0)
                            .disabled(self.show ? false : false)
                        
                        // MARK: - Close(x) button inside side menu
                        Button(action: {
                            
                            withAnimation(.spring()){
                                
                                self.show.toggle()
                            }
                            
                        }) {
                            
                            Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 15, height: 15)
                                .foregroundColor(Color(.label))
                            
                        }.padding()
                        .opacity(self.show ? 1 : 0)
                    } // ZStack
                    .edgesIgnoringSafeArea(.bottom)
                } // ZStack
            } // ZStack
        } // GeometryReader
        
    }
}

// MARK: - Preview

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
    }
}
