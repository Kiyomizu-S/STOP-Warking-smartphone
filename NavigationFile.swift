//
//  NavigationFile.swift
//  STOP!!歩きスマホ!
//
//  Created by 清水直輝 on 2016/07/29.
//  Copyright © 2016年 清水直輝. All rights reserved.
//

import UIKit
import QuartzCore
import Spring

// アプリの説明
class SecondViewController: UIViewController {
    
    var helpMyWindow1: UIWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Controllerのタイトルを設定する.
        self.title = "このアプリについて"
        
        helpMyWindow1 = UIWindow()
        helpMyWindow1.backgroundColor = UIColor.white
        helpMyWindow1.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
        helpMyWindow1.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        helpMyWindow1.layer.cornerRadius = 20
        helpMyWindow1.makeKey()
        self.helpMyWindow1.makeKeyAndVisible()
        // TextViewを作成する.
        let helpTextView1: UITextView = UITextView(frame: CGRect(x: 0, y: 10, width: self.view.frame.width, height: self.helpMyWindow1.frame.height))
        helpTextView1.backgroundColor = UIColor.clear
        helpTextView1.text = "このアプリは歩きスマホを防止するアプリです。歩きスマホを防止するために様々な機能が搭載されています。\n・歩きスマホをした回数が記録されます。\n・歩きスマホをするとペナルティーが発生します。\n・歩きスマホを５回すると大きなペナルティーが発生します。"
        helpTextView1.font = UIFont.systemFont(ofSize: CGFloat(self.helpMyWindow1.frame.width/14))
        helpTextView1.textColor = UIColor.black
        helpTextView1.textAlignment = NSTextAlignment.left
        helpTextView1.isEditable = false
        helpTextView1.isScrollEnabled = false
        
        self.helpMyWindow1.addSubview(helpTextView1)
        
        helpMyWindow1.isHidden = true
        
        
        // Viewの背景色を定義する.
        self.view.backgroundColor = UIColor.lightGray
        
    }
    
    // 画面が表示される直前に呼び出される
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        helpMyWindow1.isHidden = false
        
    }
    
    // 画面が消える直前に呼び出される
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        helpMyWindow1.isHidden = true
        
    }
    
    
}
// グラフの説明
class ThirdViewController: UIViewController {
    
    var helpMyWindow2: UIWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Controllerのタイトルを設定する.
        self.title = "記録グラフについて"
        
        helpMyWindow2 = UIWindow()
        helpMyWindow2.backgroundColor = UIColor.white
        helpMyWindow2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
        helpMyWindow2.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        helpMyWindow2.layer.cornerRadius = 20
        helpMyWindow2.makeKey()
        self.helpMyWindow2.makeKeyAndVisible()
        // TextViewを作成する.
        let helpTextView2: UITextView = UITextView(frame: CGRect(x: 0, y: 10, width: self.view.frame.width, height: self.helpMyWindow2.frame.height))
        helpTextView2.backgroundColor = UIColor.clear
        helpTextView2.text = "グラフでは、今月の歩きスマホをした回数を記録して表しています。１月〜１２月まで記録され、一年が過ぎるとデータがリセットされます。"
        helpTextView2.font = UIFont.systemFont(ofSize: CGFloat(self.helpMyWindow2.frame.width/9.7))
        helpTextView2.textColor = UIColor.black
        helpTextView2.textAlignment = NSTextAlignment.left
        helpTextView2.isEditable = false
        helpTextView2.isScrollEnabled = false
        
        self.helpMyWindow2.addSubview(helpTextView2)
        
        helpMyWindow2.isHidden = true
        
        self.view.backgroundColor = UIColor.lightGray
        
    }
    // 画面が表示される直前に呼び出される
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.helpMyWindow2.isHidden = false
        
    }
    
    // 画面が消える直前に呼び出される
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        helpMyWindow2.isHidden = true
        
    }
    
}
// ペナルティーの説明
class ForthViewController: UIViewController {
    
