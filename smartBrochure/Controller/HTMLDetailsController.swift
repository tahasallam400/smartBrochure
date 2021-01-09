//
//  HTMLDetailsController.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/26/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import UIKit

class HTMLDetailsController: UIViewController {

    
    @IBOutlet weak var navigationTitle: UILabel!
    
    @IBOutlet weak var contentText: UILabel!
    var content:String?
    var contentTitle:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = corporation?.last?.name

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "back", style: UIBarButtonItemStyle.done, target: self, action: #selector(backButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: logo,  style: UIBarButtonItemStyle.plain, target: self, action: #selector(iconButton))
        contentText.attributedText = content?.html2AttributedString
        navigationTitle.text = contentTitle
      //  print("content title is >>> \(contentTitle)")
    }
    
    @objc func backButton(){
        navigationController?.popViewController(animated: true)
    }
    @objc func iconButton(){
        print("what is the first thing in the world ")
    }
}
