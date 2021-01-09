//
//  ViewController.swift
//  smartBrochure
//
//  Created by taha abdelrahman on 1/13/18.
//  Copyright © 2018 taha abdelrahman. All rights reserved.
//

import UIKit
import Localize_Swift
class HomeController: UIViewController {
    var currentLanguage:String?
    static let activityIndicator = UIActivityIndicatorView()
    var timer:Timer?
    @IBOutlet weak var collectionView: UICollectionView!
    var listCategory = Category.list(language: UserPeference.currentLanguage())
    var listSlider = Slider.list(language: UserPeference.currentLanguage())
    var currentSliderImage:Int = -1
    var slider:sliderMaincollectionView? = nil
    static var updateCollectionView = false
    
    override func viewDidAppear(_ animated: Bool) {
        if UserPeference.currentLanguage() != currentLanguage{
            currentLanguage = UserPeference.currentLanguage()
            DataHub.loadData()
        }
    }
    
    override func viewDidLoad() {
        
        currentLanguage = UserPeference.currentLanguage()
        super.viewDidLoad()
        corporation = Corporation.list(language: UserPeference.currentLanguage())
        logo = (corporation?.last?.pic as? UIImage)?.resizeWithWidth(width: 70)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        HomeController.activityIndicator.center = self.view.center
        HomeController.activityIndicator.hidesWhenStopped = true
        HomeController.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        HomeController.activityIndicator.startAnimating()
        self.view.addSubview(HomeController.activityIndicator)
        
        navigationController?.navigationBar.topItem?.title = corporation?.last?.name
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: logo,  style: UIBarButtonItemStyle.plain, target: self, action: #selector(iconButton))
        
        navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(named:"settingIcon"),  style: UIBarButtonItemStyle.done, target: self, action: #selector(settingButton))
        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    @objc func runTimedCode(){
        if let slider = slider{
            if let numberOfSlider = listSlider?.count{
                if numberOfSlider - 1 > currentSliderImage{
                    currentSliderImage = currentSliderImage + 1
                }
                if   (listSlider != nil) && (listSlider?.count)! > 0{
                    if let image = listSlider![currentSliderImage].pic as? UIImage{
                        slider.image_.image = image
                    }
                    
                }
                if numberOfSlider - 1 == currentSliderImage{
                    
                    currentSliderImage = -1
                }
            }
        }
        if HomeController.updateCollectionView {
             listCategory = Category.list(language: UserPeference.currentLanguage())
             listSlider = Slider.list(language: UserPeference.currentLanguage())
           collectionView.reloadData()
            HomeController.updateCollectionView = false
            corporation = Corporation.list(language: UserPeference.currentLanguage())
            navigationController?.navigationBar.topItem?.title = corporation?.last?.name
        }
    }
    @objc func settingButton(){
       performSegue(withIdentifier: "languageSegue", sender: self)
    }
    @objc func iconButton(){
        print("what is the first thing in the world ")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableContentSegue"{
            if let vc = segue.destination as? TableContentController{
                vc.categoryContentList = (listCategory?[(collectionView.indexPathsForSelectedItems?.last?.row)!].category?.allObjects as? [CategoryContent])!
                
            }
        }else if segue.identifier == "HTMLDetailsSegue"{
            print("enter to html details segue ")
            if let vc = segue.destination as? HTMLDetailsController{
                print("vc")
                if let categoryContent = (listCategory?[(collectionView.indexPathsForSelectedItems?.last?.row)!].category?.allObjects as? [CategoryContent]){
                    print("++++++++++")
                  // print(categoryContent[0].id)
                   
                    print("++++++++")
                    
                   vc.content = categoryContent.last?.body
                    vc.contentTitle = categoryContent.last?.title
                    print("end enter ")
                }
                
            }
        }
    }
    
}

extension HomeController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return (listCategory?.count) ?? 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            slider = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderMaincollectionView", for: indexPath) as? sliderMaincollectionView
            slider?.layer.cornerRadius = 12
            slider?.image_.layer.cornerRadius = 12
            if let listSlider = listSlider{
                if listSlider.count > 0{
                    if let firstImage = listSlider[0].pic{
                        slider?.image_.image = firstImage as? UIImage
                    }
                }
            }
            return slider!
        }
        else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCollectionViewCell", for: indexPath) as! mainCollectionViewCell
            cell.layer.cornerRadius = 12
            //  cell.frame.size.width = (self.view.frame.width * 0.45)
            cell.title_.text = listCategory?[indexPath.row].name ?? ""
            cell.image_.image = listCategory?[indexPath.row].pic as? UIImage
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: self.view.frame.width * 0.98, height: 225)
        }else{
            return CGSize(width: self.view.frame.width * 0.48, height: self.view.frame.width * 0.60)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: self.view.frame.width * 0.01, left: self.view.frame.width * 0.01, bottom: self.view.frame.width * 0.01, right: self.view.frame.width * 0.01)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1{
            if let categoryList = listCategory![indexPath.row].category?.allObjects{
                if categoryList.count > 1{
                    performSegue(withIdentifier: "TableContentSegue", sender: self)
                }else if categoryList.count != 0{
                
                    performSegue(withIdentifier: "HTMLDetailsSegue", sender: self)
                }
            }
        }
    }
}


class mainCollectionViewCell:UICollectionViewCell{
    
    @IBOutlet weak var title_: UILabel!
    @IBOutlet weak var image_: UIImageView!
}
class sliderMaincollectionView:UICollectionViewCell{
    
    @IBOutlet weak var image_: UIImageView!
}



