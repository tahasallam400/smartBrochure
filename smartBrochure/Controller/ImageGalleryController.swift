//
//  ImageGalleryController.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/27/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import UIKit

class ImageGalleryController: UIViewController {
    var listPhoto:[Photo] = []
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if let vc = segue.destination as? ImageDetailsController{
            vc.selectedIndex = (collectionView.indexPathsForSelectedItems?.last?.row)!
            vc.listPhoto = listPhoto
        }
    }
}

extension ImageGalleryController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPhoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageGalleryCell", for: indexPath) as! ImageGalleryCell
        cell.layer.cornerRadius = 12
        cell.image_.image = listPhoto[indexPath.row].path as? UIImage
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.48, height: self.view.frame.width * 0.48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: self.view.frame.width * 0.01, left: self.view.frame.width * 0.01, bottom: self.view.frame.width * 0.01, right: self.view.frame.width * 0.01)
        
    }
}
class ImageGalleryCell:UICollectionViewCell{
    
    @IBOutlet weak var image_: UIImageView!
}
