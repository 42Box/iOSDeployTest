//
//  BoxListSectionViewModel.swift
//  iBox
//
//  Created by 이지현 on 1/30/24.
//

import Foundation

class BoxListSectionViewModel: Identifiable {
    var folder: Folder
    private var boxListCellViewModels: [BoxListCellViewModel]!
    
    init(folder: Folder) {
        self.folder = folder
        boxListCellViewModels = folder.bookmarks.map { BoxListCellViewModel(bookmark: $0) }
    }
    
    var boxListCellViewModelsWithStatus: [BoxListCellViewModel] {
        return isOpened ? boxListCellViewModels : []
    }
    
    var id: UUID {
        folder.id
    }
    
    var name: String {
        folder.name
    }
    
    var isOpened: Bool {
        get {
            folder.isOpened
        }
        
        set {
            folder.isOpened = newValue
        }
    }
}
