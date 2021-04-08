//
//  DBFile.swift
//  STOP!!歩きスマホ!
//
//  Created by 清水直輝 on 2016/08/07.
//  Copyright © 2016年 清水直輝. All rights reserved.
//


import Foundation
import UIKit

class DBFile {
    
    // テーブル作成
    init() {
        let (tb, err) = SD.existingTables()
        
        
        /**
         graph_tableを変更して使う
         graph_tableの部分をプロジェクト名graph_table
         ：%s/置換前文字列/置換後文字列/gc
         */
        // もしもgraph_tableというテーブルが作成されていなければ
        if !tb.contains( "graph_table") {
            
            // graph_tableを作成,その際"id"は自動生成 dataはStringVal = string型
            if SD.createTable("graph_table", withColumnNamesAndTypes: ["data":.stringVal]) != nil {
                
            }else{
                // 正常に作成
            }
        }
    }
    
    /**
     INSERT文（追加する）[INSERTは、データを追加したい時に使う]
     var add = 自作databaseクラス.add("3urprise") これでdatabaseに"3urprise"と追加される
     */
    func add(_ str:String) -> String {
        
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
        
        
        return result!
    }
    
    
    /**
     DELETE文(データを削除する)[DELETEは、データを削除する時に使う]
     var del = 自作databaseクラス.delete(Int) これでテーブルのID削除
     */
    func delete(_ id:Int) -> Bool {
        
        if SD.executeChange("DELETE FROM graph_table WHERE ID = ?", withArgs: [id as AnyObject]) != nil {
            // there was an error during the insert, handle it here
            
            return false
        } else {
            // no error, the row was inserted successfully
            return true
        }
    }
    
    // データをすべて削除するメソッド
    func allDelete() -> Bool {
        SD.executeChange("DELETE FROM graph_table;")
        return true
    }
    
    // IDを初期化するメソッド
    func idDelete(){
        // IDを初期化している「※テーブルのデータをすべて削除しないと意味ない！」
        SD.executeChange("delete from sqlite_sequence where name = 'graph_table'")
        
    }
    
    /**
     SELECT文(データを更新するのに使う)[SELECTは、更新されたデータを検索したり、更新結果を確認するのに使います。]
     var selects = 自作databaseクラス.getAll() これでNSMutableArray型の内容が取得出来る
     */
    func getAll() -> NSMutableArray {
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
    }
}

