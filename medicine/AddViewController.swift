//
//  Add View Controller.swift
//  test6
//
//  Created by 小西夏穂 on 2016/06/25.
//  Copyright © 2016年 小西夏穂. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet var TextField: UITextField!
    
    @IBOutlet weak var myDPvar: UIDatePicker!
    
    private var tempTime: String = "00:00"
    private var setTime: String = "00:00"
    
    
    var wordArray: [AnyObject] = []
    let saveData = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if saveData.arrayForKey("WORD") != nil {
            wordArray = saveData.arrayForKey("WORD")!
            print(wordArray)
        }
        
        _ = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: #selector(AddViewController.update), userInfo: nil, repeats: true)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveWord()
    }
    
    
    @IBAction func saveWord() {
        
        let medicineName = TextField.text!
        let dateString = String(myDPvar.date)
        
        let medicineInfoDictionary = ["name": medicineName, "date": dateString]
        
        wordArray.append(medicineInfoDictionary)
        
        saveData.setObject(wordArray, forKey: "WORD")
        saveData.synchronize()
        
        let alert = UIAlertController(
            title: "保存完了",
            message: "単語の登録が完了しました",
            preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.Default,
                handler:nil
            )
        )
        
        
        self.presentViewController(alert, animated: true, completion: nil)
        TextField.text = ""
        
    }
    
    @IBAction func tapview(sender: AnyObject) {
        
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func myDPfunc(sender: AnyObject) {
        // test print
        print("test: myDP moved!")
        // DPの値を成形
        let format = NSDateFormatter()
        format.dateFormat = "HH:mm"
        // 一時的にDPの値を保持
        tempTime = format.stringFromDate(myDPvar.date)
    }
    
    @IBAction func myButtonfunc(sender: AnyObject) {
        // アラームをセット
        setTime = tempTime
        // test print
        print("test: myButton Pushed!")
    }
    
    func getNowTime()-> String {
        // 現在時刻を取得
        let nowTime: NSDate = NSDate()
        // 成形する
        let format = NSDateFormatter()
        format.dateFormat = "HH:mm"
        let nowTimeStr = format.stringFromDate(nowTime)
        // 成形した時刻を文字列として返す
        return nowTimeStr
    }
    
    func update() {
        // 現在時刻を取得
        let str = getNowTime()
        // アラーム鳴らすか判断
        myAlarm(str)
    }
    
    func myAlarm(str: String) {
        // 現在時刻が設定時刻と一緒なら
        if str == setTime{
            alert()
        }
    }
    
    // アラートの表示
    func alert() {
        let myAlert = UIAlertController(title: "alert", message: "ring ring", preferredStyle: .Alert)
        let myAction = UIAlertAction(title: "stop", style: .Default) {
            action in print("foo!!")
        }
        myAlert.addAction(myAction)
        presentViewController(myAlert, animated: true, completion: nil)
    }
}