    var helpMyWindow3: UIWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Controllerのタイトルを設定する
        self.title = "ペナルティーについて"
        
        helpMyWindow3 = UIWindow()
        helpMyWindow3.backgroundColor = UIColor.white
        helpMyWindow3.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
        helpMyWindow3.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        helpMyWindow3.layer.cornerRadius = 20
        helpMyWindow3.makeKey()
        self.helpMyWindow3.makeKeyAndVisible()
        // TextViewを作成する.
        let helpTextView3: UITextView = UITextView(frame: CGRect(x: 0, y: 10, width: self.view.frame.width, height: self.helpMyWindow3.frame.height))
        helpTextView3.backgroundColor = UIColor.clear
        helpTextView3.text = "歩きスマホをして発生するペナルティーは以下の通りです。\n・警告音が鳴ります。\n・顔写真を撮ってその写真を変なように編集されます。\n・大量の通知、もしくはアラートが表示されることによってスマホの処理を遅くします。"
        helpTextView3.font = UIFont.systemFont(ofSize: CGFloat(self.helpMyWindow3.frame.width/13))
        helpTextView3.textColor = UIColor.black
        helpTextView3.textAlignment = NSTextAlignment.left
        helpTextView3.isEditable = false
        helpTextView3.isScrollEnabled = false
        
        self.helpMyWindow3.addSubview(helpTextView3)
        
        helpMyWindow3.isHidden = true
        
        // Viewの背景色を定義する
        self.view.backgroundColor = UIColor.lightGray
        
    }
    
    // 画面が表示される直前に呼び出される
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.helpMyWindow3.isHidden = false
        
    }
    
    // 画面が消える直前に呼び出される
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        helpMyWindow3.isHidden = true
        
    }
    
}
// 注意事項
class FifthViewController: UIViewController {
    
    var helpMyWindow4 : UIWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Controllerのタイトルを設定する
        self.title = "注意事項"
        
        helpMyWindow4 = UIWindow()
        helpMyWindow4.backgroundColor = UIColor.white
        helpMyWindow4.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
        helpMyWindow4.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        helpMyWindow4.layer.cornerRadius = 20
        helpMyWindow4.makeKey()
        self.helpMyWindow4.makeKeyAndVisible()
        // TextViewを作成する.
        let helpTextView4: UITextView = UITextView(frame: CGRect(x: 0, y: 10, width: self.view.frame.width, height: self.helpMyWindow4.frame.height))
        helpTextView4.backgroundColor = UIColor.clear
        helpTextView4.text = "このアプリを使用する時にスポーツアプリなどを使用しないでください。アプリの誤作動につながる恐れがあります。"
        helpTextView4.font = UIFont.systemFont(ofSize: CGFloat(self.helpMyWindow4.frame.width/9))
        helpTextView4.textColor = UIColor.black
        helpTextView4.textAlignment = NSTextAlignment.left
        helpTextView4.isEditable = false
        helpTextView4.isScrollEnabled = false
        
        self.helpMyWindow4.addSubview(helpTextView4)
        
        helpMyWindow4.isHidden = true
        
        // Viewの背景色を定義する
        self.view.backgroundColor = UIColor.lightGray
        
    }
    
    // 画面が表示される直前に呼び出される
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.helpMyWindow4.isHidden = false
        
    }
    
    // 画面が消える直前に呼び出される
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        helpMyWindow4.isHidden = true
        
    }
}

// 注意事項
class SixViewController: UIViewController {
    
    var helpMyWindow5 : UIWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Controllerのタイトルを設定する
        self.title = "自動で機能のON/OFF"
        
