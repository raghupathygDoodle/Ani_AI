//
//  InstaSynopsisViewController.swift
//  Ani AI
//
//  Created by Raghu on 03/09/23.
//

import UIKit

class InstaSynopsisViewController: UIViewController {

    @IBOutlet weak var imageTitleHeader: UIImageView!
    @IBOutlet weak var lblTitleHeader: UILabel!
    @IBOutlet weak var instaSynopsisTableView: UITableView!
    var textHeader = ""
    var textContent = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitleHeader.text = textHeader
        self.instaSynopsisTableView.delegate = self
        self.instaSynopsisTableView.dataSource = self
        self.instaSynopsisTableView.register(UINib(nibName: "ContentTextTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTextTableViewCell")

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
 
}
extension InstaSynopsisViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "ContentTextTableViewCell", for: indexPath) as? ContentTextTableViewCell else { return UITableViewCell() }
        cell.configureCell(with: self.textContent)
        return cell
    }
    
    
}
