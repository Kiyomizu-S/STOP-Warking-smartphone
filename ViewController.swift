//
//  ViewController.swift
//  STOP!! arukisumafo
//
//  Created by 恭弘 on 2016/06/30.
//  Copyright © 2016年 恭弘. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation
import AVFoundation
import Foundation
import CoreImage
import AudioToolbox
import SpriteKit
import Spring

class ViewController: UIViewController,CLLocationManagerDelegate,AVCaptureVideoDataOutputSampleBufferDelegate {
    //グラデーション
    fileprivate let gradientLayer = CAGradientLayer()
    //初期画面のタイトル１
    fileprivate var firstView:UILabel!
    //初期画面のタイトル２
    fileprivate var firstView2:UILabel!
    //初期画面のOKボタン
    fileprivate var okbutton : SpringButton!
    //初期画面のチェックボックス
    fileprivate var checkBox : SpringButton!
    //初期画面の注意事項のラベル
    fileprivate var explinwarningLabel : UILabel!
    //チェックボックスの保存用
    fileprivate let ud = UserDefaults.standard
    //チェックボックスの画像
    fileprivate let buttonImage : UIImage? = UIImage(named:"チェックボックス（チェックなし）.png")
    //チェックボックスの画像
    fileprivate let buttonImage2 : UIImage? = UIImage(named:"チェックボックス（チェックあり）.png")
    //チェックボックスの判定用変数
    fileprivate var check:Bool = true
    //乗り物に乗っているのか判断するための変数
    fileprivate let activityManager = CMMotionActivityManager()
    //アプリ画面のタイトル
    @IBOutlet weak var titlelabel: UILabel!
    //歩きスマホの回数表示用ラベル
    @IBOutlet weak var kaisuulabel: UILabel!
    //機能停止スイッチ
    @IBOutlet weak var kinouteisiswitch: UISwitch!
    //背景用ラベル
    @IBOutlet weak var backgroundlabel: UILabel!
    //爆弾画像
    @IBOutlet weak var bomimage: UIImageView!
    //隠れているラベル（カメラ用）
    @IBOutlet weak var hidelabel: UILabel!
    //AutoLayout用
    @IBOutlet weak var width1: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var height1: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var width2: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var height2: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var width3: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var height3: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var height5: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var width5: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var titlelabelX: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var titlelabelY: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var kaisuulabelX: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var kaisuulabelY: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var backgroundlabelX: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var backgroundlabelY: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var bomimageX: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var bomimageY: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var bomimagesizeX: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var bomimagesizeY: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var kinouteisiswitchwidth: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var kinouteisiswitchheight: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var ImageViewX: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var ImageViewY: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var ImageViewWidth: NSLayoutConstraint!
    //AutoLayout用
    @IBOutlet weak var ImageViewHeight: NSLayoutConstraint!
    //位置情報更新の防止
    fileprivate var i : Int = 0
    //画像を加工する際に入れておく変数
    fileprivate var modelimage : UIImage!
    // 歩きスマホ判定で使う変数
    fileprivate var judgment : Bool = false
    //バッテリー残量の取得
    fileprivate var batteryAmount: String!
    // 加速度センサーを使用する変数
    fileprivate var motionManager = CMMotionManager()
    //基準とするX軸
    fileprivate var plusX : Double = 0
    //基準とするY軸
    fileprivate var plusY : Double = 0
    //基準とするZ軸
    fileprivate var plusZ : Double = 0
    //加速度の計算結果
    fileprivate var CalculationResult : Double = 0
    //加速度の計算結果
    fileprivate var CalculationResult2 : Double = 0
    //位置情報の変数
    fileprivate var lm: CLLocationManager?
    // 取得した緯度を保持するインスタンス
    fileprivate var latitude: CLLocationDegrees!
    // 取得した経度を保持するインスタンス
    fileprivate var longitude: CLLocationDegrees!
    //UIDeviceクラスを呼ぶ
    fileprivate let myDevice: UIDevice = UIDevice.current
    //イメージビュー
    @IBOutlet weak var imageView: UIImageView!
    // セッション
    fileprivate var mySession : AVCaptureSession!
    // カメラデバイス
    fileprivate var myDevice2 : AVCaptureDevice!
    // 出力先
    fileprivate var myOutput : AVCaptureVideoDataOutput!
    //加速度の条件分岐の変数
    fileprivate var kirikae : Bool = true
    //加速度の条件分岐の変数２
    fileprivate var kirikae2 : Bool = true
    //機能停止用の判断をするための変数
    fileprivate var startstop : Bool = false
    //写真を撮るか撮らないか用の変数
    fileprivate var OpenOrClose : Bool = false
    // 顔検出オブジェクト
    fileprivate let detector = Detector()
    //写真の撮る間隔のための変数
    fileprivate var count:Int!=0
    //歩きスマホの回数を入れる変数
    fileprivate var Numberoftimes : Double! = 0
    //位置情報更新の回数を記録する
    fileprivate var count2 : Int! = 0
    //爆風エフェクト
    fileprivate let node = SKEmitterNode(fileNamed: "MyParticle2.sks")
    //導火線に点く火のエフェクト
    fileprivate let node2 = SKEmitterNode(fileNamed: "MyParticle3.sks")
    //上から降ってくるエフェクト
    fileprivate let node3 = SKEmitterNode(fileNamed: "MyParticle4.sks")
    //SKView
    fileprivate var v = SKView()
    //SKScene
    fileprivate var scene = SKScene()
    //爆風の表現用タイマー
    fileprivate var timer2 = Timer()
    //爆風の表現用変数
    fileprivate var kirk : Int! = 0
    //爆風の表現用変数
    fileprivate var times : Int! = 0
    //背景imageview
    @IBOutlet weak var myImageView2: UIImageView!
    //導火線
    fileprivate var myImageView: SpringImageView!
    //通知ペナルティ用変数
    fileprivate var Doublecount : Int! = 0
    