        helpMyWindow5 = UIWindow()
        helpMyWindow5.backgroundColor = UIColor.white
        helpMyWindow5.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
        helpMyWindow5.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        helpMyWindow5.layer.cornerRadius = 20
        helpMyWindow5.makeKey()
        self.helpMyWindow5.makeKeyAndVisible()
        // TextViewを作成する.
        let helpTextView5: UITextView = UITextView(frame: CGRect(x: 0, y: 10, width: self.view.frame.width, height: self.helpMyWindow5.frame.height))
        helpTextView5.backgroundColor = UIColor.clear
        helpTextView5.text = "この機能は、車や電車などの乗り物に乗った際に自動で歩きスマホの機能を停止するという機能です。乗り物に乗っていると自動で歩きスマホの機能が停止されます。乗っていないと自動で歩きスマホの機能が開始されます。"
        helpTextView5.font = UIFont.systemFont(ofSize: CGFloat(self.helpMyWindow5.frame.width/12.5))
        helpTextView5.textColor = UIColor.black
        helpTextView5.textAlignment = NSTextAlignment.left
        helpTextView5.isEditable = false
        helpTextView5.isScrollEnabled = false
        
        self.helpMyWindow5.addSubview(helpTextView5)
        
        helpMyWindow5.isHidden = true
        
        // Viewの背景色を定義する
        self.view.backgroundColor = UIColor.lightGray
        
    }
    
    // 画面が表示される直前に呼び出される
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.helpMyWindow5.isHidden = false
        
    }
    
    // 画面が消える直前に呼び出される
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        helpMyWindow5.isHidden = true
        
    }
}

// カメラ設定
class CameraViewController: UIViewController {
    
    let cameraDafault = UserDefaults.standard
    var button1: SpringButton!
    var button2: SpringButton!
    var button3: SpringButton!
    var button4: SpringButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Controllerのタイトルを設定する
        self.title = "カメラの設定"
        
        // ナビゲーションバーの高さを取得
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height
        
        let viewHeight = self.view.bounds.height - (navBarHeight! + tabBarHeight!)
        
