//
//  TableContentController.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/26/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import UIKit

class TableContentController: UIViewController {

    var categoryContentList:[CategoryContent] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        navigationItem.title = corporation?.last?.name
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "back", style: UIBarButtonItemStyle.done, target: self, action: #selector(backButton))
         navigationItem.rightBarButtonItem = UIBarButtonItem(image: logo,  style: UIBarButtonItemStyle.done, target: self, action: #selector(iconButton))
        
    }
    
    @objc func backButton(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func iconButton(){
        print("what is the first thing in the world ")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TableDetailsController{
            if let contentBody = categoryContentList[(tableView.indexPathForSelectedRow?.row)!].body{
                vc.content = contentBody
            }
            if let titleBody = categoryContentList[(tableView.indexPathForSelectedRow?.row)!].title{
                vc.contentTitle = titleBody
            }
        }
    }
}

extension TableContentController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryContentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "TableContentCell", for: indexPath) as! TableContentCell
        cell.image_.layer.cornerRadius = cell.image_.frame.width / 2
        cell.title.text = categoryContentList[indexPath.row].title
        cell.image_.image = categoryContentList[indexPath.row].photo as? UIImage
        if let timeStamp = categoryContentList[indexPath.row].date{
            if let timeStamp = Double(timeStamp){
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    cell.datetime.text = dateformatter.string(from: Date(timeIntervalSince1970:timeStamp))
            }
        }
        return cell
    }
}

class TableContentCell:UITableViewCell{
    
    @IBOutlet weak var image_: UIImageView!
    @IBOutlet weak var datetime: UILabel!
    @IBOutlet weak var title: UILabel!
}