    fileprivate var myFilter = CIFilter(name:"CIPinchDistortion")!
    
    let myUserDafault2:UserDefaults = UserDefaults()
    
    var audioPlayer:AVAudioPlayer!
    
    var dateToday : Int!
    
    var RideBool : Bool! = true
    
    var judgmentOfAlert : Bool! = true
    
    override func viewDidAppear(_ animated: Bool) {
        RideBool = myUserDafault2.bool(forKey: "ride")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        hidelabel.isHidden=true
        
        hidelabel.font=UIFont(name: "Chalkduster",size:self.view.bounds.width/18.5)
        
        kinouteisiswitch.transform = CGAffineTransform(scaleX: self.view.bounds.width/350,y: self.view.bounds.height/620)
        
        myImageView2.image = UIImage(named:"安全画像（修正）.png")
        
        myImageView = SpringImageView(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width/1.29,height: self.view.bounds.height/33.5))
        
        // 画像をUIImageViewに設定する.
        self.myImageView.image = UIImage(named:"Line.gif")
        
        // 画像の表示する座標を指定する.
        myImageView.layer.position = CGPoint(x: self.view.bounds.width/1.95, y: self.view.bounds.height/1.24)
        
        // UIImageViewをViewに追加する.
        self.view.addSubview(myImageView)
        
        v = SKView(frame: view.bounds)
        v.isUserInteractionEnabled = false
        v.autoresizingMask = [.flexibleWidth]
        v.backgroundColor = UIColor.clear
        self.view.addSubview(v)
        
        scene = SKScene(size: v.frame.size)
        scene.backgroundColor = UIColor.clear
        v.presentScene(scene)
        
