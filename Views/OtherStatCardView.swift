//
//  OtherStatCardView.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/12/20.
//

import SwiftUI

struct OtherStatCardView: View {
    // MARK: - Properties
    @State var cardData: HomeSceneCardModel
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text(self.cardData.title)
                .font(.custom("SFPro-Semibold", size: 17))
                .foregroundColor(Color("appCardColorDarkCyan"))
            
            Text("\(self.cardData.value)")
                .font(.custom("Stolzl-Regular", size: 17))
                .foregroundColor(Color(.secondaryLabel))
            
            VStack(alignment: .leading, spacing: 0, content: {
                HStack {
                    Text("\(Int(self.cardData.perMillion))")
                        .font(.custom("Stolzl-Light", size: 15))
                        .foregroundColor(Color(.secondaryLabel))
                    Spacer()
                }
                HStack {
                    Text("Per one million")
                        .font(.custom("Stolzl-Light", size: 15))
                        .foregroundColor(Color(.secondaryLabel))
                    Spacer()
                }
            })
            
        } // VStack
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(15)
    }
}


// MARK: - Preview
//struct OtherStatCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        OtherStatCardView()
//            .previewLayout(.sizeThatFits)
//    }
//}
