//
//  MasterViewController.swift
//  AddForm
//
//  Created by 能登 要 on 2017/05/18.
//  Copyright © 2017年 Kaname Noto. All rights reserved.
//

import UIKit

public extension Notification.Name {
    static public let commitedNotificationName = Notification.Name("com.irimasu.Commited")
    static public let addedNotificationName = Notification.Name("com.irimasu.Added")
}

class MasterViewController: UITableViewController {

    static public let commitedNewObject:String = "newObject"
    static public let commitedOldObject:String = "oldObject"
    
    static public let addedObject:String = "object"
    
    private var observerCommited:Any? = nil
    private var observerAdded:Any? = nil
    
    var detailViewController: DetailViewController? = nil
    var objects = [Any]()

    func configureNotification() {
        observerCommited = NotificationCenter.default.addObserver(forName: .commitedNotificationName , object: nil, queue: OperationQueue.main, using: { [unowned self] note in
            
            let userInfo = note.userInfo
            if let (oo,no) = (userInfo?[MasterViewController.commitedOldObject] as? NSDate,userInfo?[MasterViewController.commitedNewObject] as? NSDate) as? (NSDate,NSDate) {

                if let index = self.objects.index(where: {
                    if let date = $0 as? NSDate {
                        print("date=\(date)")
                        print("oo=\(oo)")
                        
                        return date == oo
                    }
                    return false
                }){
                    self.objects[index] = no
                    
                    self.tableView.beginUpdates()
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .right)
                    self.tableView.endUpdates()
                }
                
            }
        })
        
        observerCommited = NotificationCenter.default.addObserver(forName: .addedNotificationName , object: nil, queue: OperationQueue.main, using: { [unowned self] note in
            
            let userInfo = note.userInfo
            if let o = userInfo?[MasterViewController.addedObject] {
                self.objects.insert(o, at: 0)
                
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
                self.tableView.endUpdates()
            }
        })
    }
    
    deinit {
        if let observerCommited = observerCommited {
            NotificationCenter.default.removeObserver(observerCommited)
        }
        
        if let observerAdded = observerAdded {
            NotificationCenter.default.removeObserver(observerAdded)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//        navigationItem.rightBarButtonItem = addButton
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        configureNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }else if( segue.identifier == "addSegue"){
            if let dvnc = segue.destination as? UINavigationController {
                if let dvc = dvnc.topViewController as? DetailViewController {
                    
                    dvc.editForm = true // フォーム入力
                    dvc.createDetail = true // 新規作成
                    dvc.detailItem = nil
                }
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