        // ぼかしボタンを作る
        button1 = SpringButton()
        button1.frame = CGRect(x: 0,y: 0,width: self.view.bounds.width / 1.875,height: self.view.bounds.width / 9.375)
        button1.backgroundColor = UIColor.gray
        button1.layer.masksToBounds = true
        button1.setTitle("歪み", for: UIControlState())
        button1.setTitleColor(UIColor.white, for: UIControlState())
        button1.layer.cornerRadius = self.view.bounds.width / 37.5
        button1.layer.position = CGPoint(x: self.view.frame.width/2, y: viewHeight/8 + navBarHeight!)
        button1.tag = 1
        button1.titleLabel?.font = UIFont.systemFont(ofSize: button1.frame.width/10)
        button1.addTarget(self, action: #selector(CameraViewController.onClickMyButton(_:)), for: .touchUpInside)
        self.view.addSubview(button1)
        
        // 色反転ボタンを作る
        button2 = SpringButton()
        button2.frame = CGRect(x: 0,y: 0,width: self.view.bounds.width / 1.875,height: self.view.bounds.width / 9.375)
        button2.backgroundColor = UIColor.purple
        button2.layer.masksToBounds = true
        button2.setTitle("色反転", for: UIControlState())
        button2.setTitleColor(UIColor.white, for: UIControlState())
        button2.layer.cornerRadius = self.view.bounds.width / 37.5
        button2.layer.position = CGPoint(x: self.view.frame.width/2, y:(viewHeight / 8) * 3 + navBarHeight!)
        button2.tag = 2
        button2.titleLabel?.font = UIFont.systemFont(ofSize: button1.frame.width/10)
        button2.addTarget(self, action: #selector(CameraViewController.onClickMyButton(_:)), for: .touchUpInside)
        self.view.addSubview(button2)
        
        // モザイクボタンを作る
        button3 = SpringButton()
        button3.frame = CGRect(x: 0,y: 0,width: self.view.bounds.width / 1.875,height: self.view.bounds.width / 9.375)
        button3.backgroundColor = UIColor.red
        button3.layer.masksToBounds = true
        button3.setTitle("モザイク", for: UIControlState())
        button3.setTitleColor(UIColor.white, for: UIControlState())
        button3.layer.cornerRadius = self.view.bounds.width / 37.5
        button3.layer.position = CGPoint(x: self.view.frame.width/2, y:viewHeight/1.6 + navBarHeight!)
        button3.tag = 3
        button3.titleLabel?.font = UIFont.systemFont(ofSize: button1.frame.width/10)
        button3.addTarget(self, action: #selector(CameraViewController.onClickMyButton(_:)), for: .touchUpInside)
        self.view.addSubview(button3)
        
        // 色変更ボタンを作る
        button4 = SpringButton()
        button4.frame = CGRect(x: 0,y: 0,width: self.view.bounds.width / 1.875,height: self.view.bounds.width / 9.375)
        button4.backgroundColor = UIColor.blue
        button4.layer.masksToBounds = true
        button4.setTitle("色変更", for: UIControlState())
        button4.setTitleColor(UIColor.white, for: UIControlState())
        button4.layer.cornerRadius = self.view.bounds.width / 37.5
        button4.layer.position = CGPoint(x: self.view.frame.width/2, y:(viewHeight / 8) * 7 + navBarHeight!)
        button4.tag = 4
        button4.titleLabel?.font = UIFont.systemFont(ofSize: button1.frame.width/10)
        button4.addTarget(self, action: #selector(CameraViewController.onClickMyButton(_:)), for: .touchUpInside)
        self.view.addSubview(button4)
        
        let naoki: String = cameraDafault.object(forKey: "name") as! String
        
        // スイッチを作成する
        let cameraSwicth: UISwitch = UISwitch()
        cameraSwicth.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - 200)
        cameraSwicth.tintColor = UIColor.black
        cameraSwicth.isOn = true
        cameraSwicth.addTarget(self, action: #selector(CameraViewController.onClickMySwicth(_:)), for: UIControlEvents.valueChanged)
        //self.view.addSubview(cameraSwicth)
        
        
        self.view.backgroundColor = UIColor.lightGray
        
    }
    
    internal func onClickMyButton(_ sender: UIButton){
        
        if(sender == button1){
            
            button1.animation = "pop"
            button1.duration = 1.0
            button1.animate()
            
            cameraDafault.set("歪み", forKey: "name")
            cameraDafault.synchronize()
            let name: String = cameraDafault.object(forKey: "name") as! String
            
            // 前の画面に戻る
            navigationController?.popToRootViewController(animated: true)
            
        }
        else if(sender == button2){
            
            button2.animation = "pop"
            button2.duration = 1.0
            button2.animate()
            
            cameraDafault.set("色反転", forKey: "name")
            cameraDafault.synchronize()
            let name: String = cameraDafault.object(forKey: "name") as! String
            
            // 前の画面に戻る
            navigationController?.popToRootViewController(animated: true)
        }
        else if(sender == button3){
            
            button3.animation = "pop"
            button3.duration = 1.0
            button3.animate()
            
            cameraDafault.set("モザイク", forKey: "name")
            cameraDafault.synchronize()
            let name: String = cameraDafault.object(forKey: "name") as! String
            
            // 前の画面に戻る
            navigationController?.popToRootViewController(animated: true)
        }
        else if(sender == button4){
            
            button4.animation = "pop"
            button4.duration = 1.0
            button4.animate()
            
            cameraDafault.set("色変更", forKey: "name")
            cameraDafault.synchronize()
            let name: String = cameraDafault.object(forKey: "name") as! String
            
            // 前の画面に戻る
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    internal func onClickMySwicth(_ sender: UISwitch){
        
        if sender.isOn {
            
        }
        else {
            
        }
    }
}

// アラート設定
class AlertViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Controllerのタイトルを設定する
        self.title = "カメラの設定"
        
        
        // Viewの背景色を定義する
        self.view.backgroundColor = UIColor.lightGray
        
    }
}




