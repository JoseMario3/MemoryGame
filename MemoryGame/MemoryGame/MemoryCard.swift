//
//  MemoryCard.swift
//  MemoryGame
//
//  Created by Jose Folgar on 3/18/24.
//

import SwiftUI

struct MemoryCard: View {

    let pic: String
    
    @State var isShowingPic = false
    @State var isMatched = false
    
    var onCardSelected: (() -> Void)?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(isShowingPic ? Color.white.gradient : Color.blue.gradient)
                .shadow(color: .black, radius: 4, x: -2, y: 2)
            Image(systemName: isShowingPic ? pic : "star.fill")
                .imageScale(.large)
                .foregroundColor(.yellow)
            }
        .frame(width: 100, height: 140)
        .onTapGesture {
            if !isShowingPic && !isMatched {
                isShowingPic = true
                onCardSelected?()
            }
        }
    }
}

#Preview {
    MemoryCard(pic: "star.fill")
}
