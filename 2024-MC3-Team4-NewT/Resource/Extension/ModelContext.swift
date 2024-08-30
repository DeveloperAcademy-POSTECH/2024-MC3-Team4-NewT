//
//  ModelContext.swift
//  2024-MC3-Team4-NewT
//
//  Created by ram on 8/1/24.
//

import Foundation
import SwiftData
import SwiftUI


struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
