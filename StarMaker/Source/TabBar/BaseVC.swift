//
//  BaseVC.swift
//  StarMaker
//
//  Created by Raghu on 17/07/23.
//

import UIKit

class BaseVC: UIViewController,UINavigationControllerDelegate,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    func hideTabBar() {
//        let tabVc = self.tabBarController as? CustomTabBarController
//        tabVc?.setTabBarHidden(tabBarHidden: true, vc: nil)
//    }
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height-140, width: 250, height: 100))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
            self.navigationController?.popViewController(animated: true)
        })
    } 
    func showTabBar() {
        let tabVc = self.tabBarController as? TabBarViewController
        tabVc?.setTabBar()
    }
    func startSpinnerLoading()
    {
        LoaderView.sharedInstance.showLoader()
    }
    func stopSpinnerLoading()
    {
        LoaderView.sharedInstance.hideLoader()
        
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
          return true
      }
    func goToPerticularTab(index: Int) {

//        if let vc =  self.getWindow()?.rootViewController as CustomTabBarController {
//            vc.customTabBarView.selectTabAt(index: index)
//        }
    }
//    func showOtherButtonsOfTabBar() {
//        if  let tabbar = self.getWindow()?.rootViewController as? CustomTabBarController {
//
//            tabbar.customTabBarView.hideButtonForFacilitySelection(isHidden: false)
//            Constants.appDelegate?.isMainTabbarNeedToBeLoaded = true
//        }
//
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
