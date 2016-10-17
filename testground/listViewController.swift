//
//  ViewController.swift
//  testground
//
//  Created by Yuto Mizutani on 2016/10/14.
//  Copyright © 2016年 Yuto Mizutani. All rights reserved.
//

import UIKit

class listViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var model = modelOfList()
    var myTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "onClick")
        self.navigationItem.rightBarButtonItem = addBtn
        
        //navigationBarに表示するタイトル
        self.title = "items"

        //displayのサイズを読み取ってtableViewを生成
        let displayWidth :CGFloat = self.view.bounds.width
        let displayHeight:CGFloat = self.view.bounds.height
        myTableView = UITableView(frame: CGRectMake(0, 0, displayWidth, displayHeight))
        
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "data")
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.allowsMultipleSelectionDuringEditing = true
        
        
        self.view.backgroundColor = UIColor.redColor()
        self.view.addSubview(myTableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //セルが選択された際に呼び出される.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(model.items[indexPath.row])")
        print("canEddit: \(myTableView.editing)")
    }
    
    
    //セルの行数を指定
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("data", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = model.items[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            model.items.removeAtIndex(indexPath.row)
            myTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    

    
    func onClick(){
        let message: String = "今は本当に大切な\n「5つ」の変化に\n注目してあげてください."
        let numberOfItems = model.items.count
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
            model.items.append("add Cell by clicked")
            print(model.items)
            myTableView.reloadData()
        }
    }

    


}

