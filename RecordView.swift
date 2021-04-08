//
//  ViewController.swift
//  STOP!歩きスマホ
//
//  Created by 清水直輝 on 2016/06/25.
//  Copyright © 2016年 清水直輝. All rights reserved.
//

import UIKit
import Spring
import Charts

class RecordView: UIViewController, UIAlertViewDelegate, UIScrollViewDelegate {
    
    // SwiftDataクラス（DB）を使う時の変数の宣言
    var mySwiftData = DBFile()
    
    // データを保存する配列
    var DBArray = NSMutableArray()
    var DBGraphArray: [[Double]] = [[],[],[],[],[],[],[],[],[],[],[],[]]
    
    var pageControl: UIPageControl!
    var scrollView: UIScrollView!
    
    // storyboardから接続
    @IBOutlet weak var barChartView: BarChartView!
    var i = 0
    var nowPage : Int = 0
    var t : Double = 0.0
    var today : Int!
    var lastDay : Int!
    
    // 月の日数を格納する配列
    var months: [String] = [""]
    
    // 日ごとに値を格納する配列
    var unitsSold: [Double] = []
    
    // 値を更新するタイマー
    var timer: Timer!
    
    // 現在の月を記録する整数型
    var nowMonth: Int!
    
    // グラフのタイトルを表示するラベル
    var titleLabel: UILabel!
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
    
    // 月の値を保存するuserdefaults変数
    let myUserDafault : UserDefaults = UserDefaults()
    let defaults = UserDefaults.standard
    
    var wButton: UIButton!
    var dButton: UIButton!
    var adButton: UIButton!
    var idButton: SpringButton!
    
    var deback: Double = 0
    var deback2: Double = 0
    var deback3: Double = 0
    
    var updateToday: Int!
    var updateYear: Int!
    
    override func viewDidAppear(_ animated: Bool) {
        
        dbAddButton()
        // データをMutableArray型で取得 or データの更新で使える
        DBArray = mySwiftData.getAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 月の取得
        let calendar = Calendar(identifier: Calendar.Identifier.japanese)
        let now = Date()
        
        let month1:Int = myUserDafault.integer(forKey: "record")
        myUserDafault.set(month1, forKey: "record")
        
        // 今月の月
        let month: DateComponents = (calendar as NSCalendar).components(NSCalendar.Unit.month, from: now)
        nowMonth = month.month
        
        // 今日の日付
        let now1 = Date()
        let calendar1 = Calendar(identifier: Calendar.Identifier.japanese)
        let day: DateComponents = (calendar1 as NSCalendar).components(NSCalendar.Unit.day, from: now1)
        today = day.day
        
        // 指定月は何日あるか
        let range : NSRange = (calendar as NSCalendar).range(of: .day, in:.month, for:now)
        let last = range.length
        lastDay = last
        
        
        titleLabel = UILabel(frame: CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.width / 10))
        titleLabel.text = "\(nowMonth)月の歩きスマホの回数"
        titleLabel.layer.position = CGPoint(x: self.view.bounds.width / 2,y: self.view.bounds.height / 30)
        titleLabel.font = UIFont.systemFont(ofSize: self.view.bounds.width / 18.75)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.black
        self.view.addSubview(titleLabel)
        
