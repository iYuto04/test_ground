//
//  ViewController.swift
//  testground
//
//  Created by Yuto Mizutani on 2016/10/14.
//  Copyright © 2016年 Yuto Mizutani. All rights reserved.
//

import UIKit

class listViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
//    var items: [NSString] = []
    var items = ["aa","bb","cc"]
    var myTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "onClick")
        self.navigationItem.rightBarButtonItem = addBtn
        
        //navigationBarに表示するタイトル
        self.title = "items"

        //ナビゲーションバーの右側に編集ボタンを追加
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        //barの高さってどうやって変えられるのだろう？
//        let barhHeight:CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
//        print(barhHeight)
        
        //displayのサイズを読み取ってtableViewを生成
        let displayWidth :CGFloat = self.view.bounds.width
        let displayHeight:CGFloat = self.view.bounds.height
//        let list: UITableView = UITableView(frame: CGRectMake(0, 0, displayWidth, displayHeight))
        myTableView = UITableView(frame: CGRectMake(0, 0, displayWidth, displayHeight))
        
        //tableViewのセルとプロトコルの設定
//        list.registerClass(UITableViewCell.self, forCellReuseIdentifier: "data")
//        list.dataSource = self
//        list.delegate = self
        
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "data")
        myTableView.dataSource = self
        myTableView.delegate = self
        
        //罫線の色を赤に
//        myTableView.separatorColor = UIColor.redColor()
        
        myTableView.allowsMultipleSelectionDuringEditing = true
        
        
        self.view.backgroundColor = UIColor.redColor()
//        self.view.addSubview(list)
        self.view.addSubview(myTableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //セルが選択された際に呼び出される.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(items[indexPath.row])")
        print("canEddit: \(myTableView.editing)")
    }
    
    
    //セルの行数を指定
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("data", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = items[indexPath.row]
        return cell
    }
    
    //編集ボタンが押された際に呼び出される.
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        //TableViewを編集可能にする
        myTableView.setEditing(editing, animated: true)
        
        //編集中のときのみaddButtomをナビゲーションバーの左に表示する
        if editing {
            print("編集中")
//            let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "tapBarButtonItem:")
//            self.navigationItem.setLeftBarButtonItem(addButton, animated: true)
        }
    }
    
    func onClick(){
        let message: String = "今は本当に大切な\n「5つ」の変化に\n注目してあげてください."
        let numberOfItems = items.count
        print(numberOfItems)
        if numberOfItems > 4 {
            let myAlert: UIAlertController = UIAlertController(title: nil, message: message, preferredStyle: .Alert)
            let myOKAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: {(action:UIAlertAction!) -> Void in
                print("OK")
            })
            myAlert.addAction(myOKAction)
            presentViewController(myAlert, animated: true, completion: nil)
        } else {
            print("追加")
            items.append("add Cell by clicked")
            print(items)
            myTableView.reloadData()
        }
    }
    
    func addCell(sender: AnyObject){
        print("追加")
        items.append("add Cell")
        myTableView.reloadData()
    }
    


}

