//
//  ElementViewController.swift
//  DidAppear
//
//  Created by 能登 要 on 2017/05/18.
//  Copyright © 2017年 Kaname Noto. All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {
    public var tabIndex = Int(0)
    private var callCount = Int(0)
    
    public var pageIndex = Int(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        callCount = callCount + 1
        
        if pageIndex == 0 {
            print("tabIndex=\(tabIndex) ElementViewController.viewDidAppear() : callCount=\(callCount)")
        }
        
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
