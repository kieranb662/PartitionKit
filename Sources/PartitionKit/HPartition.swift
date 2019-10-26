//
//  HPartition.swift
//  
//
//  Created by Kieran Brown on 10/26/19.
//

import Foundation
import SwiftUI


/// # Horizontal Partition
///
///  Used to create resizable views that share a total width,
///  Takes 3 generic arguments to prevent users from needing to wrap content views within an  `AnyView`
///
///   - note
///   the syntax looks something like this, So if closures are still kind of new to you just think that you are sending a letter(`View`) to somebody  and it needs an Envelope(`{}`) to get there.
///
///   ```
///   HPart(left: {
///       Rectangle()
///   }, right: {
///       Circle()
///  }) {
///     Capsule()
///  }
///  ```
///
@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
public struct HPart<Left, Right, Handle> where Left: View, Right: View, Handle: View {
    public var left: Left
    public var right: Right
    public var handle: Handle
    
    /// Amount of time it takes before a gesture is recognized as a longPress, the precursor to the drag.
    var minimumLongPressDuration = 0.05
    var handleSize: CGSize = CGSize(width: 10, height: 75)
    var pctSplit: CGFloat = 0.5
    
    // dragState and viewState are also taken directly froms Apples "Composing SwiftUI Gestures"
    @GestureState var dragState = DragState.inactive
    @State var viewState = CGSize.zero
    
    // A bit of a convienence so I dont have to write this again and again.
    var currentOffset: CGFloat {
        viewState.width+dragState.translation.width
    }
    
    
    /// Creates the `Handle` and adds the drag gesture to it.
    func generateHandle() -> some View {
        
        // This gesture sequence is also directly from apples "Composing SwiftUI Gestures"
        let longPressDrag = LongPressGesture(minimumDuration: minimumLongPressDuration)
            .sequenced(before: DragGesture())
            .updating($dragState) { value, state, transaction in
                switch value {
                // Long press begins.
                case .first(true):
                    state = .pressing
                // Long press confirmed, dragging may begin.
                case .second(true, let drag):
                    state = .dragging(translation: drag?.translation ?? .zero)
                // Dragging ended or the long press cancelled.
                default:
                    state = .inactive
                }
        }
        .onEnded { value in
            guard case .second(true, let drag?) = value else { return }
            self.viewState.height += drag.translation.height
            self.viewState.width += drag.translation.width
            
        }
        
        // MARK: Customize Handle Here
        // Add the gestures and visuals to the handle
        return handle.overlay(dragState.isDragging ? Circle().stroke(Color.white, lineWidth: 2) : nil)
            .foregroundColor(.white)
            .frame(width: handleSize.width, height: handleSize.height, alignment: .center)
            .offset(x: currentOffset, y: 0)
            .animation(.linear)
            .gesture(longPressDrag)
    }
    
    
    
    
    // MARK: Money Shot
    public var body: some View {
        GeometryReader { (proxy: GeometryProxy) in
            HStack {
                self.left
                    .frame(width: 0.9*(self.pctSplit*proxy.frame(in: .local).width) + self.currentOffset)
                .animation(.linear)
                Divider()
                self.right
                    .frame(width: 0.9*((1-self.pctSplit)*proxy.frame(in: .local).width) - self.currentOffset)
                    .animation(.linear)
            }.overlay(self.generateHandle(), alignment: .center)
        }
    }
}



// MARK: Init


@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
extension HPart: View where Left: View, Right: View, Handle: View {
    
    
    /// # Horizontal Partition With Custom Handle
    ///
    /// - parameters:
    ///    - left: Any type of View within a closure.
    ///    - right: Any type of View within a closure
    ///    - handle: Any type of View within a closure. The `Handle` is the view that the user will use to drag and resize the partitions.
    @inlinable public init(@ViewBuilder left: () -> Left, @ViewBuilder right: () -> Right, @ViewBuilder handle: () -> Handle) {
        self.left = left()
        self.right = right()
        self.handle = handle()
    }
    
}


@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
extension HPart where Left: View, Right: View, Handle == Capsule {
    
    
    /// # Horizontal Partition With Default Handle
    ///
    /// - parameters:
    ///    - left: Any type of View within a closure.
    ///    - right: Any type of View within a closure
    ///
    /// - note
    ///  The `Handle` used here is a capsule that is taller than it is wide.
    @inlinable public init(@ViewBuilder left: () -> Left, @ViewBuilder right: () -> Right) {
        self.left = left()
        self.right = right()
        self.handle = Capsule()
    }
    
}
