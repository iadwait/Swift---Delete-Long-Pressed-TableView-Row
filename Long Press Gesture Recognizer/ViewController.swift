//
//  ViewController.swift
//  Long Press Gesture Recognizer
//
//  Created by Adwait Barkale on 24/11/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var deletionView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewTop: NSLayoutConstraint! //67
    
    var longSelectedRow = Int()
    var rowToBeDeleted = Int()
    
    var arrData = [
    "Row No. 1",
    "Row No. 2",
    "Row No. 3",
    "Row No. 4",
    "Row No. 5",
    "Row No. 6",
    "Row No. 7",
    "Row No. 8",
    "Row No. 9",
    "Row No. 10",
    ]
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {

        if sender.state == UIGestureRecognizer.State.began {

            let touchPoint = sender.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {

                print("Long pressed row: \(indexPath.row)")
                longSelectedRow = indexPath.row
                deletionView.isHidden = false
                tableViewTop.constant = 67
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deletionView.isHidden = true
        tableViewTop.constant = 0
        tableView.delegate = self
        tableView.dataSource = self
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        longSelectedRow = -1
        longPressRecognizer.minimumPressDuration = 1
        longPressRecognizer.delegate = self
        tableView.addGestureRecognizer(longPressRecognizer)
    }
    
    @IBAction func btnCancleTapped(_ sender: UIButton) {
        deletionView.isHidden = true
        tableViewTop.constant = 0
    }
    
    @IBAction func btnDeleteTapped(_ sender: UIButton) {
        //Perform Delete
        arrData.remove(at: rowToBeDeleted)
        rowToBeDeleted = -1
        tableView.reloadData()
        //Hiding View
        deletionView.isHidden = true
        tableViewTop.constant = 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.lblTitle.text = arrData[indexPath.row]
        
        if longSelectedRow == indexPath.row{
            rowToBeDeleted = longSelectedRow
            longSelectedRow = -1
            cell.backgroundColor = .systemBlue
        }else{
            cell.backgroundColor = .white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}

