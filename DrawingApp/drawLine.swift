//
//  drawLine.swift
//  DrawingApp
//
//  Created by RoYzH on 2/10/17.
//  Copyright © 2017 RoYzH. All rights reserved.
//

import UIKit

class drawLine: UIView {
    
    var draws: Draw? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = createQuadPath(points: (draws?.points)!)
        path.lineWidth = 1 + (draws?.thick)! * 19
        UIColor(red: (draws?.red)!, green: (draws?.green)!, blue: (draws?.blue)!, alpha: 1.0).setStroke()
        path.lineCapStyle = CGLineCap.round
        
        path.stroke(with: CGBlendMode.normal, alpha: (draws?.opacity)!)
    }
    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        // implement this function here
        draws?.tool.center = CGPoint(x: (first.x + second.x) / 2, y: (first.y + second.y) / 2 + (draws?.toolCenterShift)!)
        return CGPoint(x: (first.x + second.x) / 2, y: (first.y + second.y) / 2)
    }
    
    func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        if points.count < 2 { return path }
        let firstPoint = points[0]
        let secondPoint = points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        path.addLine(to: firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentPoint = points[index]
            let nextPoint = points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
        }
        guard let lastLocation = points.last else { return path }
        path.addLine(to: lastLocation)
        return path
    }
}
