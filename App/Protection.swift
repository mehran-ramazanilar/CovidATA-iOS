//
//  Protection.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/7/20.
//

import SwiftUI

struct Protection: View {
    // MARK: - Properties
    @State var cards: [ProtectionCardModel] = ProtectionCardsData().data
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Image("greenCovidSmall")
                    }
                    Spacer()
                    Image("greenCovidBig")
                } // VStack
                
                ScrollView(.vertical, showsIndicators: false) {
                    Text("Preventation")
                        .font(.custom("Stolzl-Medium", size: 20))
                        .foregroundColor(Color("appCardColorDarkCyan"))

                    Divider()

                    LazyVStack(alignment: .center, spacing: 16, content: {
                        ForEach(cards) { card in
                            protectionCardView(cardData: card)
                        }
                    })
                    .padding(.top, 8)
                } // ScrollView
                
            }) // ZStack
            
        } // GeometryReader
        .padding()
        .background(Color("mainBackgroundColor"))
        .edgesIgnoringSafeArea(.bottom)
    }
}

// MARK: - Preview
struct Protection_Previews: PreviewProvider {
    static var previews: some View {
        Protection()
    }
}
