//
//  InterfaceController.swift
//  random WatchKit Extension
//
//  Created by mt on 13.11.20.
//

import WatchKit
import SpriteKit


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var skInterface: WKInterfaceSKScene!
    var scene: SKScene? = nil

    @IBAction func onTap(_ sender: Any) {
        if let gs = scene as? GameScene {
            gs.reset()
        }
    }
    
    override func awake(withContext context: Any?) {
        if let gs = GameScene(fileNamed: "GameScene") {
            scene = gs
            
            crownSequencer.focus()
            
            // Set the scale mode to scale to fit the window
            gs.scaleMode = .aspectFill
            
            // Present the scene
            self.skInterface.presentScene(scene)
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}
