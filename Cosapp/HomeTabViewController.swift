//
//  HomeTabViewController.swift
//  Cosapp
//
//  Created by APPLE on 3/25/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import UIKit
import Kingfisher
import FontAwesome_swift
import ImageSlideshow
import Scrollable

class HomeTabViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var topGridView: UICollectionView!
    
    @IBOutlet weak var downGridView: UICollectionView!

  
   
    var recommendationNames = [String]()
    var recomendationBackground = [URL]()
    var ratingsValues = [String]()
    
    
    
   
    var categoryNames = [String]()
    var categoryBackGroundimages = [URL]()
    var categoryIcons = [URL]()
    var categoryIDs = [String]()
    
    

    fileprivate let sectionInsets = UIEdgeInsets(top: 2.0, left: 10.0, bottom: 2.0, right: 10.0)
    fileprivate let itemsPerRow: CGFloat = 2

    
    var IDS = [String]()
    var icons = [URL]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       let value =  String.fontAwesomeIcon(name: FontAwesome.comment)
       chatButton.setTitle( value, for: UIControlState.normal)
       chatButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 45)
        
        stripCompanyCategories();
        stripRecommendations();
        
      //  setUpSlider();
        
       // Scrollable.createContentView(scrollView: scrollView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       // print("\(names.count)")
        
        if(collectionView == topGridView){
        
        return recommendationNames.count
        }else{
        
        return categoryNames.count //names.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       //var cell;
       
        if(collectionView == topGridView){
        
          let  Recomendationcell = self.topGridView.dequeueReusableCell(withReuseIdentifier: "recomendations", for: indexPath) as! RecomendationCollectionViewCell
            
          /**
             
             @IBOutlet weak var backgroundImage: UIImageView!
             
             @IBOutlet weak var viewRatings: CosmosView!
             
             @IBOutlet weak var textLabel: UILabel!
             
             
             */
            
            let image = UIImage(named: "placeholder")
          //  cell.iconView.kf.setImage(with: icons[indexPath.row],placeholder: image)
            Recomendationcell.backgroundImage.kf.setImage(with: recomendationBackground[indexPath.row],placeholder: image)
            Recomendationcell.textLabel.text = recommendationNames[indexPath.row]
            Recomendationcell.viewRatings.rating = Double(ratingsValues[indexPath.row])!    //   Double(ratingsValues[indexPath.row])
            
            Recomendationcell.contentView.addBottomBorder(color: UIColor(hue: 0.5694, saturation: 0.02, brightness: 0.95, alpha: 1.0) , width: Recomendationcell.contentView.frame.width)
            
             Recomendationcell.contentView.addLeftBorder(color: UIColor(hue: 0.5694, saturation: 0.02, brightness: 0.95, alpha: 1.0) , width: Recomendationcell.contentView.frame.height)
            
                 Recomendationcell.contentView.addRightBorder(color: UIColor(hue: 0.5694, saturation: 0.02, brightness: 0.95, alpha: 1.0) , width: Recomendationcell.contentView.frame.height)
            
            
                 Recomendationcell.contentView.addTopBorder(color: UIColor(hue: 0.5694, saturation: 0.02, brightness: 0.95, alpha: 1.0) , width: Recomendationcell.contentView.frame.width)
            return Recomendationcell;
            
            
        }else{
        
      let  Categorycell = self.downGridView.dequeueReusableCell(withReuseIdentifier: "categoryAds", for: indexPath) as! CategoryAdsCollectionViewCell
            
            
            
            Categorycell.contentView.addBottomBorder(color: UIColor(hue: 0.5694, saturation: 0.02, brightness: 0.95, alpha: 1.0) , width: Categorycell.contentView.frame.width)
            
            Categorycell.contentView.addLeftBorder(color: UIColor(hue: 0.5694, saturation: 0.02, brightness: 0.95, alpha: 1.0) , width: Categorycell.contentView.frame.height)
            
            Categorycell.contentView.addRightBorder(color: UIColor(hue: 0.5694, saturation: 0.02, brightness: 0.95, alpha: 1.0) , width: Categorycell.contentView.frame.height)
            
            
            Categorycell.contentView.addTopBorder(color: UIColor(hue: 0.5694, saturation: 0.02, brightness: 0.95, alpha: 1.0) , width: Categorycell.contentView.frame.width)

            
              let image = UIImage(named: "placeholder")
            Categorycell.backgroundImage.kf.setImage(with: categoryBackGroundimages[indexPath.row],placeholder: image)
            Categorycell.labelText.text = categoryNames[indexPath.row]
            Categorycell.labelText.adjustsFontSizeToFitWidth = true
            
             Categorycell.tag = Int(categoryIDs[indexPath.row])!
          
            
            
            if(categoryIcons[indexPath.row] == URL(string: "www.apple.com")!){
              Categorycell.iconImage?.setImage(string: categoryNames[indexPath.row], color: UIColor(hue: 0.5472, saturation: 1, brightness: 0.88, alpha: 1.0), circular: true)
            }else{
                
                Categorycell.iconImage.kf.setImage(with: icons[indexPath.row])
                Categorycell.iconImage.layer.cornerRadius = Categorycell.iconImage.frame.size.width / 2;
               Categorycell.iconImage.layer.masksToBounds = true;
            }

            
            
            return Categorycell;
        
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            let leftRightInset = self.view.frame.size.width / 14.0
            return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset)
        }
       

        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if(collectionView == downGridView){
        
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let currentCell = self.downGridView.cellForItem(at: indexPath) as! CategoryAdsCollectionViewCell
            AppConfig.setselected_category_id(id:  currentCell.tag.description)
            print("tag \(currentCell.tag.description)")
            
            let text2 = currentCell.labelText.text!  //currentCell.labelTitle.text!
            AppConfig.setselected_category_Name(id: text2)
            print("tag \(text2)")
            let vc = storyboard.instantiateViewController(withIdentifier: "registeredcompanies") as! RegisteredCompaniesViewController
            self.present(vc, animated: true, completion: nil)
        
        }
        
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let currentCell = self.CollectionView.cellForItem(at: indexPath) as! CategoriesCollectionViewCell
//        AppConfig.setselected_category_id(id:  currentCell.tag.description)
//        print("tag \(currentCell.tag.description)")
//        
//        let text2 = currentCell.cellLabel.text!  //currentCell.labelTitle.text!
//        AppConfig.setselected_category_Name(id: text2)
//        print("tag \(text2)")
//        let vc = storyboard.instantiateViewController(withIdentifier: "registeredcompanies") as! RegisteredCompaniesViewController
//        self.present(vc, animated: true, completion: nil)
        
        
        
    }

   
    func stripCompanyCategories(){
        
        if let info = AppConfig.getcompany_categories()["ecoachlabs"]["info"].array{
            
            for item in info {
                
                if let category_name = item["category_name"].string{
                    
                    categoryNames.append(category_name)
                    categoryBackGroundimages.append(URL(string: "www.apple.com")!)
                    print("URL " + category_name )
                    
                }
                
                if let category_ID = item["category_id"].string{
                    
                    categoryIDs.append(category_ID)
                    
                    print("category_ID " + category_ID )
                    
                }
                
                if let category_pic = item["category_pic"].string{
                    
                    if let url = URL(string: category_pic) {
                        
                        categoryIcons.append(url)
                        
                        print("URL " + category_pic )
                    }else{
                        print("URL " + "it was null" )
                        categoryIcons.append(URL(string: "www.apple.com")!)
                    }
                    
                    
                    
                }else{
                    
                    categoryIcons.append(URL(string: "www.apple.com")!)
                }
                
            }
            
            
        }
        
        downGridView.reloadData()
        
    }

    func stripRecommendations(){
        
        /*
         var recommendationNames = [String]()
         var recomendationBackground = [URL]()
         var ratingsValues = [String]()
         
         */
        
        if let info = AppConfig.getcompany_categories()["ecoachlabs"]["info"].array{
            
            for item in info {
                
                if let category_name = item["category_name"].string{
                    
                    recommendationNames.append(category_name)
                    recomendationBackground.append(URL(string: "www.apple.com")!)
                    ratingsValues.append("4.0")
                    print("URL " + category_name )
                    
                }
                
                
                    
                    
               
                
            }
            
            
        }
        
        topGridView.reloadData()
        
    }
    
    

}

extension HomeTabViewController : UICollectionViewDelegateFlowLayout {
    //1
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        
        
      
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        
        
        
        if(collectionView == downGridView){
            
            _ = CGSize.zero

//            if(indexPath.item % 2 == 0){
//            
//                
// size = CGSize(width: widthPerItem, height: widthPerItem)
//                
//            }else{
//            
//                
// size = CGSize(width: availableWidth, height: widthPerItem)
//            
//            }
            
         return CGSize(width: widthPerItem, height: widthPerItem)
        }else{
        return CGSize(width: widthPerItem, height: 120)
        }
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
