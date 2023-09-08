//
//  CustomTabBarController.swift
//  StarMaker
//
//  Created by Raghu on 13/07/23.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController
{
    //MARK: - All variables
//    var customTabBarView: CustomTabBarView!
//    var forceHideTabBar = false
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - All methods
//    private func setupUI(){
//        customTabBarView = Bundle.main.loadNibNamed("CustomTabBarView", owner: nil, options: nil)!.first as? CustomTabBarView
//        customTabBarView.delegate = self
//
//        self.view.addSubview(customTabBarView)
//
//        //customTabBarView.btnTabHeightConstraint.constant = self.tabBar.frame.size.height + 30
//
//        var tabBarHeight = CGFloat(60) //self.tabBar.frame.size.height + 20
//
//
//        if ScreenSize.SCREEN_HEIGHT > CGFloat(1792) || ScreenSize.SCREEN_HEIGHT == CGFloat(812) {
//            tabBarHeight = CGFloat(75)
//        }
//
//        //        if #available(iOS 11.0, *) {
//        //            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
//        //
//        //
//        //            if ((keyWindow?.safeAreaInsets.top ?? 0.0) > CGFloat(0.0))
//        //            {
//        //                tabBarHeight = tabBarHeight + (keyWindow!.safeAreaInsets.bottom) + 30//iPhone x tab bar height
//        //            }
//        //        }
//
//        customTabBarView.translatesAutoresizingMaskIntoConstraints = false
//
//        customTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
//        customTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
//        customTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
//        customTabBarView.heightAnchor.constraint(equalToConstant: tabBarHeight).isActive = true
//
//        self.view.layoutIfNeeded()
//
//        setupViewControllers()
//
//        if forceHideTabBar
//        {
//            self.tabBar.isHidden = true
//            self.customTabBarView.isHidden = true
//        }
//    }
    
    
    
//    private func setupViewControllers()
//    {
//        var viewControllers = [AnyObject]()
//
//        let navController1: UINavigationController = Constants.StoryBoards.main.instantiateViewController(withIdentifier: "HomeNavVC") as! UINavigationController
////        let navController2: UINavigationController = Constants.Storyboard.home.instantiateViewController(withIdentifier: "HomePageNavVC") as! UINavigationController
////        let navController3: UINavigationController = Constants.Storyboard.serviceCall.instantiateViewController(withIdentifier: "ServiceCallNavVC") as! UINavigationController
////
////        let navController4: UINavigationController = Constants.Storyboard.serviceCall.instantiateViewController(withIdentifier: "PartRequestNavVC") as! UINavigationController
////
////        let navController5: UINavigationController = Constants.Storyboard.more.instantiateViewController(withIdentifier: "MoreViewNav") as! UINavigationController
////
////        let navController6: UINavigationController = Constants.Storyboard.serviceCall.instantiateViewController(withIdentifier: "ServiceReportNavVC") as! UINavigationController
//
//
//
//        viewControllers = [navController1]
////                           , navController2, navController3, navController4,navController5,navController6]
//
//        self.viewControllers = viewControllers as? [UIViewController]
//
////        customTabBarView.selectTabAt(index: 0)
//    }
    
//    func tabBarHidden() -> Bool
//    {
//        return customTabBarView.isHidden && self.tabBar.isHidden
//    }
    
//    func setTabBarHidden(tabBarHidden: Bool, vc: UIViewController?)
//    {
//        if(tabBarHidden)
//        {
//            self.tabBar.isHidden = true
//            self.customTabBarView.isHidden = tabBarHidden
//
//            vc?.edgesForExtendedLayout = UIRectEdge.bottom
//
//        }
//        else
//        {
//            if !forceHideTabBar
//            {
//                self.tabBar.isHidden = true
//                self.customTabBarView.isHidden = tabBarHidden
//
//                vc?.edgesForExtendedLayout = UIRectEdge.top
//
//            }
//
//        }
//    }
    
    //MARK: -
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

//MARK: - CustomTabBarViewDelegate
//extension CustomTabBarController: CustomTabBarViewDelegate{
//
//    func tabSelectedAtIndex(tabIndex: Int)  {
//        let selectedVC =  self.viewControllers![tabIndex]
//
//        selectedIndex = tabIndex
//
//
////        if (self.selectedViewController == selectedVC)
////        {
////            let navVc = self.selectedViewController as! UINavigationController
////            navVc.isNavigationBarHidden = true
////            if tabIndex == 1 {
////                let navController1 = self.viewControllers![0] as! UINavigationController
////                let homeVc = navController1.viewControllers.first! as!  HomeViewController
////
////                let homePageVc = navVc.viewControllers.first! as!  HomePageViewController
////                homePageVc.homeViewModel = homeVc.viewModel
////            }
////
////            navVc.popToRootViewController(animated: true)
////        }
//
//        super.selectedViewController = selectedViewController
//    }
//}
