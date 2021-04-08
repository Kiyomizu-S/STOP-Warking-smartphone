//
//  AppDelegate.swift
//  エフェクト
//
//  Created by 清水直輝 on 2016/06/30.
//  Copyright © 2016年 清水直輝. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation
import SpriteKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var backgroundTaskID : UIBackgroundTaskIdentifier = 0
    
    var v = SKView()
    
    var scene = SKScene()
    
    var walkcount:Double!
    
    // 一年分のグラフの値を格納する配列
    var yearsGraphArray: [[Double]] = [[],[],[],[],[],[],[],[],[],[],[],[]]
    var mySwiftData = DBFile()
    
    // 各月の日数を格納するためのグローバル変数
    var Jan = 0
    var Feb = 0
    var Mar = 0
    var Apl = 0
    var May = 0
    var Jun = 0
    var Jul = 0
    var Aug = 0
    var Sep = 0
    var Oct = 0
    var Nov = 0
    var Dec = 0
    
    /*** 保存変数 ***/
    // 警告音を保存
    var soundDafault:UserDefaults = UserDefaults()
    
    // 選択したペナルティーの保存
    var penaltyDafault:UserDefaults = UserDefaults()
    
    // グラフの値を保存
    var graphDafault:UserDefaults = UserDefaults()
    
    // カメラの変更内容を保存
    let cameraDafault = UserDefaults.standard
    
    var myNavigationController: UINavigationController?
    
    // カメラの初回起動時の設定に使う
    var cameraFirst: Bool = true
    
    /**********アプリ起動時に呼ばれる.***********/
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // first time to launch this app
        let defaults = UserDefaults.standard
        
        var dic = ["firstlaunch": true]
        defaults.register(defaults: dic)
        
        var dic2 = ["noclick": true]
        defaults.register(defaults: dic2)
        
        
        walkcount=0
        
        if let tabBarController = window?.rootViewController as? UITabBarController {
            let tabBar = tabBarController.tabBar
            v = SKView(frame: tabBar.bounds)
            v.isUserInteractionEnabled = false
            v.autoresizingMask = [.flexibleWidth]
            v.backgroundColor = UIColor.clear
            tabBarController.tabBar.addSubview(v)
            
            scene = SKScene(size: v.frame.size)
            scene.backgroundColor = UIColor.clear
            v.presentScene(scene)
        }
        
        // tableViewの初回起動時の処理を実行するための変数
        let firstDefaults = UserDefaults.standard
        let first = ["first": true]
        firstDefaults.register(defaults: first)
        
        let firstDefaults2 = UserDefaults.standard
        let first2 = ["first2": true]
        firstDefaults2.register(defaults: first2)
        
        let cameraDefaults = UserDefaults.standard
        let Cfirst = ["Cfirst": true]
        cameraDefaults.register(defaults: Cfirst)
        
        let alertSetting = UserDefaults.standard
        let alert = ["alert": true]
        alertSetting.register(defaults: alert)
        
        // グラフの値を初回起動時に初期化する
        let graphDafault = UserDefaults.standard
        let graph = ["graph": true]
        graphDafault.register(defaults: graph)
        
        /************************* 配列を保存 **************************/
        // 警告音を保存するcount変数
        let count : Int = soundDafault.integer(forKey: "VisitCount")
        soundDafault.set(count, forKey: "VisitCount")
        // ペナルティーを保存するcount2変数
        let count2 : Int = penaltyDafault.integer(forKey: "VisitCount2")
        penaltyDafault.set(count2, forKey: "VisitCount2")
        
        // グラフの値を保存するrecord1変数
        let record1 : Int = graphDafault.integer(forKey: "record1")
        graphDafault.set(record1, forKey: "record1")
        
        // カメラの設定の初期設定
        let defaults2 = UserDefaults.standard
        if defaults2.bool(forKey: "Cfirst") {
            cameraDafault.set("ぼかし", forKey: "name")
            cameraDafault.synchronize()
        }
        defaults2.set(false, forKey: "Cfirst")
        
        // 月の取得
        let cal: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let calendar = Calendar(identifier: Calendar.Identifier.japanese)
        let now = Date()
        var cal_comp: DateComponents = (cal as NSCalendar).components([.year, .month, .day, .weekday], from:now)
        // 1月
        cal_comp.month = 1
        cal_comp.day = 1
        var next: Date = Calendar.current.date(from: cal_comp)!
        var range2 : NSRange = (calendar as NSCalendar).range(of: .day, in:.month, for:next)
        Jan = range2.length
        // 2月
        cal_comp.month = 2
        next = Calendar.current.date(from: cal_comp)!
        range2 = (calendar as NSCalendar).range(of: .day, in:.month, for:next)
        Feb = range2.length
        // 3月
        cal_comp.month = 3
        next = Calendar.current.date(from: cal_comp)!
        range2 = (calendar as NSCalendar).range(of: .day, in: .month, for: next)
        Mar = range2.length
        // 4月
        cal_comp.month = 4
        next = Calendar.current.date(from: cal_comp)!
        range2 = (calendar as NSCalendar).range(of: .day, in:.month, for:next)
        Apl = range2.length
        // 5月
        cal_comp.month = 5
        next = Calendar.current.date(from: cal_comp)!
        range2 = (calendar as NSCalendar).range(of: .day, in:.month, for:next)
        May = range2.length
        // 6月
        cal_comp.month = 6
        next = Calendar.current.date(from: cal_comp)!
        range2 = (calendar as NSCalendar).range(of: .day, in:.month, for:next)
        Jun = range2.length
        // 7月
        cal_comp.month = 7
        next = Calendar.current.date(from: cal_comp)!
        range2 = (calendar as NSCalendar).range(of: .day, in:.month, for:next)
        Jul = range2.length
        // 8月
        cal_comp.month = 8
        next = Calendar.current.date(from: cal_comp)!
        range2 = (calendar as NSCalendar).range(of: .day, in:.month, for:next)
        Aug = range2.length
        // 9月
        cal_comp.month = 9
        next = Calendar.current.date(from: cal_comp)!
        range2 = (calendar as NSCalendar).range(of: .day, in:.month, for:next)
        Sep = range2.length
        // 10月
        cal_comp.month = 10
        next = Calendar.current.date(from: cal_comp)!
        range2 = (calendar as NSCalendar).range(of: .day, in:.month, for:next)
        Oct = range2.length
        // 11月
        cal_comp.month = 11
        next = Calendar.current.date(from: cal_comp)!
        range2 = (calendar as NSCalendar).range(of: .day, in:.month, for:next)
        Nov = range2.length
        // 12月
        cal_comp.month = 12
        next = Calendar.current.date(from: cal_comp)!
        range2 = (calendar as NSCalendar).range(of: .day, in:.month, for:next)
        Dec = range2.length
        
        let value = ["firstValue": true]
        defaults2.register(defaults: value)
        
        if defaults2.bool(forKey: "firstValue"){
            
            // 一年の値を格納する多次元配列
            var one = 0,Day = 0
            for i in 0..<365 {
                if(one == 0){
                    
                    if(Day <= Jan){
                        yearsGraphArray[0].append(0)
                        Day += 1
                        if(Day == Jan){
                            Day = 0
                            one += 1
                        }
                        
                    }
                    
                }
                
                if(one == 1){
                    
                    if(Day <= Feb){
                        
                        yearsGraphArray[1].append(0)
                        Day += 1
                        if(Day == Feb){
                            Day = 0
                            one += 1
                        }
                        
                    }
                }
                
                if(one == 2){
                    
                    if(Day <= Mar){
                        
                        
                        yearsGraphArray[2].append(0)
                        Day += 1
                        if(Day == Mar){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                if(one == 3){
                    
                    if(Day <= Apl){
                        
                        
                        yearsGraphArray[3].append(0)
                        Day += 1
                        if(Day == Apl){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                if(one == 4){
                    if(Day <= May){
                        
                        
                        yearsGraphArray[4].append(0)
                        Day += 1
                        if(Day == May){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                if(one == 5){
                    if(Day <= Jun){
                        
                        
                        yearsGraphArray[5].append(0)
                        Day += 1
                        if(Day == Jun){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                if(one == 6){
                    if(Day <= Jul){
                        
                        
                        yearsGraphArray[6].append(0)
                        Day += 1
                        if(Day == Jul){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                if(one == 7){
                    if(Day <= Aug){
                        
                        
                        yearsGraphArray[7].append(0)
                        Day += 1
                        if(Day == Aug){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                if(one == 8){
                    if(Day <= Sep){
                        
                        
                        yearsGraphArray[8].append(0)
                        Day += 1
                        if(Day == Sep){
                            one += 1
                            Day = 0
                        }
                    }
                    
                }
                
                if(one == 9){
                    if(Day <= Oct){
                        
                        
                        yearsGraphArray[9].append(0)
                        Day += 1
                        if(Day == Oct){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                if(one == 10){
                    if(Day <= Nov){
                        
                        
                        yearsGraphArray[10].append(0)
                        Day += 1
                        if(Day == Nov){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                if(one == 11){
                    if(Day <= Dec){
                        
                        
                        yearsGraphArray[11].append(0)
                        Day += 1
                        if(Day == Dec){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                
            }
            //yearsGraphArray.removeLast()
            print("first")
            
            //NSUserDefaultsのインスタンスを生成
            let yearGraphValue = UserDefaults.standard
            
            //"VALUE"というキーで配列yearGraphArrayを保存
            yearGraphValue.set(yearsGraphArray, forKey:"VALUE")
            
            // シンクロを入れないとうまく動作しないときがあります
            yearGraphValue.synchronize()
            
            
            defaults2.set(false, forKey: "firstValue")
            
        }
        
        return true
    }
    /*
     アプリがバックグラウンドになる直前に呼ばれる.
     */
    func applicationWillResignActive(_ application: UIApplication) {
        
        self.backgroundTaskID = application.beginBackgroundTask(){
            [weak self] in
            application.endBackgroundTask((self?.backgroundTaskID)!)
            self?.backgroundTaskID = UIBackgroundTaskInvalid
        }
        
    }
    
    /*
     アプリがバックグラウンドになった時に呼ばれる.
     */
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        
        
    }
    
    /*
     アプリがフォアグラウンドになった時に呼ばれる.
     */
    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "applicationWillEnterForeground"), object: nil)
        
    }
    
    /*
     アプリがアクティブになった時に呼ばれる.
     */
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        // データベースの配列を全削除する
        mySwiftData.allDelete()
        
        
    }
    
    /*
     アプリが終了する直前に呼ばれる.
     */
    func applicationWillTerminate(_ application: UIApplication) {
        
        // タスクの終了を知らせる
        application.endBackgroundTask(self.backgroundTaskID)
    }
    
    
    // 通知をタップしたら呼ばれる
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        
    }
    
    
    // テーブルを作成する関数
    func createTable(){
        
        // DatabaseClassのtableに書いてる
        let db = FMDatabase(path: DatabaseClass().table)
        let sql = "CREATE TABLE IF NOT EXISTS sample (user_id INTEGER PRIMARY KEY, name TEXT, description TEXT);"
        db?.open()
        
        // SQL文を実行
        let ret = db?.executeUpdate(sql, withArgumentsIn: nil)
        if ret! {
            print("テーブルの作成に成功")
        } else {
            print("テーブル作成に失敗")
        }
        db?.close()
    }
}


// Stringに機能を追加
extension String {
    var lastPathComponent: String {
        get {
            return (self as NSString).lastPathComponent
        }
    }
    var pathExtension: String {
        get {
            return (self as NSString).pathExtension
        }
    }
    var stringByDeletingLastPathComponent: String {
        get {
            return (self as NSString).deletingLastPathComponent
        }
    }
    var stringByDeletingPathExtension: String {
        get {
            return (self as NSString).deletingPathExtension
        }
    }
    var pathComponents: [String] {
        get {
            return (self as NSString).pathComponents
        }
    }
    func stringByAppendingPathComponent(path: String) -> String {
        return (self as NSString).appendingPathComponent(path)
    }
    func stringByAppendingPathExtension(ext: String) -> String? {
        return (self as NSString).appendingPathExtension(ext)
    }
}


