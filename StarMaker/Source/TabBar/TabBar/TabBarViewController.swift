//
//  TabBarViewController.swift
//  StarMaker
//
//  Created by Raghu on 28/07/23.
//

import UIKit

class TabBarViewController: UITabBarController {
    

    @IBOutlet weak var viewTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabBar()
        self.setupTabBar()
        // Do any additional setup after loading the view.
    }
    
    func setTabBar(){
        tabBar.backgroundColor = .white
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .gray
    }
    func setupTabBar() {
            tabBar.layer.shadowColor = UIColor.gray.cgColor
            tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            tabBar.layer.shadowRadius = 15
        tabBar.layer.shadowOpacity = 0.4
            tabBar.layer.masksToBounds = false

        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
