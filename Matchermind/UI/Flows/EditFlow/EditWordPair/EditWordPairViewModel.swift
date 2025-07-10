//
//  EditWordPairViewModel.swift
//  Matchermind
//
//  Created by sergemi on 06/07/2025.
//

import SwiftUI

@MainActor
@Observable
final class EditWordPairViewModel: BaseViewModel, HasUnsavedChanges {
    var wordPairsBinding: Binding<[WordPair]>
    var startWordPair: WordPair
    var editedWordPair: WordPair
    var targetLocaleId: String
    var translateLocaleId: String
    
    var wordPairs: [WordPair] {
        get { wordPairsBinding.wrappedValue }
        set { wordPairsBinding.wrappedValue = newValue }
    }
    
    var isNewWord: Bool
    
    var title: String {
        isNewWord ? "Create word" : "Edit word"
    }
    
    var saveBtnTitle: String {
        isNewWord ? "Create word" : "Save word"
    }
    
    var targetTitle: String {
        if let localeName = Locale.current.localizedString(forIdentifier: targetLocaleId) {
            return "Target word (\(localeName))"
        } else {
            return "Target word"
        }
    }
    
    var translateTitle: String {
        if let localeName = Locale.current.localizedString(forIdentifier: translateLocaleId) {
            return "Translation (\(localeName))"
        } else {
            return "Translation"
        }
    }
    
    var canSave: Bool {
        editedWordPair.target.count > 0 &&
        editedWordPair.translate.count > 0 &&
        hasUnsavedChanges
    }
    
    var hasUnsavedChanges: Bool {
        editedWordPair != startWordPair
    }
    
    init(errorMgr: ErrorManager?,
         wordPairsBinding: Binding<[WordPair]>,
         targetLocaleId: String,
         translateLocaleId: String,
         editedWordPair: WordPair?) {
        self.wordPairsBinding = wordPairsBinding
        self.targetLocaleId = targetLocaleId
        self.translateLocaleId = translateLocaleId
        
        self.isNewWord = editedWordPair == nil
        let newWordPair = editedWordPair ?? WordPair()
        
        self.editedWordPair = newWordPair
        self.startWordPair = newWordPair
        
        super.init(errorMgr: errorMgr)
    }
    
    func saveWord() {
        do {
            if isNewWord {
                wordPairs.append(editedWordPair)
                resetWord()
            } else {
                guard let index = wordPairs.firstIndex(of: startWordPair) else {
                    throw DataManagerError.wordPairNotFound
                }
                wordPairs[index] = editedWordPair
                startWordPair = editedWordPair
            }
        } catch {
            errorMgr?.handleError(error)
        }
    }
    
    //MARK: - Private interface
    private func resetWord() {
        let newWord = WordPair()
        startWordPair = newWord
        editedWordPair = newWord
        
        isNewWord = true
    }
}
