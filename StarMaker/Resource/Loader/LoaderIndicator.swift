//
//  LoaderIndicator.swift
//  StarMaker
//
//  Created by Raghu on 26/07/23.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class LoaderView {
    
    static public let sharedInstance = LoaderView()
    var loader : NVActivityIndicatorView!
    var baseView : UIView = UIView()
    var loaderActive : Bool = false
    
    
    func showLoader() {
        
        if !loaderActive {
            
            loaderActive = true
            
            let win = UIApplication.shared.windows.first(where: { (window) -> Bool in window.isKeyWindow})
            
            baseView = UIView(frame: UIScreen.main.bounds)
            baseView.backgroundColor = UIColor.clear
            win?.addSubview(baseView)
            win?.bringSubviewToFront(baseView)
            
            let dullView = UIView(frame: UIScreen.main.bounds)
            dullView.backgroundColor = UIColor.black
            dullView.alpha = 0.3
            baseView.addSubview(dullView)
            
            let loadView = UIView(frame: CGRect(x: (baseView.frame.width/2)-50, y: (baseView.frame.height/2)-50, width: 100, height: 100))
            loadView.backgroundColor = UIColor.clear
            loadView.alpha = 0.75
            loadView.layer.cornerRadius = 15
            
            //        let label = UILabel(frame: CGRect(x: (baseView.frame.width/2)-50, y: loadView.frame.maxY-40, width: 100, height: 40))
            //        label.text = "Loading..."
            //        loadView.addSubview(label)
            baseView.addSubview(loadView)
            
            loader = NVActivityIndicatorView(frame: CGRect(x: (baseView.frame.width/2)-30, y: (baseView.frame.height/2)-30, width: 60, height: 60) , type: NVActivityIndicatorType.ballSpinFadeLoader, color: UIColor.darkGray, padding: 0.5)
            baseView.addSubview(loader)
            loader.startAnimating()
        }
    }
    
    func hideLoader() {
        if loader != nil{
            DispatchQueue.main.async {
                self.loaderActive = false
                self.loader.stopAnimating()
                self.baseView.removeFromSuperview()
            }
        }
    }
    
    func showBottomLoader() {
        let win:UIWindow = UIApplication.shared.delegate!.window!!
        
        loader = NVActivityIndicatorView(frame: CGRect(x: win.frame.width / 2 - 20, y: win.frame.size.height-45-50, width: 40, height: 40), type: NVActivityIndicatorType.ballSpinFadeLoader, color: .black, padding: 0.1)
        win.addSubview(loader)
        loader.startAnimating()
    }
}
