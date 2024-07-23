//
//  String+WordChecker.swift
//  Project5
//
//  Created by Mateusz Bereta on 16/07/2024.
//

import UIKit

enum status {
    case notPossible
    case notOriginal
    case notReal
    case tooShort
    case isSame
    case isOk
}

extension String {
    func isOk(chosenWord: String?, usedWords: [String]) -> status {
        switch self {
        case _ where self.isShort():
            return .tooShort
        case _ where self.isSame(chosenWord: chosenWord):
            return .isSame
        case _ where !self.isOriginal(usedWords: usedWords):
            return .notOriginal
        case _ where !self.isReal():
            return .notReal
        case _ where !self.isPossible(chosenWord: chosenWord):
            return .notPossible
        default:
            return .isOk
        }
    }
    
    func isPossible(chosenWord: String?) -> Bool {
        guard var tempWord = chosenWord?.lowercased() else { return false }
        
        for letter in self {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(usedWords: [String]) -> Bool {
        return !usedWords.contains(self)
    }
    
    func isShort() -> Bool {
        return self.count < 3
    }
    
    func isSame(chosenWord: String?) -> Bool {
        guard let tempWord = chosenWord?.lowercased() else { return true }
        return self == tempWord
    }
    
    func isReal() -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: self.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: self, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
}
