//
//  SymptomCommonView.swift
//  CovidATA-Live
//
//  Created by Mehran Ramazanilar on 12/11/20.
//

import SwiftUI

struct SymptomCommonView: View {
    // MARK: - Properties
    @State var data: SymptomsDataModel
    
    // MARK: - Body
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            Text(self.data.title)
                .font(.custom("Stolzl-Medium", size: 20))
                .foregroundColor(Color(.white))
            
            Text(self.data.body!)
                .font(.custom("SFPro-Regular", size: 17))
                .foregroundColor(Color(.white))
                .lineLimit(100)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: .infinity)
            
            VStack(alignment: .trailing, spacing: 4, content: {
                Text(String(format:"%.0f", self.data.percent) + "%")
                    .font(.custom("Stolzl-Regular", size: 15))
                    .foregroundColor(Color("appCardColorYellow"))
                GeometryReader { geometry in
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                        Rectangle()
                            .frame(width: geometry.size.width, height: 36)
                            .cornerRadius(15, corners: .allCorners)
                            .foregroundColor(.white)
                        
                        Rectangle()
                            .frame(width: (CGFloat(self.data.percent) * geometry.size.width) / 100, height: 36)
                            .cornerRadius(15, corners: (self.data.percent > 90 ? [.allCorners] : [.topLeft, .bottomLeft]))
                            .foregroundColor(Color("appCardColorRed"))
                    }) // ZStack
                } // GeometryReader
                .frame(height: 36)
                
                
            }) // VStack
            
        } // VStack
        .padding()
        .background(Color("appCardColorDarkCyan"))
        .cornerRadius(15)
    }
}

// MARK: - Preview

//struct SymptomCommonView_Previews: PreviewProvider {
//    static var previews: some View {
//        SymptomCommonView()
//    }
//}
