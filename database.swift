//
//  database.swift
//  歩きスマホ
//
//  Created by 清水直輝 on 2017/05/12.
//  Copyright © 2017年 清水直輝. All rights reserved.
//


import Foundation

class DatabaseClass {
    var table : String {
        
        get{
            let paths = NSSearchPathForDirectoriesInDomains(
                .documentDirectory,
                .userDomainMask, true)
            let path = paths[0].stringByAppendingPathComponent(path: "sample.db")
            return path
        }
        
    }
    
    // 通常のメッセージを保存するデータベース
    var table2 : String {
        
        get{
            let paths = NSSearchPathForDirectoriesInDomains(
                .documentDirectory,
                .userDomainMask, true)
            let path = paths[0].stringByAppendingPathComponent(path: "sample2.db")
            return path
        }
    }
    
    // 重要なメッセージを保存するデータベース
    var table3 : String {
        
        get{
            let paths = NSSearchPathForDirectoriesInDomains(
                .documentDirectory,
                .userDomainMask, true)
            let path = paths[0].stringByAppendingPathComponent(path: "sample3.db")
            return path
        }
    }
    
}



import UIKit

class DBFile {

    /**
     INSERT文（追加する）[INSERTは、データを追加したい時に使う]
     var add = 自作databaseクラス.add("3urprise") これでdatabaseに"3urprise"と追加される
     */
    func add(_ str:String) {
        
        /*
        var result:String? = nil
        // INSERT = 追加, INTO = DATE型の値を入れる, graph_table = 利用するテーブル, VALUES (?) = 格納する値
        if SD.executeChange("INSERT INTO graph_table (data) VALUES (?);", withArgs: [str as AnyObject]) != nil {
            // 挿入中にエラーが発生したら、ここで扱う
            
        }
            
        else {
            // エラーがなく、行が正常に挿入されました
            // lastInsertedRowID = 直近の INSERT 文でデータベースに追加された行の ID を返す
            let (id, err) = SD.lastInsertedRowID()
            if err != nil {
                // err
                
            }else{
                result = String(id)
                
            }
        }
        */
        
        let db = FMDatabase(path: DatabaseClass().table)
        let sql = "INSERT INTO sample (name) VALUES (?);"
        
        db?.open()
        
        // ?で記述したパラメータの値を渡す場合
        db?.executeUpdate(sql, withArgumentsIn: [str])
        // print("データベース　＝　\(db!)")
        db?.close()
        
        
        //return result!
    }
    
    
    // データをすべて削除するメソッド
    func allDelete() -> Bool {
        //SD.executeChange("DELETE FROM graph_table;")
        let db = FMDatabase(path: DatabaseClass().table)
        
        //let sql = "DELETE FROM sample WHERE user_id = ?;"
        
        // 全削除
        let sql = "DELETE FROM sample;"
        db?.open()
        if(sql != nil){
            
            db?.executeUpdate(sql, withArgumentsIn: nil)
        }
        
        db?.close()
        return true
    }
    
