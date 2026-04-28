//
//  ShapeWithArc.swift
//  SwiftUIAdvanced
//
//  Created by Abdul Aleem on 04/04/26.
//



import Foundation
import SwiftUI


struct ShapeWithArc: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            // top left
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            
            // top right
            path.addLine(to:CGPoint(x: rect.maxX, y: rect.minY))
            
            //mid right
            path.addLine(to:CGPoint(x: rect.maxX, y: rect.midY))
            
            // bottom
//            path.addLine(to:CGPoint(x: rect.midX, y: rect.maxY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
//                center: CGPoint(x: rect.midX, y: rect.midY - 60),
                radius: rect.height / 2,
                startAngle:  Angle(degrees: 0),
                endAngle: Angle(degrees: 180),
                clockwise: false
            )
            
            // mid left
            path.addLine(to:CGPoint(x: rect.minX, y: rect.midY))
        }
    }
}
