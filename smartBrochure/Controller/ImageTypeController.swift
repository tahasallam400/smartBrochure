//
//  ImageTypeController.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 4/27/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import UIKit

class ImageTypeController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let imageType = Album.list()
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
        if segue.identifier == "imageGallerySegue"{
            if let vc = (segue.destination as? ImageGalleryController){
                
                if let photoList = imageType?[(collectionView.indexPathsForSelectedItems?.last?.row)!].photo?.allObjects as? [Photo]{
                    vc.listPhoto = photoList
                }
            }
        }
        
    }
}
extension ImageTypeController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageTypeCell", for: indexPath) as! ImageTypeCell
        cell.layer.cornerRadius = 12
        cell.title_.text = imageType?[indexPath.row].name
        if let images = imageType?[indexPath.row].photo?.allObjects as? [Photo]{
            cell.image.image = images.last?.path as? UIImage
        }
       
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (imageType?.count) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.48, height: self.view.frame.width * 0.48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: self.view.frame.width * 0.01, left: self.view.frame.width * 0.01, bottom: self.view.frame.width * 0.01, right: self.view.frame.width * 0.01)
        
    }
    
}

class ImageTypeCell:UICollectionViewCell{
    
    
    @IBOutlet weak var image: UIImageView!
    
    
    @IBOutlet weak var title_: UILabel!
}
