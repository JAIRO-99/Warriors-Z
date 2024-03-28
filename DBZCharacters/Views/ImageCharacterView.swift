//
//  ImageCharacterView.swift
//  DBZCharacters
//
//  Created by New on 27/03/24.
//

import SwiftUI
import Kingfisher


struct ImageCharacterView: View {
    
    let url: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
       KFImage(URL(string: url))
            .resizable()
            .frame(width: width, height: height)
    }
}

#Preview {
    ImageCharacterView(url: ExampleModelData.example[0].image, width: 100, height: 150)
}
