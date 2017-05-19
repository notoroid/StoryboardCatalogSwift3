//
//  PageViewController.swift
//  DidAppear
//
//  Created by 能登 要 on 2017/05/18.
//  Copyright © 2017年 Kaname Noto. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    public var tabIndex = Int(0)
    
    var initialized = Bool(false)
    var elementViewControllers = Array<UIViewController>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        dataSource = self
        delegate = self
        
        if let  element1 = storyboard?.instantiateViewController(withIdentifier: "page1ViewController") as? ElementViewController {
            element1.tabIndex = tabIndex
            element1.pageIndex = 0
            elementViewControllers.append(element1)
        }
        
        if let  element2 = storyboard?.instantiateViewController(withIdentifier: "page2ViewController") as? ElementViewController {
            element2.tabIndex = tabIndex
            element2.pageIndex = 1
            elementViewControllers.append(element2)
        }
        
        if let  element3 = storyboard?.instantiateViewController(withIdentifier: "page3ViewController") as? ElementViewController {
            element3.tabIndex = tabIndex
            element3.pageIndex = 2
            elementViewControllers.append(element3)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if  initialized != true {
            initialized = true
            
            setViewControllers([elementViewControllers.first!], direction: .forward, animated: true, completion: nil)
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

extension PageViewController : UIPageViewControllerDelegate
{
    
}

extension PageViewController : UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let evc = viewController as? ElementViewController {
            if evc.pageIndex == 0 {
                return nil
            }
            let nextPageIndex = -1 + evc.pageIndex
            return elementViewControllers[nextPageIndex]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let evc = viewController as? ElementViewController {
            let nextPageIndex = 1 + evc.pageIndex
            if nextPageIndex == elementViewControllers.count {
                return nil
            }
            return elementViewControllers[nextPageIndex]
        }
        return nil
    }
    
}

/*
 - (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
 {
 QEListElementViewController *listElementViewController = [viewController isKindOfClass:[QEListElementViewController class]] ? (QEListElementViewController *)viewController : nil;
 
 NSInteger pageIndex = listElementViewController.pageIndex;
 if( pageIndex == 0 ){
 return nil;
 }
 
 pageIndex--;
 
 return _viewControllers[pageIndex];
 }
 
 - (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
 {
 QEListElementViewController *listElementViewController = [viewController isKindOfClass:[QEListElementViewController class]] ? (QEListElementViewController *)viewController : nil;
 
 NSInteger pageIndex = listElementViewController.pageIndex;
 pageIndex++;
 
 if( pageIndex == _viewControllers.count ){
 return nil;
 }
 
 return _viewControllers[pageIndex];
 }
 
 - (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
 {
 NSLog(@"pageViewController: willTransitionToViewControllers: call");
 
 _lastPageIndex = NSIntegerMax;
 [pendingViewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
 QEListElementViewController *listElementViewController = (QEListElementViewController *)obj;
 NSLog(@"listElementViewController.pageIndex=%@",@(listElementViewController.pageIndex));
 _lastPageIndex = listElementViewController.pageIndex;
 }];
 
 }
 
 - (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
 {
 NSLog(@"pageViewController: didFinishAnimating: call");
 
 //    [previousViewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
 //        QEListElementViewController *listElementViewController = (QEListElementViewController *)obj;
 //        NSLog(@"listElementViewController.pageIndex=%@",@(listElementViewController.pageIndex));
 //
 //    }];
 
 if( _lastPageIndex != NSIntegerMax ){
 [self updatePageTitleWithPageIndex:_lastPageIndex];
 
 dispatch_async(dispatch_get_main_queue(), ^{
 [_viewControllers[_lastPageIndex] listElementDidScrolled];
 });
 }
 }
 
 */
