//
//  TabBarController.swift
//  STOP!! Arukisumapho
//
//  Created by 恭弘 on 2016/07/31.
//  Copyright © 2016年 恭弘. All rights reserved.
//

import UIKit
import SpriteKit

class TabBar: UITabBar {
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        let sizeheight = UIScreen.main.bounds.size.height/13
        size.height = sizeheight
        
        return size
    }
    
}

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    fileprivate let node = SKEmitterNode(fileNamed: "MyParticle.sks")
    
    fileprivate var scenee = SKScene()
    
    fileprivate var timer2 = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
        scenee = appDelegate.scene
        
        self.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        
        switch item.tag {
        case 1:
            node!.alpha = 1.0
            
            self.node!.removeFromParent()
            
            node!.position = CGPoint(x: scenee.frame.width / 6, y: 20)
            
            scenee.addChild(node!)
            
            if(node!.alpha > 0 && timer2.isValid==false){
                timer2 = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(TabBarController.cometime(_:)), userInfo: nil, repeats:true)
            }
            
        //１番目
        case 2:
            node!.alpha = 1.0
            
            self.node!.removeFromParent()
            
            node!.position = CGPoint(x: scenee.frame.width / 2, y: 20)
            
            scenee.addChild(node!)
            
            if(node!.alpha > 0 && timer2.isValid==false){
                timer2 = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(ViewController.cometime(_:)), userInfo: nil, repeats:true)
            }
        //２番目
        case 3:
            //３番目
            node!.alpha = 1.0
            
            self.node!.removeFromParent()
            
            node!.position = CGPoint(x: scenee.frame.width / 1.2, y: 20)
            
            scenee.addChild(node!)
            
            if(node!.alpha > 0 && timer2.isValid==false){
                timer2 = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(ViewController.cometime(_:)), userInfo: nil, repeats:true)
            }
        default:
            return
        }
    }
    
    func cometime(_ time:Timer){
        node?.alpha -= 0.1
        if(node!.alpha<=0.0){
            timer2.invalidate()
        }
        
    }
    
}
