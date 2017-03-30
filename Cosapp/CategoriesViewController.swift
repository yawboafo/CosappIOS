//
//  CategoriesViewController.swift
//  Cosapp
//
//  Created by APPLE on 3/22/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import Letters


class CategoriesViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    var names = [String]()
     var IDS = [String]()
    var icons = [URL]()
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        if(names.count == 0){
         stripCompanyCategories();
        
        }
    }
    override func viewDidAppear(_ animated: Bool) {
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpRefreshControl(){
        // set up the refresh control
        self.refreshControl.attributedTitle = NSAttributedString(string: "Loading")
       // self.refreshControl.addTarget(self, action: #selector(CornerShopVC.refresh(_:)), for: UIControlEvents.valueChanged)
        self.CollectionView?.addSubview(refreshControl)
        self.CollectionView.alwaysBounceVertical = true
        
        
       
        
    }
    
    
    func stripCompanyCategories(){
        
        if let info = AppConfig.getcompany_categories()["ecoachlabs"]["info"].array{
            
            for item in info {
                
                if let category_name = item["category_name"].string{
                    
                    names.append(category_name)
                    
                    print("URL " + category_name )
                    
                }
                
                if let category_ID = item["category_id"].string{
                    
                    IDS.append(category_ID)
                    
                    print("category_ID " + category_ID )
                    
                }
                
                if let category_pic = item["category_pic"].string{
                    
                    if let url = URL(string: category_pic) {
                        
                        icons.append(url)
                        
                        print("URL " + category_pic )
                    }else{
                         print("URL " + "it was null" )
                    icons.append(URL(string: "www.apple.com")!)
                    }
                    
                    
                    
                }else{
                
                 icons.append(URL(string: "www.apple.com")!)
                }
                
            }
            
            
        }
        
        CollectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("\(names.count)")
        return names.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell  = self.CollectionView.dequeueReusableCell(withReuseIdentifier: "categorycell", for: indexPath) as! CategoriesCollectionViewCell
        
        //cell.tag = 0
        
        cell.layer.masksToBounds = false;
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.borderWidth = 1.0
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowColor = UIColor(hue: 0.95, saturation: 0, brightness: 0.96, alpha: 1.0).cgColor
        cell.layer.shadowRadius = 2
        cell.layer.shadowOpacity = 0.25
        cell.layer.masksToBounds = false;
        cell.clipsToBounds = false;
        
        
        
        if (names.count > 0) {
            cell.tag = Int(IDS[indexPath.row])!
            cell.cellLabel.text = names[indexPath.row]
            cell.cellLabel.adjustsFontSizeToFitWidth = true
          
         //  let loadingGif = UIImage.gifImageWithName("default")
            
            print(icons[indexPath.row])
            if(icons[indexPath.row] == URL(string: "www.apple.com")!){
            cell.iconView?.setImage(string: names[indexPath.row], color: UIColor(hue: 0.5472, saturation: 1, brightness: 0.88, alpha: 1.0), circular: true)
            }else{
            
            cell.iconView.kf.setImage(with: icons[indexPath.row])
                cell.iconView.layer.cornerRadius = cell.iconView.frame.size.width / 2;
                cell.iconView.layer.masksToBounds = true;
            }
            
            //cell.iconView?.setImage(string: names[indexPath.row], color: UIColor(hue: 0.5472, saturation: 1, brightness: 0.88, alpha: 1.0), circular: true)
        }
        
        
        
        
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let currentCell = self.CollectionView.cellForItem(at: indexPath) as! CategoriesCollectionViewCell
      AppConfig.setselected_category_id(id:  currentCell.tag.description)
        print("tag \(currentCell.tag.description)")
        
     let text2 = currentCell.cellLabel.text!  //currentCell.labelTitle.text!
      AppConfig.setselected_category_Name(id: text2)
        print("tag \(text2)")
       let vc = storyboard.instantiateViewController(withIdentifier: "registeredcompanies") as! RegisteredCompaniesViewController
       self.present(vc, animated: true, completion: nil)
        

        
    }
    
    
    
    

}


extension UIImage
{
    func roundImage() -> UIImage
    {
        
        let point = CGPoint(x: 0, y: 0)
        let newImage = self.copy() as! UIImage
        let cornerRadius = self.size.height/2
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1.0)
        let bounds = CGRect(origin: point, size: self.size)
        UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).addClip()
        newImage.draw(in: bounds)
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage!
    }
}
