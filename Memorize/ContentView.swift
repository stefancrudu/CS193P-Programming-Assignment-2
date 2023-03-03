//
//  ContentView.swift
//  Memorize
//
//  Created by Stefan Crudu on 02.03.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemorizeGame
    var body: some View {
        VStack {
            HeaderView(name: viewModel.theme.name)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, gradienColor: viewModel.colorGradient)
                            .onTapGesture {
                                viewModel.choose(card)
                        }
                    }
                }
            }
            Spacer()
            ScoreView(score: viewModel.score)
            newGameButton
        }
        .padding()
        .foregroundColor(viewModel.colorTheme)
    }
    
    var newGameButton: some View {
        Button {
            viewModel.setNewTheme()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                HStack {
                    Image(systemName: "gamecontroller.fill")
                    Text("New Game")
                }
                .foregroundColor(.white)
            }
            .frame(maxWidth: UIScreen.main.bounds.size.width / 2, maxHeight: 44)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemorizeGame())
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var gradienColor: AnyGradient?
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            if card.isFaceUp {
                shape
                    .strokeBorder(lineWidth: 3)
                Text(card.content)
            } else if card.isMatch {
                shape.opacity(0)
            } else{
                if let gradienColor = gradienColor {
                    shape.fill(gradienColor)
                } else {
                    shape
                }
            }
        }
        .aspectRatio(2/3, contentMode: .fill)
    }
}

struct HeaderView: View {
    var name: String
    var body: some View {
        Text("Memorize")
            .font(.largeTitle)
        Text(name)
            .font(.headline)
    }
}

struct ScoreView: View {
    var score: Int
    var body: some View {
        Text("Score: \(score)")
            .font(.body)
    }
}
