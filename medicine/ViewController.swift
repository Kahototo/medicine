//
//  ViewController.swift
//  test6
//
//  Created by 小西夏穂 on 2016/06/20.
//  Copyright © 2016年 小西夏穂. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Tableで使用する配列を設定する
    private let myItems: NSArray = ["1","2","3","4","5","6"]
    @IBOutlet private var myTableView: UITableView!
    
    let saveData = NSUserDefaults.standardUserDefaults()
    var wordArray: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // DataSourceの設定をする.
        myTableView.dataSource = self
        
        // Delegateを設定する.
        myTableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if saveData.arrayForKey("WORD") != nil {
            wordArray = saveData.arrayForKey("WORD")!
            print(wordArray)
        }
        self.myTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
     Cellが選択された際に呼び出されるデリゲートメソッド.
     */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myItems[indexPath.row])")
        
    }
    
    /*
     Cellの総数を返すデータソースメソッド.
     (実装必須)
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordArray.count
    }
    
    /*
     Cellに値を設定するデータソースメソッド.
     (実装必須)
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        cell.nameLabel.text = wordArray[indexPath.row]["name"] as? String
        /*
         cell.desiLable.text = wordArray[indexPath.row]["date"] as? String
         */
        
        
        // Cellに値を設定する.
        
        
        return cell
    }
}
