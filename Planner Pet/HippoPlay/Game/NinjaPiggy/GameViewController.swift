//
//  GameViewController.swift
//  HippoPlay
//
//  Created by Wenyin Zheng on 2019/4/23.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

import UIKit
import SpriteKit

@objc(GameViewControllerDelegate)
protocol GameViewControllerDelegate {
    func playGameSuccess()
}

class GameViewController: UIViewController {

    let notificationSuccessName = Notification.Name(rawValue: "gobackSuccessVC")
    let notificationNormalName = Notification.Name(rawValue: "gobackNormalVC")
    public var successPlayBlock:(() -> Void)!
    @objc var delegate : GameViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        let sceneStart = SKScene(fileNamed: "GameStart")
        sceneStart?.size = CGSize(width: 2048, height: 1536)
        // let scene = GameScene(size:CGSize(width: 2048, height: 1536))
        // let scene = GameScene(size:self.view.bounds.size) // view指手机屏幕的尺寸;
        // iPhone 5=>320 | iPhone/6/7/8=>375
        // print(scene.size)
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        sceneStart?.scaleMode = .aspectFill
        skView.presentScene(sceneStart)
        self.dismiss(animated: true, completion: nil)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(backSuccess(notification:)),
                                               name: notificationSuccessName, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(backNormal(notification:)),
                                               name: notificationNormalName, object: nil)
        
    }
    
//    init(successPlayBlock: @escaping () -> Void) {
//        super.init(nibName: nil, bundle: nil)
//        self.successPlayBlock = successPlayBlock
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    @objc func backNormal(notification: Notification) {
        
        self.dismiss(animated: true) {
            
        }
    }
    
    @objc func backSuccess(notification: Notification) {
        self.dismiss(animated: true) {
            self.delegate?.playGameSuccess()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(notificationNormalName)
        NotificationCenter.default.removeObserver(notificationSuccessName)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let currentAppDelegate = UIApplication.shared.delegate as! AppDelegate
        currentAppDelegate.allowAcrolls = true
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let currentAppDelegate = UIApplication.shared.delegate as! AppDelegate
        currentAppDelegate.allowAcrolls = false
        

        let unknownValue = UIInterfaceOrientation.unknown.rawValue
        UIDevice.current.setValue(unknownValue, forKey: "orientation")


        let orientationTarget = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(orientationTarget, forKey: "orientation")
    }
    


}
