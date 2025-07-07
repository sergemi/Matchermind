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
    
    var hasUnsavedChanges: Bool {
        editedWordPair.target.count > 0 &&
        editedWordPair.translate.count > 0 &&
        editedWordPair != startWordPair
    }
    
    init(errorMgr: ErrorManager?, wordPairsBinding: Binding<[WordPair]>, editedWordPair: WordPair?) {
        self.wordPairsBinding = wordPairsBinding
        
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
