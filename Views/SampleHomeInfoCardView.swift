//
//  SampleHomeInfoCardView.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/1/20.
//

import SwiftUI

struct SampleHomeInfoCardView: View, Identifiable {
    var id = UUID()
    // MARK: - Properties
    @State var cardData: HomeSceneCardModel
    @State private var change = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            
            VStack(alignment: .leading, spacing: 16) {
                
                Text(self.cardData.title)
                    .foregroundColor(Color(.systemBackground))
                    .font(.custom("Stolzl-Regular", size: 15))
                
                HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                    Spacer(minLength: 0)
                    Text("\(self.cardData.value)")
                        .font(.custom("Stolzl-Medium", size: 20))
                        .foregroundColor(Color(.systemBackground))
                        .padding(.top,10)
                        .padding(.horizontal, 0)
                    
                    Spacer(minLength: 0)
                })
                
                HStack{
//                    Text("Per One Million\n\(Int(self.cardData.perMillion))")
                    Text("\(Int(self.cardData.perMillion))\nPer One Million")
                        .font(.custom("Stolzl-Light", size: 13))
                        .foregroundColor(Color(.systemBackground))
                    Spacer(minLength: 0)
                }
            }
            .padding()
            // image name same as color name....
            .background(Color(hex: self.cardData.color))
            .cornerRadius(20)
            // shadow....
            .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 1)
            
            // top Image....
            
            Image(self.cardData.icon)
                .renderingMode(.template)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(Color(.systemBackground))
                .padding()
                .background(Color.white.opacity(0.12))
                .clipShape(Circle())
        } // ZStack
    }
}

//struct SampleHomeInfoCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SampleHomeInfoCardView()
//    }
//}
