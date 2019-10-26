//
//  CrossHair.swift
//  
//
//  Created by Kieran Brown on 10/26/19.
//

import Foundation
import SwiftUI


/// # Draws a Crosshair
/// Works pretty well with grid partitions but doesnt make sense for the vertical and horizontal partitions. 
@available(iOS 13.0, macOS 10.15, watchOS 6.0 , tvOS 13.0, *)
public struct CrossHair: View {
    var color: Color
    var length: CGFloat
    func line(angle: CGFloat, proxy: GeometryProxy) -> some View {
        let midX = proxy.frame(in: .local).width/2
        let midY = proxy.frame(in: .local).height/2
        
        return Path { p in
            p.move(to: CGPoint(x: midX, y: midY-9))
            p.addLine(to: CGPoint(x: midX, y: midY+length))
        }.rotation(Angle(degrees: Double(angle)), anchor: .top)
        .stroke(color, lineWidth: 5)
    }
    
    /// # Crosshair
    /// - parameters:
    ///    - color  The color of the crosshair
    ///    - lineLength: The length of each of the for lines that converge to the center of the crosshair. 
    public init(color: Color = .black, lineLength: CGFloat = 20) {
        self.color = color
        self.length = lineLength
    }
    
    public var body: some View {
        ZStack {
            
            
            Circle().stroke(self.color, lineWidth: 4).frame(width: 40, height: 40)
            .overlay(GeometryReader { (proxy: GeometryProxy) in
                ZStack {
                    self.line(angle: 0, proxy: proxy)
                    self.line(angle: 90, proxy: proxy)
                    self.line(angle: 180, proxy: proxy)
                    self.line(angle: 270, proxy: proxy)
                }.offset(CGSize(width: 0, height: proxy.frame(in: .local).height/2))
            })
            
            
        }
    }
}