    /**
     SELECT文(データを更新するのに使う)[SELECTは、更新されたデータを検索したり、更新結果を確認するのに使います。]
     var selects = 自作databaseクラス.getAll() これでNSMutableArray型の内容が取得出来る
     */
    func getAll() -> NSMutableArray {
        
        let result = NSMutableArray()
        let db = FMDatabase(path: DatabaseClass().table)
        
        var id : Int = 0
        
        //let sql = "SELECT * FROM sample"
        let sql = "SELECT * FROM sample WHERE user_id == \(id)"
        // let sql = "SELECT user_name FROM sample ORDER BY user_id;"
        db?.open()
        
        let results = db?.executeQuery(sql, withArgumentsIn: nil)
        
        while (results?.next())! {
            
            id += 1
            
            // カラム名を指定して値を取得する方法
            let user_id = results?.int(forColumn: "user_id")
            
            // カラムのインデックスを指定して取得する方法
            let user_name = results?.string(forColumnIndex: 1)
            
            print("user_id = \(user_id!), user_name = \(user_name!)")
            
            
            let id = user_id!
            let dataStr = user_name!
            
            // 月の取得
            let calendar = Calendar(identifier: Calendar.Identifier.japanese)
            let now = Date()
            
            // 今月の月
            let month: DateComponents = (calendar as NSCalendar).components(NSCalendar.Unit.month, from:now)
            
            // 今日の日付
            let day: DateComponents = (calendar as NSCalendar).components(NSCalendar.Unit.day, from:now)
            
            
            //空のDouble型二次元配列を用意
            var value: [[Double]] = []
            
            let defaults = UserDefaults.standard
            
            if((defaults.object(forKey: "VALUE")) != nil){
                
                // objectsに、前回の保存内容を格納
                let objects = defaults.object(forKey: "VALUE") as? [[Double]]
                
                // 前回の保存内容が格納された配列の中身を一つずつ取り出す
                for valueArray in objects!{
                    // value変数に保存した内容を格納する
                    value.append(valueArray)
                    
                }
                
            }
            
            
            // value配列に更新されたデータを追加する
            value[month.month! - 1][day.day! - 1] = Double(dataStr)!
            
            let yearGraphValue = UserDefaults.standard
            
            //"VALUE"というキーで配列valueを保存
            yearGraphValue.set(value, forKey:"VALUE")
            
            // シンクロを入れないとうまく動作しないときがあります
            yearGraphValue.synchronize()
            
            //appDelegate.graphIDArray[month.month - 1]
            
            let dic = ["ID":id, "data":dataStr] as [String : Any]
            result.add(dic)
        }
        return result
    
        
        
        
        
        db?.close()
        
        
        /*
        
        let result = NSMutableArray()
        // 新しい番号から取得する場合は "SELECT * FROM graph_table ORDER BY ID DESC" を使う
        let (resultSet, err) = SD.executeQuery("SELECT * FROM graph_table")
        if err != nil {
            
        } else {
            for row in resultSet {
                if let id = row["ID"]?.asInt() {
                    let dataStr = row["data"]?.asString()!
                    
                    // 月の取得
                    let calendar = Calendar(identifier: Calendar.Identifier.japanese)
                    let now = Date()
                    
                    // 今月の月
                    let month: DateComponents = (calendar as NSCalendar).components(NSCalendar.Unit.month, from: now)
                    
                    // 今日の日付
                    let day: DateComponents = (calendar as NSCalendar).components(NSCalendar.Unit.day, from: now)
                    
                    // 今月の今日に値を格納する
                    
                    // オートインクリメントをリセット「テーブルのデータをすべて削除しないと」
                    SD.executeChange("DELETE FROM sqlite_sequence WHERE name = ?", withArgs: [dataStr! as AnyObject])
                    
                    
                    //空のDouble型二次元配列を用意
                    var value: [[Double]] = []
                    
                    let defaults = UserDefaults.standard
                    
                    if((defaults.object(forKey: "VALUE")) != nil){
                        
                        // objectsに、前回の保存内容を格納
                        let objects = defaults.object(forKey: "VALUE") as? [[Double]]
                        
                        // 前回の保存内容が格納された配列の中身を一つずつ取り出す
                        for valueArray in objects!{
                            // value変数に保存した内容を格納する
                            value.append(valueArray)
                            
                        }
                        
                    }
                    
                    
                    // value配列に更新されたデータを追加する
                    value[month.month! - 1][day.day! - 1] = Double(dataStr!)!
                    
                    let yearGraphValue = UserDefaults.standard
                    
                    //"VALUE"というキーで配列valueを保存
                    yearGraphValue.set(value, forKey:"VALUE")
                    
                    // シンクロを入れないとうまく動作しないときがあります
                    yearGraphValue.synchronize()
                    
                    //appDelegate.graphIDArray[month.month - 1]
                    
                    let dic = ["ID":id, "data":dataStr!] as [String : Any]
                    result.add(dic)
                }
            }
        }
        return result
 */
    }
}




 

 

 
