//
//  File.swift
//  
//
//  Created by Kieran Brown on 10/26/19.
//

import Foundation
import SwiftUI

/// Drag State describing the combination of a long press and drag gesture.
///  - seealso:
///  [Reference]: https://developer.apple.com/documentation/swiftui/gestures/composing_swiftui_gestures "Composing SwiftUI Gestures "
enum DragState {
    case inactive
    case pressing
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isActive: Bool {
        switch self {
        case .inactive:
            return false
        case .pressing, .dragging:
            return true
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive, .pressing:
            return false
        case .dragging:
            return true
        }
    }
}
