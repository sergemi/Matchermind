//
//  ModulesListViewModel.swift
//  Matchermind
//
//  Created by sergemi on 25/06/2025.
//

import Foundation
import Combine

final class ModulesListViewModel: DataViewModel {
    @Published var title = "Modules to learn"
//    @Published var modules: [ModulePreload] = []
//    @Published var quickModule: ModulePreload? = nil
    var modules: [ModulePreload] {
        dataMgr.modulePreloads
    }
    
    var quickModule: ModulePreload? {
        dataMgr.quickModule?.modulePreload
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    override init(router: AppRouter, authService: AuthService, dataMgr: DataManager) {
        super.init(router: router, authService: authService, dataMgr: dataMgr)
        
//        dataMgr.$modulePreloads
//            .receive(on: DispatchQueue.main)
//            .assign(to: &$modules)
//        
//        dataMgr.$quickModule
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] module in
//                self?.quickModule = module?.modulePreload
//            }
//            .store(in: &cancellables)
    }
    
    func selectModule(_ module: ModulePreload) {
        Task {
            do {
                try await _ = dataMgr.selectModule(by: module.id)
            } catch {
                print("Error selecting module: \(error)") // TODO: show error
            }
        }
        router.navigate(to: .learn(.module(preload: module)))
    }
    
}
