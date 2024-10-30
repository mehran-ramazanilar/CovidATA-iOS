//
//  OnBoarding.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/12/20.
//

import SwiftUI

struct OnBoarding: View {
    // MARK: - Properties
    @State var tabData = OnBoardingData()
    @State var selectedTab = 1
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
            Color("mainBackgroundColor")
                .ignoresSafeArea()
            
            TabView(selection: $selectedTab) {
                OnBoardingView(tabData: tabData.data[0])
                    .tag(1)
                
                OnBoardingView(tabData: tabData.data[1])
                    .tag(2)
                
                OnBoardingView(tabData: tabData.data[2])
                    .tag(3)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .padding()
            
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        isOnboarding = false
                    }, label: {
                        Text("Skip")
                            .font(.custom("SFPro-Regular", size: 15))
                            .foregroundColor(Color(.label))
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        if (selectedTab < 3) {
                            withAnimation {
                                self.selectedTab = self.selectedTab + 1
                            }
                            
                        } else {
                            if (selectedTab == 3) {
                                isOnboarding = false
                            }
                        }
                    }, label: {
                        Text(self.selectedTab == 3 ? "Start" : "Next")
                            .font(.custom("SFPro-Regular", size: 15))
                            .foregroundColor(Color("appCardColorGreen"))
                    })
                } // HStack
                .padding()
                .padding()
            } // VStack
        }) // ZStack
    }
}

// MARK: - Preview
struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}
