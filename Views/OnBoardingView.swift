//
//  OnBoardingView.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/12/20.
//

import SwiftUI

struct OnBoardingView: View {
    // MARK: - Properties
    @State var tabData: OnBoardingDataModel
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 32, content: {
            
            Image(self.tabData.image)
            
            Text(self.tabData.title)
                .font(.custom("Stolzl-Regular", size: 20))
                .foregroundColor(Color("appCardColorDarkCyan"))
            
            Text(self.tabData.body)
                .font(.custom("SFPro-Regular", size: 17))
                .foregroundColor(Color(.label))
                .padding(.horizontal, 64)
                .multilineTextAlignment(.center)
            
        })
        .background(Color(.clear))
    }
}

// MARK: - Preview
//struct OnBoardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnBoardingView()
//    }
//}
