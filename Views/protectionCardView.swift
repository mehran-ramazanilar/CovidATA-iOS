//
//  protectionCardView.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/7/20.
//

import SwiftUI

struct protectionCardView: View {
    // MARK: - Properties
    @State var cardData: ProtectionCardModel
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 16, content: {
            Image(self.cardData.imageName)
                .resizable()
                .frame(width: 58, height: 58)
                .cornerRadius(29)
            VStack(alignment: .leading, spacing: 8, content: {
                Text(self.cardData.title)
                    .foregroundColor(Color("appCardColorDarkCyan"))
                    .font(.custom("Stolzl-Medium", size: 17))
                HStack {
                    Text(self.cardData.body)
                        .foregroundColor(Color(.label))
                        .font(.custom("SFPro-Regular", size: 15))
                    Spacer(minLength: 0)
                }
            })
            .frame(maxWidth: .infinity)
        })
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
    }
}

// MARK: - Preview
//struct protectionCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        protectionCardView()
//            .previewLayout(.sizeThatFits)
//    }
//}
