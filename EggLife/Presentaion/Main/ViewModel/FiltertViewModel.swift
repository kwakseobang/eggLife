//
//  FiltertViewModel.swift
//  EggLife
//
//  Created by 곽서방 on 7/8/24.
//

import Foundation

enum FilterViewModel: Int, CaseIterable {
    case soft
    case hard
    
    var title: String {
        switch self {
        case .soft : return "반숙"
        case .hard: return "완숙"
        }
    }
    
}