        let myLabel: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width / 10,height: self.view.bounds.height / 22.233))
        myLabel.layer.masksToBounds = true
        myLabel.layer.cornerRadius = 20.0
        myLabel.text = "(回数)"
        myLabel.font = UIFont.systemFont(ofSize: self.view.bounds.height / 49)
        myLabel.textColor = UIColor.black
        myLabel.textAlignment = NSTextAlignment.center
        myLabel.layer.position = CGPoint(x: self.view.bounds.width / 24,y: self.view.bounds.height / 13.34)
        self.view.addSubview(myLabel)
        
        var y : Double = 0
        
        updateToday = myUserDafault.integer(forKey: "update")
        
        if(updateToday == nil){
            
            updateToday = day.day
            print("updateToday = nil")
        }
        // 月が新しくなったら初期化する
        if(updateToday != day.day){
            if(day.day == 1){
                
                months = [""]
                unitsSold = []
                print("初期化！")
            }
        }
        updateToday = day.day
        myUserDafault.set(updateToday, forKey: "update")
        
        // 初回起動時の処理
        //let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.bool(forKey: "first") {
            
            // 今月の値を初期化して表示
            y = 0
            // 日を格納するmonthsと値を格納するunitsSoldを初期化
            months = [""]
            unitsSold = []
            //for(var i = 1; i <= lastDay; i += 1){
            for i in 1..<lastDay {
                
                months.append("\(i)日")
                unitsSold.append(y)
            }
            // 先頭要素を削除する。これがないと強制終了します。
            months.remove(at: 0)
            
            // 一年の値を格納する多次元配列
            var one = 0,Day = 0
            //for i in 0..< 365 {
            for i in 0..<365 {
                if(one == 0){
                    
                    if(Day <= appDelegate.Jan){
                        DBGraphArray[0].append(0)
                        Day += 1
                        if(Day == appDelegate.Jan){
                            Day = 0
                            one += 1
                        }
                        
                    }
                    
                }
                
                if(one == 1){
                    
                    if(Day <= appDelegate.Feb){
                        
                        DBGraphArray[1].append(0)
                        Day += 1
                        if(Day == appDelegate.Feb){
                            Day = 0
                            one += 1
                        }
                        
                    }
                }
                
                if(one == 2){
                    
                    if(Day <= appDelegate.Mar){
                        
                        DBGraphArray[2].append(0)
                        Day += 1
                        if(Day == appDelegate.Mar){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                if(one == 3){
                    
                    if(Day <= appDelegate.Apl){
                        
                        DBGraphArray[3].append(0)
                        Day += 1
                        if(Day == appDelegate.Apl){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                if(one == 4){
                    if(Day <= appDelegate.May){
                        
                        
                        DBGraphArray[4].append(0)
                        Day += 1
                        if(Day == appDelegate.May){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                if(one == 5){
                    if(Day <= appDelegate.Jun){
                        
                        
                        DBGraphArray[5].append(0)
                        Day += 1
                        if(Day == appDelegate.Jun){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                if(one == 6){
                    if(Day <= appDelegate.Jul){
                        
                        
                        DBGraphArray[6].append(0)
                        Day += 1
                        if(Day == appDelegate.Jul){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                if(one == 7){
                    if(Day <= appDelegate.Aug){
                        
                        
                        DBGraphArray[7].append(0)
                        Day += 1
                        if(Day == appDelegate.Aug){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                if(one == 8){
                    if(Day <= appDelegate.Sep){
                        
                        
                        DBGraphArray[8].append(0)
                        Day += 1
                        if(Day == appDelegate.Sep){
                            one += 1
                            Day = 0
                        }
                    }
                    
                }
                
                if(one == 9){
                    if(Day <= appDelegate.Oct){
                        
                        
                        DBGraphArray[9].append(0)
                        Day += 1
                        if(Day == appDelegate.Oct){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                if(one == 10){
                    if(Day <= appDelegate.Nov){
                        
                        
                        DBGraphArray[10].append(0)
                        Day += 1
                        if(Day == appDelegate.Nov){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
                if(one == 11){
                    if(Day <= appDelegate.Dec){
                        
                        
                        DBGraphArray[11].append(0)
                        Day += 1
                        if(Day == appDelegate.Dec){
                            one += 1
                            Day = 0
                        }
                    }
                }
                
            }
            
            DBGraphArray.removeLast()
            
        }
            
            // 初回以降の処理
        else {
            
            // monthsとunitsSoldに月の日数分の値を格納
            
            var u = 0, y = 0
            
            //空の配列を用意
            var value: [[Double]] = []
            
            //前回の保存内容があるかどうかを判定
            if((defaults.object(forKey: "VALUE")) != nil){
                
                //objectsを配列として確定させ、前回の保存内容を格納
                let objects = defaults.object(forKey: "VALUE") as? [[Double]]
                
                //前回の保存内容が格納された配列の中身を一つずつ取り出す
                for valueArray in objects!{
                    //配列に追加していく
                    value.append(valueArray)
                    
                }
                
            }
            
            for i in 0..<last {
                
                months.append("\(i+1)日")
                unitsSold.append(value[nowMonth - 1][i])
                
                u += 1
                y += 1
                
            }
            
            months.remove(at: 0)
            
        }
        defaults.set(false, forKey: "first")
        
        
        // アニメーションの時間を設定
        barChartView.animate(yAxisDuration: 2.0)
        
        // ピンチズームを不可能にする
        barChartView.pinchZoomEnabled = false
        
        // ダブルタップズームを不可能にする
        barChartView.doubleTapToZoomEnabled = false
        
        // trueに設定されている場合、灰色の領域は最大値を示し、各バーの後ろに描かれています
        barChartView.drawBarShadowEnabled = false
        
        // 境界線の表示
        barChartView.drawBordersEnabled = true
        
        // 配置する座標を設定する.
        barChartView.layer.position = CGPoint(x: self.view.bounds.width/2,y: 200)
        
        // 説明文の内容
        barChartView.descriptionText = ""
        
        // タップされなくする
        barChartView.highlightPerTapEnabled = false
        
        // monthsの値をグラフの下に表示
        barChartView.xAxis.labelPosition = .bottom
        
        // グラフの余白
        barChartView.extraTopOffset = self.view.bounds.height / 11
        barChartView.extraRightOffset = self.view.bounds.width / 18
        barChartView.extraBottomOffset = self.view.bounds.height / 11
        barChartView.extraLeftOffset = self.view.bounds.width / 18
        
        setChart(months, values: unitsSold)
        
        // タイマー
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(RecordView.onTimer(_:)), userInfo: nil, repeats: true)
        
        
        
        /************************************* ページ **************************************/
        // ビューの縦、横のサイズを取得する.
        let width = self.view.frame.maxX
        
        // ScrollViewを取得する
        scrollView = UIScrollView(frame: self.view.frame)
        
        // ページ数を12と定義する変数
        let pageSize = 12
        
        // 縦方向と、横方向のインディケータを非表示にする
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        // ページングを許可する
        scrollView.isPagingEnabled = true
        
        // ScrollViewのデリゲートを設定する
        scrollView.delegate = self
        
        // スクロールの画面サイズを指定する
        scrollView.contentSize = CGSize(width: CGFloat(pageSize) * width, height: 0)
        
        self.barChartView.addSubview(scrollView)
        
        
        // PageControlを作成する.
        pageControl = UIPageControl(frame: CGRect(x: 0, y: self.view.frame.height / 1.14, width: width, height: 50))
        //pageControl.backgroundColor = UIColor.orangeColor()
        
        // ページ数をpageSize(12)に設定する
        pageControl.numberOfPages = pageSize
        
        // PageControlの色を変える
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.pageIndicatorTintColor = UIColor.brown
        
        // 初期ページを今月にする
        pageControl.currentPage = nowMonth - 1
        nowPage = nowMonth - 1
        
        // scrollViewもページ移動する
        scrollView.contentOffset = CGPoint(x: width * CGFloat(pageControl.currentPage), y: 0)
        pageControl.isUserInteractionEnabled = false
        
        self.barChartView.addSubview(pageControl)
        
        
    }
    
    // グラフに今日のところに値を更新するタイマー関数
    func onTimer(_ timer: Timer){
        
        let now = Date()
        let calendar = Calendar(identifier: Calendar.Identifier.japanese)
        let day: DateComponents = (calendar as NSCalendar).components(NSCalendar.Unit.day, from: now)
        
        updateYear = myUserDafault.integer(forKey: "update2")
        
        if(updateYear == nil){
            
            updateYear = day.day
        }
        
        // 年が新しくなったら初期化する
        if(updateYear != day.day){
            if(nowMonth == 1 && today == 1){
                
                // 一年分のデータを削除
                delete_graph()
            }
        }
        updateYear = day.day
        myUserDafault.set(updateYear, forKey: "update2")
        // グラフの値を更新
        setChart(months, values: unitsSold)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // dataPointsにmonthの値を、valuesにunitsSoldの値を挿入
    func setChart(_ dataPoints: [String], values: [Double]) {
        
        // データがない時に表示するテキスト
        barChartView.noDataText = "データがありません"
        
        // BarChartDataEntry型の配列を宣言
        var dataEntries: [BarChartDataEntry] = []
        
        // dataPointsの文字列の長さまでループする
        for i in 0..<dataPoints.count {
            
            // 1月から12月の雨量のデータを求める
            //let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            
            // dataEntries配列の末尾にdataEntry要素を追加する
            dataEntries.append(dataEntry)
        }
        
        //
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "歩数")
        // グラフの色を変える
        chartDataSet.colors = [UIColor(red: 80, green: 0, blue: 200, alpha: 1)]
        
        //
        //let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // スクロール数が1ページ分になったら時.
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            
            // ページの場所を切り替える(contentOffset.xは横のscrollViewの長さ、frame.maxXは端末の横の長さ)
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
            nowPage = pageControl.currentPage
            titleLabel.text = "\(nowPage + 1)月の歩きスマホの回数"
            
            months = [""]
            unitsSold = []
            
            //空の配列を用意
            var value: [[Double]] = []
            
            //前回の保存内容があるかどうかを判定
            if((defaults.object(forKey: "VALUE")) != nil){
                
                //objectsを配列として確定させ、前回の保存内容を格納
                let objects = defaults.object(forKey: "VALUE") as? [[Double]]
                
                //前回の保存内容が格納された配列の中身を一つずつ取り出す
                for valueArray in objects!{
                    //配列に追加していく
                    value.append(valueArray )
                    
                }
                
            }
            
            // 1月なら
            if(nowPage == 0){
                
                //for(i = 0; i < appDelegate.Jan; i += 1){
                
                for i in 0..<appDelegate.Jan {
                    months.append("\(i+1)日")
                    unitsSold.append(value[0][i])
                }
                months.remove(at: 0)
                setChart(months, values: unitsSold)
            }
            
            // 2月なら
            if(nowPage == 1){
                
                //for(i = 0; i < appDelegate.Feb; i += 1){
                for i in 0..<appDelegate.Feb {
                    months.append("\(i+1)日")
                    unitsSold.append(value[1][i])
                }
                months.remove(at: 0)
                setChart(months, values: unitsSold)
            }// 3月なら
            if(nowPage == 2){
                
                //for(i = 0; i < appDelegate.Mar; i += 1){
                for i in 0..<appDelegate.Mar {
                    months.append("\(i+1)日")
                    unitsSold.append(value[2][i])
                }
                months.remove(at: 0)
                setChart(months, values: unitsSold)
            }// 4月なら
            if(nowPage == 3){
                
                //for(i = 0; i < appDelegate.Apl; i += 1){
                for i in 0..<appDelegate.Apl {
                    months.append("\(i+1)日")
                    unitsSold.append(value[3][i])
                }
                months.remove(at: 0)
                setChart(months, values: unitsSold)
            }// 5月なら
            if(nowPage == 4){
                
                //for(i = 0; i < appDelegate.May; i += 1){
                for i in 0..<appDelegate.May {
                    months.append("\(i+1)日")
                    unitsSold.append(value[4][i])
                }
                months.remove(at: 0)
                setChart(months, values: unitsSold)
            }
            // 6月なら
            if(nowPage == 5){
                
                //for(i = 0; i < appDelegate.Jun; i += 1){
                for i in 0..<appDelegate.Jun {
                    months.append("\(i+1)日")
                    unitsSold.append(value[5][i])
                }
                months.remove(at: 0)
                setChart(months, values: unitsSold)
            }
            // 7月なら
            if(nowPage == 6){
                
                //for(i = 0; i < appDelegate.Jul; i += 1){
                for i in 0..<appDelegate.Jul {
                    months.append("\(i+1)日")
                    unitsSold.append(value[6][i])
                }
                months.remove(at: 0)
                setChart(months, values: unitsSold)
            }// 8月なら
            if(nowPage == 7){
                
                //for(i = 0; i < appDelegate.Aug; i += 1){
                for i in 0..<appDelegate.Aug {
                    months.append("\(i+1)日")
                    unitsSold.append(value[7][i])
                }
                months.remove(at: 0)
                setChart(months, values: unitsSold)
            }// 9月なら
            if(nowPage == 8){
                
                //for(i = 0; i < appDelegate.Sep; i += 1){
                for i in 0..<appDelegate.Sep {
                    months.append("\(i+1)日")
                    unitsSold.append(value[8][i])
                }
                months.remove(at: 0)
                setChart(months, values: unitsSold)
            }// 10月なら
            if(nowPage == 9){
                
                //for(i = 0; i < appDelegate.Oct; i += 1){
                for i in 0..<appDelegate.Oct {
                    months.append("\(i+1)日")
                    unitsSold.append(value[9][i])
                }
                months.remove(at: 0)
                setChart(months, values: unitsSold)
            }// 11月なら
            if(nowPage == 10){
                
                //for(i = 0; i < appDelegate.Nov; i += 1){
                for i in 0..<appDelegate.Nov {
                    months.append("\(i+1)日")
                    unitsSold.append(value[10][i])
                }
                months.remove(at: 0)
                setChart(months, values: unitsSold)
            }// 12月なら
            if(nowPage == 11){
                
                //for(i = 0; i < appDelegate.Dec; i += 1){
                for i in 0..<appDelegate.Dec {
                    months.append("\(i+1)日")
                    unitsSold.append(value[11][i])
                }
                months.remove(at: 0)
                setChart(months, values: unitsSold)
            }
            
            
            
            
        }
    }
    
    // グラフの値を初期化する
    func delete_graph(){
        
        var one = 0,Day = 0
        //for(var i = 0; i < 365; i += 1){
        for i in 0..<365 {
            if(one == 0){
                
                if(Day <= appDelegate.Jan){
                    appDelegate.yearsGraphArray[0].append(0)
                    Day += 1
                    if(Day == appDelegate.Jan){
                        Day = 0
                        one += 1
                    }
                    
                }
                
            }
            
            if(one == 1){
                
                if(Day <= appDelegate.Feb){
                    
                    appDelegate.yearsGraphArray[1].append(0)
                    Day += 1
                    if(Day == appDelegate.Feb){
                        Day = 0
                        one += 1
                    }
                    
                }
            }
            
            if(one == 2){
                
                if(Day <= appDelegate.Mar){
                    
                    
                    appDelegate.yearsGraphArray[2].append(0)
                    Day += 1
                    if(Day == appDelegate.Mar){
                        one += 1
                        Day = 0
                    }
                }
            }
            
            if(one == 3){
                
                if(Day <= appDelegate.Apl){
                    
                    
                    appDelegate.yearsGraphArray[3].append(0)
                    Day += 1
                    if(Day == appDelegate.Apl){
                        one += 1
                        Day = 0
                    }
                }
            }
            
            if(one == 4){
                if(Day <= appDelegate.May){
                    
                    
                    appDelegate.yearsGraphArray[4].append(0)
                    Day += 1
                    if(Day == appDelegate.May){
                        one += 1
                        Day = 0
                    }
                }
            }
            
            if(one == 5){
                if(Day <= appDelegate.Jun){
                    
                    
                    appDelegate.yearsGraphArray[5].append(0)
                    Day += 1
                    if(Day == appDelegate.Jun){
                        one += 1
                        Day = 0
                    }
                }
            }
            
            if(one == 6){
                if(Day <= appDelegate.Jul){
                    
                    
                    appDelegate.yearsGraphArray[6].append(0)
                    Day += 1
                    if(Day == appDelegate.Jul){
                        one += 1
                        Day = 0
                    }
                }
            }
            
            if(one == 7){
                if(Day <= appDelegate.Aug){
                    
                    
                    appDelegate.yearsGraphArray[7].append(0)
                    Day += 1
                    if(Day == appDelegate.Aug){
                        one += 1
                        Day = 0
                    }
                }
            }
            
            if(one == 8){
                if(Day <= appDelegate.Sep){
                    
                    
                    appDelegate.yearsGraphArray[8].append(0)
                    Day += 1
                    if(Day == appDelegate.Sep){
                        one += 1
                        Day = 0
                    }
                }
                
            }
            
            if(one == 9){
                if(Day <= appDelegate.Oct){
                    
                    
                    appDelegate.yearsGraphArray[9].append(0)
                    Day += 1
                    if(Day == appDelegate.Oct){
                        one += 1
                        Day = 0
                    }
                }
            }
            
            if(one == 10){
                if(Day <= appDelegate.Nov){
                    
                    
                    appDelegate.yearsGraphArray[10].append(0)
                    Day += 1
                    if(Day == appDelegate.Nov){
                        one += 1
                        Day = 0
                    }
                }
            }
            
            if(one == 11){
                if(Day <= appDelegate.Dec){
                    
                    
                    appDelegate.yearsGraphArray[11].append(0)
                    Day += 1
                    if(Day == appDelegate.Dec){
                        one += 1
                        Day = 0
                    }
                }
            }
            
            
        }
        
    }
    
    /**
     データの追加
     一回押すとデータの追加が実行される
     
     追加内容は指定した文字列と現在時間（どちらもString型）
     SwfitDataの内容を変更すればどんな型も追加できる
     */
    func dbAddButton() {
        
        deback3 = myUserDafault.double(forKey: "numberoftimes")
        
        // データの追加 【新規IDに 数を格納】
        mySwiftData.add(String(deback3))
        
        // データの更新(一月分の値を保存！)
        DBArray = mySwiftData.getAll()
        
        unitsSold[today - 1] = deback3
        
        // データの内容をデバックエリアに表示
    }
    
    func dbAllDelete() {
        
        // データの更新
        DBArray = mySwiftData.getAll()
        // データベースの中身が空っぽの場合ifの分岐で何もしない動作にしないとエラーになる
        if DBArray.lastObject == nil {
            // 何もしない
        } else {
            // データベースの配列を全削除する
            mySwiftData.allDelete()
        }
        
        // データの更新
        DBArray = mySwiftData.getAll()
        
        
    }
    
    func dbIDDelete() {
        
        DBArray = mySwiftData.getAll()
        mySwiftData.allDelete()
    }
    
    /**
     DBの更新
     */
    func dbUpdataButton() {
        // データをMutableArray型で取得 or データの更新で使える
        DBArray = mySwiftData.getAll()
        // データの内容をデバックエリアに表示
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dbAllDelete()
    }
    
}
