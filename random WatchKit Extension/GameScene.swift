//
//  GameScene.swift
//  random WatchKit Extension
//
//  Created by mt on 13.11.20.
//

import WatchKit
import SpriteKit

class GameScene: SKScene, WKCrownDelegate {
    let crownSequencer = WKExtension.shared().rootInterfaceController!.crownSequencer
    
    var index = 0
    var array:[CGPoint] = []
    var lines:SKShapeNode = SKShapeNode()
    

    override func sceneDidLoad() {
        crownSequencer.delegate = self
        crownSequencer.focus()
        
        generateLines()
        
        addChild(lines)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // This method is called every frame
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        // This method is called when the crown is rotated
        
        let nextPoint = array[(index+1) % array.count]
        drawLine(from: array[index], to: nextPoint)
        
        index = (index+1) % array.count
    }
    
    func generateLines() {
        let width = Int(self.size.width)
        let height = Int(self.size.height)
        
        print(width, height)
        
        for _ in 0..<256 {
            let point = CGPoint(x: Int.random(in: -width..<width), y: Int.random(in: -height..<height))
            array.append(point)
        }
    }
    
    func reset() {
        lines.removeAllChildren()
        index = 0
        generateLines()
    }

    
    func drawLine(from: CGPoint, to: CGPoint) {
        let line = SKShapeNode()
        let path = CGMutablePath()
        path.addLines(between: [from, to])
        line.path = path
        line.strokeColor = .random()
        line.lineWidth = 2
        lines.addChild(line)
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
