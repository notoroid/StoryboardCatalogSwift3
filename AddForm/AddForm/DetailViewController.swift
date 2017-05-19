//
//  DetailViewController.swift
//  AddForm
//
//  Created by 能登 要 on 2017/05/18.
//  Copyright © 2017年 Kaname Noto. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    public var createDetail = Bool(false)
    public var editForm = Bool(false)
    
    private var oldObject:NSDate? = nil
    private var observerCommited:Any? = nil
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!

    func configureNotification() {
        observerCommited = NotificationCenter.default.addObserver(forName: .commitedNotificationName , object: nil, queue: OperationQueue.main, using: { [unowned self] note in

            if let (oo,no) = (note.userInfo?[MasterViewController.commitedOldObject] as? NSDate,note.userInfo?[MasterViewController.commitedNewObject] as? NSDate) as? (NSDate,NSDate) {
                if oo == self.detailItem {
                    self.detailItem = no
                }
            }
        })
    }
    
    deinit {
        if let observerCommited = observerCommited {
            NotificationCenter.default.removeObserver(observerCommited)
        }
    }
    
    func configureView() {
        if editForm != true {
            // Update the user interface for the detail item.
            if let detail = detailItem {
                if let label = detailDescriptionLabel {
                    label.text = detail.description
                    label.isHidden = false
                }
                
                if let button = editButton {
                    button.isHidden = true
                }
            }else{
                if let label = detailDescriptionLabel {
                    label.isHidden = true
                }
                if let button = editButton {
                    button.isHidden = true
                }
            }
            
        }else{
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:#selector(onCancel(_:)))
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:#selector(onDone(_:)))
            
            
            // Update the user interface for the detail item.
            if let detail = detailItem {
                if let label = detailDescriptionLabel {
                    label.isHidden = true
                }

                if let button = editButton {
                    button.setTitle(detail.description, for: .normal)
                    button.isHidden = false
                }
            }else{
                if let label = detailDescriptionLabel {
                    label.isHidden = true
                }
                if let button = editButton {
                    button.setTitle("日付を指定", for: .normal)
                    button.isHidden = false
                }
            }
            
        }
    }

    func onCancel(_ sender:Any? )
    {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func onDone(_ sender:Any? )
    {
        if createDetail != true {
            if let oo = oldObject {
                if let no = detailItem {
                    let userInfo = [MasterViewController.commitedOldObject:oo,MasterViewController.commitedNewObject:no]
                        // 更新を通知
                    NotificationCenter.default.post(name: .commitedNotificationName, object: nil, userInfo:userInfo )
                }
            }
        }else{
            if let o = detailItem {
                let userInfo = [MasterViewController.addedObject:o]
                    // 更新を通知
                NotificationCenter.default.post(name: .addedNotificationName, object: nil, userInfo:userInfo )
            }
        }
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNotification()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            if let dvnc = segue.destination as? UINavigationController {
                if let dvc = dvnc.topViewController as? DetailViewController {
                    dvc.editForm = true
                    dvc.detailItem = detailItem
                }
            }
        }
    }
    
    @IBAction func onEdit(_ sender: Any) {
        if oldObject == nil {
            oldObject = detailItem
        }
        detailItem = NSDate()
    }

}

