//
//  CurvedSideRectangle.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 2/28/24.
//

import Foundation
import SwiftUI


struct CurveSidedRectangle: Shape {
    var curveHeightTop: CGFloat
    var curveHeightBottom: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint.zero)
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY), control: CGPoint(x: rect.midX, y: rect.minY + curveHeightTop))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY), control: CGPoint(x: rect.midX, y: rect.maxY + curveHeightBottom))
        path.closeSubpath()
        return path
    }
}

struct CurveSidedRectangle_Previews: PreviewProvider {
    static var previews: some View {
        CurveSidedRectangle(curveHeightTop: 50, curveHeightBottom: -50)
            .frame(height: 300)
    }
}
