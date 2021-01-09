//
//  TableDetailsController.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/26/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import UIKit

class TableDetailsController: UIViewController {

    var content:String = ""
    var contentTitle:String = ""
    
    @IBOutlet weak var navigationContentTitle: UILabel!
    @IBOutlet weak var bodyContent: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = corporation?.last?.name
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "back", style: UIBarButtonItemStyle.done, target: self, action: #selector(backButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: logo,  style: UIBarButtonItemStyle.done, target: self, action: #selector(iconButton))
        navigationContentTitle.text = contentTitle
        bodyContent.attributedText = content.html2AttributedString
    }
    
    @objc func backButton(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func iconButton(){
        print("what is the first thing in the world ")
    }
}
