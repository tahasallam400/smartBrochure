//
//  VCController.swift
//  smartBrochure
//
//  Created by TAHA SALLAM on 5/5/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import UIKit
import Localize_Swift

class VCController: UIViewController {

    var selectedIndex:Int? = nil
    let languageList = Language.list()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        navigationItem.title = corporation?.last?.name
        navigationItem.rightBarButtonItem  =  UIBarButtonItem(image: logo,  style: UIBarButtonItemStyle.done, target: self, action: #selector(iconButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "back", style: UIBarButtonItemStyle.done, target: self, action: #selector(backButton))
        
        if let languageList = languageList{
            for (index,languageItem) in languageList.enumerated(){
                if languageItem.uniqueSeoCode == UserPeference.currentLanguage(){
                    selectedIndex = index
                }
            }
        }
        tableView.reloadData()
    }
    @objc func iconButton(){
        print("what is the first thing in the world ")
    }
    @objc func backButton(){
        navigationController?.popViewController(animated: true)
    }
}

extension VCController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageTableCell", for: indexPath) as? languageTableCell
        cell?.title_.text = languageList?[indexPath.row].name
        cell?.language_.image = UIImage(named: "circleEmpty")
        if let selectedIndex = selectedIndex{
            if indexPath.row == selectedIndex{
                cell?.language_.image = UIImage(named: "circleEmptyCopy")
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (languageList?.count)!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if let currentLanguage = languageList?[indexPath.row].uniqueSeoCode{
            Localize.setCurrentLanguage(currentLanguage)
            UserPeference.setCurrentLanguage(currentLanguage: currentLanguage)
        }
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
    
}

class languageTableCell:UITableViewCell{
    
    @IBOutlet weak var language_: UIImageView!
    @IBOutlet weak var title_: UILabel!
}
