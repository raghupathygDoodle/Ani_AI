//
//  IdeasViewModel.swift
//  StarMaker
//
//  Created by Raghu on 05/08/23.
//

import UIKit

class IdeasViewModel: NSObject {

    
    func registerTableviewNib(tableview: UITableView,completion: @escaping()->()){
        tableview.register(UINib(nibName: "ContentTextTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTextTableViewCell")
        tableview.register(UINib(nibName: "AudioDropDownTableViewCell", bundle: nil), forCellReuseIdentifier: "AudioDropDownTableViewCell")
        completion()
    }
}
