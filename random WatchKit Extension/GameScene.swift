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
    
    let clickSoundAction = SKAction.playSoundFileNamed("Media Keys.aif", waitForCompletion: false)

    override func sceneDidLoad() {
        // This method is called once at the beginning like `setup()` on Arduino
        
        crownSequencer.delegate = self
        crownSequencer.focus()
        
        generateLines()
        
        addChild(lines)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // This method is called every frame like `loop()` on Arduino
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        // This method is called when the crown is rotated, use `rotationalDelta` to reduce sensitivity
        
        WKInterfaceDevice.current().play(.click)
        lines.run(clickSoundAction)
        
        let nextPoint = array[(index+1) % array.count]
        drawLine(from: array[index], to: nextPoint)
        
        index = (index+1) % array.count
    }
    
    func generateLines() {
        let width2 = Int(self.size.width/2)
        let height2 = Int(self.size.height/2)
        
        array = []
        
        for _ in 0..<256 {
            let point = CGPoint(x: Int.random(in: -width2..<width2), y: Int.random(in: -height2..<height2))
            array.append(point)
        }
    }
    
    func reset() {
        lines.removeAllChildren()
        index = 0
        generateLines()
        
        let soundAction = SKAction.playSoundFileNamed("empty trash.aif", waitForCompletion: false)
        lines.run(soundAction)
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
