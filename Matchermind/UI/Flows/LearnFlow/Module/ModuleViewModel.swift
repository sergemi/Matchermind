//
//  ModuleViewModel.swift
//  Matchermind
//
//  Created by sergemi on 25/06/2025.
//

import SwiftUI
import Combine

final class ModuleViewModel: DataViewModel {
    let title: String
    
    @Binding var module: Module?
    
    init(modulePreload: ModulePreload,
         module: Binding<Module?>,
         router: AppRouter,
         authService: AuthService,
         dataMgr: DataManager) {
        title = modulePreload.name
        self._module = module
        
        super.init(router: router,
                   authService: authService,
                   dataMgr: dataMgr)
    }
}