        let date = Date()
        let calendar = Calendar.current
        let component = (calendar as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.hour, NSCalendar.Unit.minute, NSCalendar.Unit.second], from: date)
        
        let todayDafault : UserDefaults = UserDefaults()
        
        // 今日の日付
        let now1 = Date()
        let calendar1 = Calendar(identifier: Calendar.Identifier.japanese)
        let day: DateComponents = (calendar1 as NSCalendar).components(NSCalendar.Unit.day, from: now1)
        
        dateToday = todayDafault.integer(forKey: "today")
        
        if(day.day != dateToday){
            Numberoftimes=0
            
            ud.set(Numberoftimes, forKey: "numberoftimes")
            
            ud.synchronize()
        }
        
        dateToday = day.day
        todayDafault.set(dateToday, forKey: "today")
        
        
        
        if(3 <= component.month! && component.month! <= 5){
            //春
            node3!.particleTexture=SKTexture(imageNamed:"petal3.png")
        }
        else if(6 <= component.month! && component.month! <= 8){
            //夏
            node3!.particleTexture=SKTexture(imageNamed:"himawari.png")
        }
        else if(9 <= component.month! && component.month! <= 11){
            //秋
            node3!.particleTexture=SKTexture(imageNamed:"紅葉.png")
        }
        else if(12 >= component.month! && component.month! <= 2){
            //冬
            node3!.particleTexture=SKTexture(imageNamed:"spark.png")
        }
        
        node3!.particlePositionRange.dx = self.view.bounds.width
        
        node3!.particleScale = self.view.bounds.width*0.00164383
        
        node3!.position = CGPoint(x:self.view.bounds.width/1.575,y: self.view.bounds.height*1.02)
        
        let size : CGSize = self.view.frame.size
        
        scene.addChild(node3!)
        
        self.ImageViewX.constant = size.width
        self.ImageViewY.constant = size.height
        
        self.width1.constant = size.width
        self.height1.constant = size.height/12
        
        self.titlelabelX.constant = 0
        self.titlelabelY.constant = size.height/(-2.3)
        
        titlelabel.font = UIFont(name: "Chalkduster",size:width1.constant/12)
        
        self.width2.constant = size.width
        self.height2.constant = size.height/12
        
        self.kaisuulabelX.constant = 0
        self.kaisuulabelY.constant = size.height/(-2.85)
        
        kaisuulabel.font = UIFont(name:"Chalkduster",size:width2.constant/12)
        
        self.ImageViewWidth.constant = 0
        self.ImageViewHeight.constant = size.height/(-67)
        
        self.width3.constant = size.width
        self.height3.constant = size.height/1.7
        
        //x軸
        self.backgroundlabelY.constant = 0
        //y軸
        self.backgroundlabelX.constant = size.height/2.6
        
        backgroundlabel.font = UIFont.boldSystemFont(ofSize: CGFloat(width2.constant/12))
        
        self.width5.constant = size.width
        self.height5.constant = size.height/11
        
        self.kinouteisiswitchwidth.constant = size.width/2.45
        
        self.kinouteisiswitchheight.constant = size.height/2.6
        
        self.bomimageX.constant = size.width/(-2.4)
        self.bomimageY.constant = size.height/3.25
        
        self.bomimagesizeX.constant = size.width/6.1
        self.bomimagesizeY.constant = size.height/14.5
        
        backgroundlabel.layer.zPosition=0
        kinouteisiswitch.layer.zPosition=1
        //初回起動判定
        kinouteisiswitch.isOn = true
        
        // SwitchのOn/Off切り替わりの際に、呼ばれるイベントを設定する.
        kinouteisiswitch.addTarget(self, action: #selector(ViewController.onClickMySwicth(_:)), for: UIControlEvents.valueChanged)
        
        if CMMotionActivityManager.isActivityAvailable() {
            self.activityManager.startActivityUpdates(to: OperationQueue.main,
                                                             withHandler: {
                                                                [weak self] (data: CMMotionActivity?) -> Void in
                                                                DispatchQueue.main.async(execute: {
                                                                    // アクティビティが変化するたびに呼ばれる
                                                                    if(data!.automotive == true){
                                                                        if(self!.RideBool==true){
                                                                            self!.kinouteisiswitch.isOn = false
                                                                            self!.startstop=false
                                                                            self!.lm!.stopUpdatingLocation()
                                                                        }
                                                                    }
                                                                    else if(data!.automotive == false){
                                                                        if(self!.RideBool==true){
                                                                            self!.kinouteisiswitch.isOn = true
                                                                            self!.startstop=true
                                                                            self!.lm!.startUpdatingLocation()
                                                                        }
                                                                    }
                                                                })
                })
        }
        
        /******************************* GPSを使う ***********************************/
        // フィールドの初期化
        self.lm = CLLocationManager()
        //longitude = CLLocationDegrees()
        //latitude = CLLocationDegrees()
        // CLLocationManagerをDelegateに指定
        lm!.delegate = self;
        if (!CLLocationManager.locationServicesEnabled()) {
            
        }
        self.lm!.pausesLocationUpdatesAutomatically = false;
        // 位置情報取得の許可を求めるメッセージの表示．必須．
        lm!.requestAlwaysAuthorization()
        // 位置情報の精度を指定．任意，
        lm!.desiredAccuracy = kCLLocationAccuracyBest
        // 位置情報取得間隔を指定．指定した値（メートル）移動したら位置情報を更新する．任意．
        lm!.distanceFilter = 3.0
        
        motionManager = CMMotionManager()
        motionManager.accelerometerUpdateInterval = 0.4
        // 値取得時にしたい処理を作成
        
        let accelerometerHandler:CMAccelerometerHandler = {(data:CMAccelerometerData?, error:NSError?) -> Void in
            
            //ログにx,y,zの加速度を表示
            if(self.startstop==true){
                //タイマーを作る.
                Timer.scheduledTimer(timeInterval: 0.4, target:self, selector:#selector(ViewController.onUpdate(_:)), userInfo: nil, repeats:true)
                
                if(self.kirikae==false){
                    
                    let a = fabs(self.plusY - data!.acceleration.y)*fabs(self.plusY - data!.acceleration.y)/0.5
                    let b = fabs(self.plusZ - data!.acceleration.z)*fabs(self.plusZ - data!.acceleration.z)/0.5
                    let c = fabs(self.plusX - data!.acceleration.x)*fabs(self.plusX - data!.acceleration.x)/0.5
                    
                    self.CalculationResult = sqrt(a+b)
                    self.CalculationResult2 = sqrt(a+c)
                    self.kirikae=true
                    self.kirikae2=true
                }
                
                if(self.kirikae2==true){
                    
                    self.plusX=data!.acceleration.x
                    self.plusY=data!.acceleration.y
                    self.plusZ=data!.acceleration.z
                    self.kirikae2=false
                    
                }
                
                if(self.CalculationResult <= 0.55 && self.CalculationResult > 0.25 && self.CalculationResult2 < 0.8){
                    if(data!.acceleration.y >= -0.9 && data!.acceleration.y <= -0.2 && data!.acceleration.z <= -0.2 && data!.acceleration.z >= -0.96 && data!.acceleration.x <= 0.4 && data!.acceleration.x >= -0.4){
                        self.judgment=true
                    }
                        
                    else if(fabs(data!.acceleration.x) <= 1.0 && fabs(data!.acceleration.x) >= 0.6 && data!.acceleration.z >= -0.8 && data!.acceleration.z <= -0.2 && data!.acceleration.y >= -0.25 && data!.acceleration.y <= 0.25){
                        self.judgment=true
                    }
                }
                    
                else if(self.CalculationResult > 0.3){
                    self.judgment=false
                }
                else if(self.CalculationResult <= 0.03){
                    self.judgment=false
                }
            }
        } as! CMAccelerometerHandler
        /* 加速度センサーを開始する */
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: accelerometerHandler)
        
        // --------------------------------------
        // 1. プッシュ通知に表示するアクションを生成する
        // --------------------------------------
        // アラート表示の許可をもらう.
        let setting = UIUserNotificationSettings(types: [.sound, .alert], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(setting)
        
        if ud.bool(forKey: "firstlaunch") {
            judgmentOfAlert=false
        }
        
        ud.set(false, forKey: "firstlaunch")
        
        if ud.bool(forKey: "noclick") {
            // 初回起動時の処理
            tabBarController!.tabBar.isHidden = true
            titlelabel.alpha=0
            kaisuulabel.alpha=0
            kinouteisiswitch.alpha=0
            
            okbutton=SpringButton()
            checkBox=SpringButton()
            firstView=UILabel()
            firstView2=UILabel()
            explinwarningLabel=UILabel()
            
            okbutton.frame=CGRect(x: 0,y: 0,width: self.view.bounds.width/2,height: self.view.bounds.height/7)
            firstView.frame=CGRect(x: 0,y: 0,width: self.view.bounds.width/3,height: self.view.bounds.height/7)
            firstView2.frame=CGRect(x: 0,y: 0,width: size.width,height: size.height/2.3)
            checkBox.frame=CGRect(x: 0,y: 0,width: self.view.bounds.width/11,height: self.view.bounds.height/7)
            explinwarningLabel.frame=CGRect(x: 0,y: 0,width: self.view.bounds.width/1.3,height: self.view.bounds.height/6)
            
            okbutton.backgroundColor=UIColor.white
            
            firstView.text="注意"
            explinwarningLabel.text="次回から表示しない"
            explinwarningLabel.font=UIFont.boldSystemFont(ofSize: CGFloat(size.width/12))
            firstView.font=UIFont.boldSystemFont(ofSize: CGFloat(size.width/6))
            firstView2.text="アプリ使用時にスポーツアプリなどを使用しないで下さい。\nアプリの誤作動につながる恐れがあります。"
            okbutton.setTitle("OK",for:UIControlState())
            okbutton.titleLabel?.font=UIFont(name:"Chalkduster",size:size.width/7)
            okbutton.setTitleColor(UIColor.black, for: UIControlState())
            okbutton.addTarget(self, action:#selector(ViewController.downokbutton(_:)), for: .touchDown)
            okbutton.addTarget(self, action:#selector(ViewController.onclickokbutton(_:)), for: .touchUpInside)
            checkBox.setImage(buttonImage!,for: UIControlState())
            checkBox.addTarget(self,action:#selector(ViewController.oneclickbutton(_:)),for:.touchUpInside)
            checkBox.imageView?.contentMode = UIViewContentMode.scaleAspectFit
            firstView2.layer.borderWidth = 5.0
            firstView2.layer.borderColor = UIColor.white.cgColor
            firstView2.numberOfLines=6
            explinwarningLabel.numberOfLines=1
            firstView.textAlignment = NSTextAlignment.center
            firstView2.font=UIFont.boldSystemFont(ofSize: CGFloat(size.height/17))
            firstView.textColor=UIColor.white
            firstView2.textColor=UIColor.white
            explinwarningLabel.textColor=UIColor.white
            firstView.layer.position=CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/8)
            firstView2.layer.position=CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/2.4)
            explinwarningLabel.layer.position=CGPoint(x:self.view.bounds.width/1.8,y:self.view.bounds.height/1.45)
            okbutton.layer.position=CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height-(self.view.bounds.height/6))
            checkBox.layer.position=CGPoint(x:self.view.bounds.width/12,y:self.view.bounds.height/1.45)
            self.view.backgroundColor = UIColor.white
            
            // 2
            gradientLayer.frame = self.view.bounds
            
            // 3
            let color1 = UIColor.black.cgColor as CGColor
            let color2 = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor as CGColor
            let color3 = UIColor.black.cgColor as CGColor
            let color4 = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor as CGColor
            gradientLayer.colors = [color1, color2, color3, color4, color1, color2, color3, color4]
            
            // 4
            //gradientLayer.locations = [0.375, 0.375, 0.375, 0.375, 0.375, 0.375, 0.375, 0.375]
            
            // 5
            self.view.layer.addSublayer(gradientLayer)
            self.view.addSubview(firstView)
            self.view.addSubview(firstView2)
            self.view.addSubview(okbutton)
            self.view.addSubview(checkBox)
            self.view.addSubview(explinwarningLabel)
            
        }else{
            lm!.startUpdatingLocation()
            startstop=true
        }
        
    }
    
    internal func onClickMySwicth(_ sender: UISwitch){
        if(sender.isOn){
            startstop=true
            lm!.startUpdatingLocation()
        }else{
            startstop=false
            lm!.stopUpdatingLocation()
        }
    }
    
    func onUpdate(_ timer:Timer){
        kirikae=false
        if(i != 30){
            i=i+1
        }
    }
    
    func downokbutton(_ sender:UIButton){
        okbutton.animation = "pop"
        okbutton.animate()
        okbutton.animation = "swing"
        okbutton.animate()
    }
    
    func onclickokbutton(_ sender:UIButton){
        
        if(judgmentOfAlert==false){
            let alert: UIAlertController = UIAlertController(title: "設定画面に行きます", message: "通知のスタイルを「通知」にしてください", preferredStyle:  UIAlertControllerStyle.alert)
            
            // ② Actionの設定
            // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
            // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
            // OKボタン
            let defaultAction: UIAlertAction = UIAlertAction(title: "設定する", style: UIAlertActionStyle.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                let osVersion = UIDevice.current.systemVersion
                if osVersion < "8.0" {
                    // not supported
                    let alert = UIAlertView()
                    alert.title = "iosのバージョンが8.0未満です"
                    alert.message = "iosのバージョンをアップデートしてください"
                    alert.addButton(withTitle: "OK")
                    alert.show()
                    
                }else{
                    let url = URL(string:UIApplicationOpenSettingsURLString)!
                    UIApplication.shared.openURL(url)
                }
            })
            // キャンセルボタン
            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                
            })
            
            // ③ UIAlertControllerにActionを追加
            alert.addAction(defaultAction)
            alert.addAction(cancelAction)
            
            // ④ Alertを表示
            present(alert, animated: true, completion: nil)
        }
        
        
        tabBarController!.tabBar.isHidden = false
        // GPSの使用を開始する
        lm!.startUpdatingLocation()
        startstop=true
        
        // radianで回転角度を指定(90度).
        let angle:CGFloat = CGFloat(M_PI)
        
        // アニメーションの秒数を設定(3秒).
        UIView.animate(withDuration: 4.0,
                                   
                                   animations: { () -> Void in
                                    
                                    // 回転用のアフィン行列を生成.
                                    self.firstView.transform = CGAffineTransform(rotationAngle: angle)
                                    self.firstView.alpha=0
                                    self.firstView2.transform = CGAffineTransform(rotationAngle: angle)
                                    self.firstView2.alpha=0
                                    self.okbutton.transform = CGAffineTransform(rotationAngle: angle)
                                    self.okbutton.alpha=0
                                    self.checkBox.transform = CGAffineTransform(rotationAngle: angle)
                                    self.checkBox.alpha=0
                                    self.explinwarningLabel.alpha=0
                                    self.titlelabel.alpha=1
                                    self.kaisuulabel.alpha=1
                                    self.kinouteisiswitch.alpha=1
                                    self.gradientLayer.isHidden=true
            },completion: { (Bool) -> Void in
        })
    }
    
    func oneclickbutton(_ sendfer:UIButton){
        //チェックマークを付けた場合
        if(check==true){
            checkBox.setImage(buttonImage2!,for: UIControlState())
            
            // 2回目以降の起動では「noclick」のkeyをfalseに
            ud.set(false, forKey: "noclick")
            check=false
        }
            //チェックマークを外した場合
        else if (check==false){
            checkBox.setImage(buttonImage!,for: UIControlState())
            ud.removeObject(forKey: "noclick")
            check=true
        }
        checkBox.animation = "pop"
        checkBox.animate()
    }
    
    /*************************あカメラ処理**************************/
    
    // カメラの準備処理
    func initCamera() -> Bool {
        // セッションの作成.
        mySession = AVCaptureSession()
        
        // 解像度の指定.
        mySession.sessionPreset = AVCaptureSessionPresetMedium
        
        let devices = AVCaptureDevice.devices()
        
        // バックカメラをmyDeviceに格納.
        for device in devices! {
            if((device as AnyObject).position == AVCaptureDevicePosition.front){
                //                if(device.position == AVCaptureDevicePosition.Back){
                myDevice2 = device as! AVCaptureDevice
            }
        }
        if myDevice2 == nil
        {
            return false
        }
        
        // バックカメラからVideoInputを取得.
        var myInput: AVCaptureDeviceInput! = nil
        do {
            myInput = try AVCaptureDeviceInput(device: myDevice2) as AVCaptureDeviceInput
        } catch let error {
        }
        
        // セッションに追加.
        if mySession.canAddInput(myInput) {
            mySession.addInput(myInput)
        } else {
            return false
        }
        
        // 出力先を設定
        myOutput = AVCaptureVideoDataOutput()
        myOutput.videoSettings = [ kCVPixelBufferPixelFormatTypeKey as AnyHashable: Int(kCVPixelFormatType_32BGRA) ]
        
        // FPSを設定
        do {
            try myDevice2.lockForConfiguration()
            
            myDevice2.activeVideoMinFrameDuration = CMTimeMake(1, 15)
            myDevice2.unlockForConfiguration()
        } catch let error {
            return false
        }
        
        // デリゲートを設定
        let queue: DispatchQueue = DispatchQueue(label: "queue",  attributes: [])
        myOutput.setSampleBufferDelegate(self, queue: queue)
        
        
        // 遅れてきたフレームは無視する
        myOutput.alwaysDiscardsLateVideoFrames = true
        
        // セッションに追加.
        if mySession.canAddOutput(myOutput) {
            mySession.addOutput(myOutput)
        } else {
            return false
        }
        
        // カメラの向きを合わせる
        for connection in myOutput.connections {
            if let conn = connection as? AVCaptureConnection {
                if conn.isVideoOrientationSupported {
                    conn.videoOrientation = AVCaptureVideoOrientation.portrait
                }
            }
        }
        return true
    }
    
    // 毎フレーム実行される処理
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!)
    {
        let image = CameraUtil.imageFromSampleBuffer(sampleBuffer)
        // 顔認識
        self.detector?.recognizeFace(image)
        // UIImageへ変換
        DispatchQueue.main.async(execute: {
            // UIImageへ変換
            if(self.OpenOrClose==true){
                if(hantei==false){
                    self.imageView.image = image
                }
                else if(hantei == true){
                    
                    self.imageView.image = image
                    // UIImageViewをビューに追加
                    if var _:AVCaptureConnection? = self.myOutput.connection(withMediaType: AVMediaTypeVideo){
                        
                        ///////////********画像加工*********///////////
                        //カメラの表示選択
                        let name: String = self.myUserDafault2.object(forKey: "name") as! String
                        
                        if(name=="ぼかし"){
                            //カラーエフェクトを指定してCIFilterをインスタンス化
                            self.myFilter = CIFilter(name:"CIPinchDistortion")!
                            
                            // 中心をセット.(歪ませる時に必須)
                            self.myFilter.setValue(CIVector(cgPoint: CGPoint(x: centerX, y: centerY)), forKey:"inputCenter")
                            
                        }
                            
                        else if(name=="色反転"){
                            self.myFilter = CIFilter(name: "CIColorInvert")!
                            
                        }
                            
                        else if(name=="色変更"){
                            self.myFilter = CIFilter(name: "CIColorCrossPolynomial")!
                            
                            // RGBの変換値を作成.
                            let r: [CGFloat] = [0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
                            let g: [CGFloat] = [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
                            let b: [CGFloat] = [1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
                            
                            // モノクロ化するための値の調整.
                            self.myFilter.setValue(CIVector(values: r, count: 10), forKey: "inputRedCoefficients")
                            self.myFilter.setValue(CIVector(values: g, count: 10), forKey: "inputGreenCoefficients")
                            self.myFilter.setValue(CIVector(values: b, count: 10), forKey: "inputBlueCoefficients")
                        }
                            
                        else if(name=="モザイク"){
                            // CIFilterを生成。nameにどんなを処理するのか記入.
                            self.myFilter = CIFilter(name: "CIPixellate")!
                        }
                        //イメージのセット
                        self.myFilter.setValue(CIImage(image: self.imageView.image!), forKey: kCIInputImageKey)
                        
                        //フィルターを通した画像をアウトプット
                        let myOutputImage : CIImage = self.myFilter.outputImage!
                        
                        // 再びUIViewにセット.
                        self.modelimage = UIImage(ciImage: myOutputImage)
                        // 再描画.
                        self.imageView.setNeedsDisplay()
                        
                        self.imageView.image = self.modelimage
                        
                        // アルバムに追加
                        // ----- 合成した画像を保存する
                        UIGraphicsBeginImageContext(self.imageView.bounds.size)
                        self.imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
                        UIImageWriteToSavedPhotosAlbum(UIGraphicsGetImageFromCurrentImageContext()!, self, nil, nil)
                        UIGraphicsEndImageContext()
                        self.count=0
                        self.OpenOrClose=false
                        self.mySession.stopRunning()
                        self.hidelabel.isHidden=true
                        self.imageView.layer.borderWidth=0
                        self.imageView.layer.borderColor=nil
                        self.imageView.image=nil
                    }
                }
            }
            hantei=false
        })
    }
    
    /*************************カメラ処理（終わり）**************************/
    
    /************************* 位置情報取得成功時に実行される関数 ****************************/
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if(judgment == true) {
            if(i>=30){
                
                if(times==0){
                    self.myImageView2.image = UIImage(named:"安全画像（修正）.png")
                }
                
                Numberoftimes=myUserDafault2.double(forKey: "numberoftimes")+1
                
                let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
                appDelegate.walkcount = Numberoftimes
                
                // Notificationの生成する.
                let myNotification: UILocalNotification = UILocalNotification()
                
                // メッセージを代入する.
                myNotification.alertBody = "歩きスマホ\(Int(Numberoftimes))回目です。"
                
                // Timezoneを設定をする.
                myNotification.timeZone = TimeZone.current
                
                // Notificationを表示する.
                UIApplication.shared.scheduleLocalNotification(myNotification)
                
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                
                times=times+1
                
                if(Numberoftimes > 5){
                    times=Int(Numberoftimes)%5
                }
                
                kaisuulabel.text="\(Int(Numberoftimes))回"
                
                ud.set(Numberoftimes, forKey: "numberoftimes")
                
                ud.synchronize()
                
                self.OpenOrClose=true
                
                //ペナルティーの選択している場所
                let count3:Int = myUserDafault2.integer(forKey: "VisitCount2")
                //警告音の種類の選択
                let count4:Int = myUserDafault2.integer(forKey: "VisitCount")
                
                var filePath = Bundle.main.path(forResource: "alert", ofType: "mp3")
                
                if(count3==0){
                    if(times != 5){
                        do {
                            if(count4==0){
                                filePath = Bundle.main.path(forResource: "alert", ofType: "mp3")
                            }
                            else if(count4==1){
                                filePath = Bundle.main.path(forResource: "alert41", ofType: "mp3")
                            }
                            else if(count4==2){
                                filePath = Bundle.main.path(forResource: "meka_ge_keihou03", ofType: "mp3")
                            }
                            else if(count4==3){
                                filePath = Bundle.main.path(forResource: "meka_ge_keihou06", ofType: "mp3")
                            }
                            else if(count4==4){
                                filePath = Bundle.main.path(forResource: "meka_ge_keitai_tyakushin01", ofType: "mp3")
                            }
                            let audioPath = URL(fileURLWithPath: filePath!)
                            audioPlayer = try AVAudioPlayer(contentsOf: audioPath)
                            audioPlayer.prepareToPlay()
                            audioPlayer.play() // 音楽の再生0bv
                        } catch {
                        }
                    }
                }
                    
                else if(count3==1){
                    if(times != 5){
                        if initCamera() {
                            // 撮影開始
                            mySession.startRunning()
                            imageView.layer.borderWidth=3.0
                            imageView.layer.borderColor=UIColor.red.cgColor
                            hidelabel.isHidden=false
                        }
                    }
                }
                    
                else if(count3==2){
                    if(times != 5){
                        while(Doublecount<=20){
                            let myNotification2: UILocalNotification = UILocalNotification()
                            
                            // メッセージを代入する.
                            myNotification2.alertBody = "危ない歩きスマホ！！"
                            
                            // Timezoneを設定をする.
                            myNotification2.timeZone = TimeZone.current
                            
                            // Notificationを表示する.
                            UIApplication.shared.scheduleLocalNotification(myNotification2)
                            
                            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                            Doublecount=Doublecount+1
                        }
                        Doublecount=0
                    }
                }
                
                
                if(times<=5){
                    
                    bomimage.alpha=1
                    
                    node2!.removeFromParent()
                    
                    let position = self.view.bounds.width/5*(CGFloat(times)-1) + self.view.bounds.width/11
                    node2!.particleSize=CGSize(width: 40,height: 60)
                    node2!.position = CGPoint(x:self.view.bounds.width-position,y:self.view.bounds.height/5.3)
                    scene.addChild(node2!)
                    
                    myImageView.removeFromSuperview()
                    
                    myImageView = SpringImageView(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width/1.29-(self.view.bounds.width/1.29*1.39/5*(CGFloat(times)-1)),height: self.view.bounds.height/33.5))
                    
                    // 画像をUIImageViewに設定する.
                    myImageView.image = UIImage(named:"Line.gif")
                    
                    // 画像の表示する座標を指定する.
                    myImageView.layer.position = CGPoint(x: self.view.bounds.width/1.95-(self.view.bounds.width/1.29*1.39/5*CGFloat(times-1))/2, y: self.view.bounds.height/1.24)
                    
                    // UIImageViewをViewに追加する.
                    self.view.addSubview(myImageView)
                    
                    if(times==3){
                        self.myImageView2.image = UIImage(named:"注意.png")
                    }
                    
                }
                if(times==0){
                    do {
                        if(count4==0){
                            filePath = Bundle.main.path(forResource: "alert", ofType: "mp3")
                        }
                        else if(count4==1){
                            filePath = Bundle.main.path(forResource: "alert41", ofType: "mp3")
                        }
                        else if(count4==2){
                            filePath = Bundle.main.path(forResource: "meka_ge_keihou03", ofType: "mp3")
                        }
                        else if(count4==3){
                            filePath = Bundle.main.path(forResource: "meka_ge_keihou06", ofType: "mp3")
                        }
                        else if(count4==4){
                            filePath = Bundle.main.path(forResource: "meka_ge_keitai_tyakushin01", ofType: "mp3")
                        }
                        let audioPath = URL(fileURLWithPath: filePath!)
                        audioPlayer = try AVAudioPlayer(contentsOf: audioPath)
                        audioPlayer.prepareToPlay()
                        audioPlayer.play() // 音楽の再生0bv
                    } catch {
                    }
                    
                    if initCamera() {
                        // 撮影開始
                        mySession.startRunning()
                        imageView.layer.borderWidth=3.0
                        imageView.layer.borderColor=UIColor.red.cgColor
                        hidelabel.isHidden=false
                    }
                    
                    while(Doublecount<=20){
                        let myNotification2: UILocalNotification = UILocalNotification()
                        
                        // メッセージを代入する.
                        myNotification2.alertBody = "危ない歩きスマホ！！"
                        
                        // Timezoneを設定をする.
                        myNotification2.timeZone = TimeZone.current
                        
                        // Notificationを表示する.
                        UIApplication.shared.scheduleLocalNotification(myNotification2)
                        
                        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                        Doublecount=Doublecount+1
                    }
                    Doublecount=0
                    
                    node2!.removeFromParent()
                    node!.alpha = 0.0
                    node!.particleScale = 0.0
                    self.node!.removeFromParent()
                    node!.position = CGPoint(x:self.view.bounds.width/1.1/(CGFloat(times)+6),y:self.view.bounds.height/5.5)
                    scene.addChild(node!)
                    bomimage.alpha=0
                    myImageView.alpha=0
                    self.myImageView2.image = UIImage(named:"危険.png")
                    times=0
                    if(node!.alpha < 1 && timer2.isValid==false){
                        timer2 = Timer.scheduledTimer(timeInterval: 0.01, target:self, selector:#selector(ViewController.cometime(_:)), userInfo: nil, repeats:true)
                    }
                }
            }
        }
        // 取得した緯度がnewLocation.coordinate.longitudeに格納されている
        //latitude = newLocation.coordinate.latitude
        //latitude = locations.coordinate.latitude
        // 取得した経度がnewLocation.coordinate.longitudeに格納されている
        //longitude = CLLocation.coordinate.longitude
        // 取得した緯度・経度をLogに表示
        //NSLog("latiitude: \(latitude) , longitude: \(longitude)")
        
        // GPSの使用を停止する．停止しない限りGPSは実行され，指定間隔で更新され続ける．
        //lm!.stopUpdatingLocation()
    }
    
    /* 位置情報取得失敗時に実行される関数 */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // この例ではLogにErrorと表示するだけ．
        NSLog("Error")
        
    }
    
    func cometime(_ time:Timer){
        if(kirk==0){
            node?.alpha += 0.01
            node?.particleScale += 0.02
        }
        else if(kirk==1){
            
            node?.alpha -= 0.01
            node?.particleScale -= 0.02
        }
        if(node!.alpha>=1.0 && kirk == 0){
            node?.particleTexture=SKTexture(imageNamed: "Fire.png")
            kirk=1
        }
        else if(node!.alpha <= 0.0 && kirk == 1){
            node?.particleTexture=SKTexture(imageNamed: "petal3.png")
            timer2.invalidate()
            kirk=0
        }
    }
    
    /************************* 位置情報取得成功時に実行される関数（終わり）****************************/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

