//
//  EditWordPairView.swift
//  Matchermind
//
//  Created by sergemi on 06/07/2025.
//

import SwiftUI

private struct ErrorManagerKey: EnvironmentKey {
    static let defaultValue: ErrorManager? = nil
}

extension EnvironmentValues {
    var errorManager: ErrorManager? {
        get { self[ErrorManagerKey.self] }
        set { self[ErrorManagerKey.self] = newValue }
    }
}

struct EditWordPairView: View {
    @Environment(ErrorManager.self) var errorMgr
    private var isSubView: Bool
    private var isRootView: Bool
    
    @State private var viewModel: EditWordPairViewModel
    
    init(wordPairs: Binding<[WordPair]>,
         targetLocaleId: String,
         translateLocaleId: String,
         editedWordPair: WordPair? = nil,
         isSubView: Bool = false,
         isRootView: Bool = false) {
        let environment = EnvironmentValues()
        let errorMgr = environment.errorManager
        self.isSubView = isSubView
        self.isRootView = isRootView
        
        _viewModel = State(initialValue: EditWordPairViewModel(errorMgr: errorMgr,
                                                               wordPairsBinding: wordPairs,
                                                               targetLocaleId: targetLocaleId,
                                                               translateLocaleId: translateLocaleId,
                                                               editedWordPair: editedWordPair))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            DefaultTextField(text: $viewModel.editedWordPair.target,
                             placeholder: "Word wich you want to learn",
                             title: viewModel.targetTitle)
            
            DefaultTextField(text: $viewModel.editedWordPair.translate,
                             placeholder: "Translate of the word",
                             title: viewModel.translateTitle)
            
            DefaultTextField(text: $viewModel.editedWordPair.pronounce, placeholder: "Pronounce", title: "Pronounce")
            
            DefaultTextField(text: $viewModel.editedWordPair.notes, placeholder: "Any notes you want to add", title: "Notes")
            
            Text("Words count: \(viewModel.wordPairs.count)")
            
            Spacer()
            
            Button(viewModel.saveBtnTitle) {
                viewModel.saveWord()
            }
            .disabled(!viewModel.canSave)
        }
        .padding()
        .applyIf(!isSubView) {
                $0.navigationTitle(viewModel.title)
            }
        .alertOnBackButton(viewModel: viewModel, showBackButton: !isRootView)
    }
}




#Preview {
    let errorMgr = ErrorManager()
    
    EditWordPairView(wordPairs: .constant([]),
                     targetLocaleId: Locale.current.identifier,
                     translateLocaleId: Locale.current.identifier,
                     editedWordPair: nil)
    .environment(errorMgr)
}
