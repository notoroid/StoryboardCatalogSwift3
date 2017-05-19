//
//  SearchViewController.swift
//  SearchControll
//
//  Created by 能登 要 on 2017/05/20.
//  Copyright © 2017年 Kaname Noto. All rights reserved.
//

import UIKit

@objc protocol SearchViewControllerDelegate {
    func searchViewController(_ searchViewController: SearchViewController, didSelectObjectAt object: Any)
}

class SearchViewController: UITableViewController {

    var objects: [Any]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    weak var delegate: SearchViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let objects = objects else { return 0 }
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let object = objects?[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let object = objects?[indexPath.row] {
            delegate?.searchViewController(self, didSelectObjectAt: object)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

