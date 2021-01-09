//
//  ImageDetailsController.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/27/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import UIKit

class ImageDetailsController: UIViewController {

    var listPhoto:[Photo] = []
    var selectedIndex:Int = 0
    @IBOutlet weak var currentImage_: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = corporation?.last?.name
        navigationItem.rightBarButtonItem  =  UIBarButtonItem(image: logo,  style: UIBarButtonItemStyle.done, target: self, action: #selector(iconButton))
        currentImage_.layer.cornerRadius = 12
        let backButton_ = UIBarButtonItem(title: "back", style: UIBarButtonItemStyle.done, target: self, action: #selector(backButton))
        let shareButton = UIBarButtonItem(image: UIImage(named:"share"), style: UIBarButtonItemStyle.done, target: self, action: #selector(shareIcon))
        navigationItem.leftBarButtonItems = [backButton_,shareButton]
        currentImage_.image = listPhoto[selectedIndex].path as? UIImage
    
    }
    @objc func shareIcon(){
        let activityVC = UIActivityViewController(activityItems: [currentImage_.image!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    @objc func backButton(){
        navigationController?.popViewController(animated: true)
    }
    @objc func iconButton(){
        print("what is the first thing in the world ")
    }
}

extension ImageDetailsController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPhoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageDetailsCell", for: indexPath) as! imageDetailsCell
        cell.layer.cornerRadius = 12
        cell.image_.image = listPhoto[indexPath.row].path as? UIImage
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentImage_.image = listPhoto[indexPath.row].path as? UIImage
    }
}

class imageDetailsCell:UICollectionViewCell{
    
    @IBOutlet weak var image_: UIImageView!
}
