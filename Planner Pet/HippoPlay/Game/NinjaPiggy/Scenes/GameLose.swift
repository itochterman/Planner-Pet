//
//  GameLose.swift
//  NinjaPiggy


import Foundation
import SpriteKit

class GameLose:SKScene {
    
    private var learningNode:SKSpriteNode?
    private var playNode:SKSpriteNode?
 
    override func didMove(to view: SKView) {
        learningNode = childNode(withName: "Learning") as? SKSpriteNode
        playNode = childNode(withName: "Play") as? SKSpriteNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            // 点击开始游戏按钮
            if (playNode?.contains(touchLocation))! {
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let scene = GameScene(size: CGSize(width: 2048, height: 1536))
                scene.scaleMode = .aspectFill
                self.view?.presentScene(scene, transition:reveal)
            }
            // 点击返回按钮 -- 返回河马日历
            if (learningNode?.contains(touchLocation))!{
                let notificationNormalName = Notification.Name(rawValue: "gobackNormalVC")
                NotificationCenter.default.post(name: notificationNormalName, object: self,
                                                userInfo: nil)
            }
        }
        
    }
}