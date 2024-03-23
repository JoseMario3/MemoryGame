//
//  ContentView.swift
//  MemoryGame
//
//  Created by Jose Folgar on 3/18/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var cards: [MemoryCard] = memoryCards3.shuffled()
    @State private var selectedSize: Size =  .three
    @State private var selectedCards: [Int] = []
    
    enum Size: String, CaseIterable, Identifiable {
        case three, six, nine
        var id: Self { self }
    }
    
    let columns = [ GridItem(.adaptive(minimum: 90)) ]
    
    var body: some View {
        VStack {
            Text("Memory Medium")
                .bold()
                .font(.system(size: 32))
                .padding(.top, 10)
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.green)
                        .frame(width: 110, height: 55)
                    Picker ("Size", selection: $selectedSize) {
                        Text("3 Pairs").tag(Size.three)
                        Text("6 Pairs").tag(Size.six)
                        Text("9 Pairs").tag(Size.nine)
                    }
                    .frame(width: 100, height: 75)
                }
                .padding(.trailing, 50)

                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.red)
                        .frame(width: 110, height: 55)
                    
                    Button("Refresh") {
                        
                        for card in cards {
                            card.isShowingPic = false
                        }
                        
                        if selectedSize == .three {
                            cards = memoryCards3.shuffled()
                        } else if selectedSize == .six {
                            cards = memoryCards6.shuffled()
                        } else {
                            cards = memoryCards9.shuffled()
                        }
                        
                    }
                }
                .padding(.leading, 50)
            }
            .foregroundStyle(.white)
            .accentColor(.white)
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(cards.indices, id: \.self) { index in MemoryCard(pic: cards[index].pic, isShowingPic: cards[index].isShowingPic, isMatched: cards[index].isMatched) {
                            handleCardSelected(idx: index)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
        }
    }
    
    func handleCardSelected(idx: Int) {
        selectedCards.append(idx)
        print("hello")
        if selectedCards.count == 2 {
            print("hey")
            checkMatch()
        }
    }
    
    func checkMatch() {
        
        let index1 = selectedCards[0]
        let index2 = selectedCards[1]
        
        if cards[index1].pic == cards[index2].pic {
            cards[index1].isMatched = true
            cards[index2].isMatched = true
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                cards[index1].isShowingPic = false
                cards[index2].isShowingPic = false
            }
        }
        selectedCards.removeAll()
    }
}

#Preview {
    ContentView()
}

let memoryCards3 = [
    MemoryCard(pic: "swift"),
    MemoryCard(pic: "heart.fill"),
    MemoryCard(pic: "dog.fill"),
    MemoryCard(pic: "heart.fill"),
    MemoryCard(pic: "swift"),
    MemoryCard(pic: "dog.fill")
]

let memoryCards6 = [
    MemoryCard(pic: "swift"),
    MemoryCard(pic: "heart.fill"),
    MemoryCard(pic: "dog.fill"),
    MemoryCard(pic: "heart.fill"),
    MemoryCard(pic: "swift"),
    MemoryCard(pic: "dog.fill"),
    MemoryCard(pic: "trash.fill"),
    MemoryCard(pic: "trash.fill"),
    MemoryCard(pic: "doc.fill"),
    MemoryCard(pic: "checkmark.circle.fill"),
    MemoryCard(pic: "doc.fill"),
    MemoryCard(pic: "checkmark.circle.fill"),
]

let memoryCards9 = [
    MemoryCard(pic: "swift"),
    MemoryCard(pic: "heart.fill"),
    MemoryCard(pic: "dog.fill"),
    MemoryCard(pic: "heart.fill"),
    MemoryCard(pic: "swift"),
    MemoryCard(pic: "dog.fill"),
    MemoryCard(pic: "trash.fill"),
    MemoryCard(pic: "trash.fill"),
    MemoryCard(pic: "doc.fill"),
    MemoryCard(pic: "checkmark.circle.fill"),
    MemoryCard(pic: "doc.fill"),
    MemoryCard(pic: "checkmark.circle.fill"),
    MemoryCard(pic: "folder.fill"),
    MemoryCard(pic: "pencil"),
    MemoryCard(pic: "folder.fill"),
    MemoryCard(pic: "scribble"),
    MemoryCard(pic: "pencil"),
    MemoryCard(pic: "scribble"),
]
