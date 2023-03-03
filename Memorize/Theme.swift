//
//  Theme.swift
//  Memorize
//
//  Created by Stefan Crudu on 02.03.2023.
//

import Foundation

struct Theme<ContentTheme> where ContentTheme:Hashable {
    let name: String
    var contentList: Set<ContentTheme>
    var contentLengthToShow: Int
    let color: Theme<ContentTheme>.Color
    
    init(name: String, contentList: Set<ContentTheme>, contentLengthToShow: Theme.Length? = .all, color: Theme<ContentTheme>.Color) {
        self.name = name
        self.contentList = contentList
        switch contentLengthToShow {
            case .all:
                self.contentLengthToShow = contentList.count
            case .random:
                self.contentLengthToShow = Int.random(in: 0...contentList.count)
            case .number(let number):
                self.contentLengthToShow = number > contentList.count ? contentList.count : number
            case .none:
                fatalError("Can't set contentLenghtToShow")
        }
        self.color = color
    }
    
    enum Length {
        case all
        case random
        case number(_ number:Int)
    }
    
    struct Color {
        let name: String
        let isGradient: Bool
        
        init(name: String, isGradient: Bool = false) {
            self.name = name
            self.isGradient = isGradient
        }
        
    }
}
