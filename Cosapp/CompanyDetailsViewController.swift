//
//  CompanyDetailsViewController.swift
//  Cosapp
//
//  Created by APPLE on 3/23/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import UIKit
import ImageSlideshow
import Scrollable
import AlamofireImage
import Kingfisher
import SwiftyJSON
import Cosmos
import FontAwesome_swift



class CompanyDetailsViewController: UIViewController ,APIRequestDelegate{
    

    
    @IBOutlet weak var tabcontrolled: UISegmentedControl!
  
    @IBOutlet weak var holder: UIView!
    
   // @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var mapView: UIView!
    
    @IBOutlet weak var backgroundLogo: UIImageView!
    
    @IBOutlet weak var circularlogo: UIImageView!
    
    @IBOutlet weak var companyName: UILabel!
    
    @IBOutlet weak var companyCategory: UILabel!
    
    @IBOutlet weak var rating: CosmosView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: CosmosView!
    
    @IBOutlet weak var websiteLabel: UILabel!
    
    let linearBar: LinearProgressBar = LinearProgressBar()

    @IBOutlet weak var aboutUs: UILabel!
    
    @IBOutlet weak var bioDiscription: UILabel!
    
   
    @IBAction func changedSegment(_ sender: UISegmentedControl) {
        
        if(sender.selectedSegmentIndex == 0){
        
             profileView.isHidden = true
             detailView.isHidden = false
             mapView.isHidden = true
            //profileView.alpha = 0
        
        
        }else if(sender.selectedSegmentIndex == 1){
            
            profileView.isHidden = false
            detailView.isHidden = true
            mapView.isHidden = true
        
       // detailView.isHidden = true
        }else if(sender.selectedSegmentIndex == 2){
        
            profileView.isHidden = true
            detailView.isHidden = true
            mapView.isHidden = false
        
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
      
       // Scrollable.createContentView(scrollView: scrollView)
        
       
      
        self.navigationBar.topItem?.title = AppConfig.getselected_company_name()
        
       
        getCompanyDetails();
        
        
        setUIVIEWS()
        
    

    }

    
    func setUIVIEWS()  {
        
        profileView.isHidden = true
        detailView.isHidden = false
        mapView.isHidden = true
        holder.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        
        
        companyName.text = AppConfig.getselected_company_name()
        companyName.adjustsFontSizeToFitWidth = true
        companyCategory.adjustsFontSizeToFitWidth = true
        companyCategory.text = AppConfig.getselected_category_Name()
       
        
        circularlogo.layer.cornerRadius = 25;
        circularlogo.layer.masksToBounds = true;
        
        
        
        phoneLabel.addBottomBorder(color: UIColor(hue: 0.5694, saturation: 0.02, brightness: 0.95, alpha: 1.0) , width: phoneLabel.frame.width)
        addressLabel.addBottomBorder(color: UIColor(hue: 0.5694, saturation: 0.02, brightness: 0.95, alpha: 1.0) , width: addressLabel.frame.width)
        
        websiteLabel.addBottomBorder(color: UIColor(hue: 0.5694, saturation: 0.02, brightness: 0.95, alpha: 1.0) , width: websiteLabel.frame.width)
        
        emailLabel.addBottomBorder(color: UIColor(hue: 0.5694, saturation: 0.02, brightness: 0.95, alpha: 1.0) , width: emailLabel.frame.width)
        
        
        
        aboutUs.addBottomBorder(color: UIColor(hue: 0.5694, saturation: 0.02, brightness: 0.95, alpha: 1.0) , width: aboutUs.frame.width)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func navigateBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func getCompanyDetails() {
        var parameters = [String:AnyObject]()
        
        parameters["fetch_public_info"] = "1" as AnyObject?
        parameters["scope"] = "company_profile" as AnyObject?
        parameters["company_id"] = AppConfig.getselected_company_id() as AnyObject?
        //parameters["filter"] = "" as AnyObject?
        
        
        APIRequest.getCompanyCategories(withParameters: parameters, andRegisterRequestDelegate: self)
    }
    
    func requestWillBegin() {
        
        // self.refreshControl.beginRefreshing()
        self.linearBar.startAnimation()
        
    }
    func requestDidTerminateWithError(_ error: NSError?) {
        print(error ?? "falied")
        self.linearBar.stopAnimation();
        
        
    }
    func requestDidCompleteWithResponse(_ response: JSON) {
        print("response : \(response) ")
        var  statusCode = response["ecoachlabs"]["status"].stringValue;
        if statusCode == "201" {
            
            AppConfig.setcompany_registered(response)
            
            stripCompanyCategories(response)
            
          //  stripCompanyCategories()
            
            
            
        }
        
        
        
        self.linearBar.stopAnimation()
        // setPageMenuOfline();
        
        
        
        
    }
    func configureLinearProgressBar(){
        
        linearBar.backgroundColor = UIColor.white
        linearBar.progressBarColor = UIColor(hue: 0.5583, saturation: 1, brightness: 0.86, alpha: 1.0)
        linearBar.heightForLinearBar = 1
        navigationBar.addSubview(linearBar)
        //self.navigationController!.view.addSubview(linearBar)
        //self.view.addSubview(linearBar)
        
    }
    
    func stripCompanyCategories(_ response: JSON){
        
        if let info = response["ecoachlabs"]["info"].array{
            
         print("this should be the id \(info[0]["id"].stringValue)")
             let name = info[0]["company_name"].stringValue
            let path = info[0]["path"].stringValue
            let storage = info[0]["storage"].stringValue
            let avatar = info[0]["avatar"].stringValue
            let finalPath = path + "" + storage + "/" +  avatar
            
            
            
            if(avatar.isEmpty == true || storage.isEmpty == true || path.isEmpty == true){
            
           circularlogo?.setImage(string: name, color: UIColor(hue: 0.5472, saturation: 1, brightness: 0.88, alpha: 1.0), circular: true)
            }else{
            
              circularlogo.kf.setImage(with: URL(string: finalPath)!)
            }
            
            print("final path \(finalPath)")
            
            
             let aboutUs = info[0]["bio"].stringValue
             let addressContact = info[0]["address"].stringValue
            
              let phone1 = info[0]["phone1"].stringValue
              let phone2 = info[0]["phone2"].stringValue
            
             let email = info[0]["email"].stringValue
             let website = info[0]["website"].stringValue
            
             let ratingValue = info[0]["rating"].stringValue
            
            
            bioDiscription.text = aboutUs
            bioDiscription.numberOfLines = 0
            bioDiscription.sizeToFit()
            
            let address = String.fontAwesomeIcon(name: FontAwesome.addressCard)
            addressLabel.text = address + "  " + addressContact
            addressLabel.font = UIFont.fontAwesome(ofSize: 16)
            
             let phone = String.fontAwesomeIcon(name: FontAwesome.phone)
            
             phoneLabel.text = phone + "  " + phone1 + " \t" + phone2
             phoneLabel.font = UIFont.fontAwesome(ofSize: 16)
             phoneLabel.adjustsFontSizeToFitWidth = true
            
             let emailfont = String.fontAwesomeIcon(name: FontAwesome.envelope)
            
            emailLabel.text = emailfont + "  " + email
            emailLabel.font = UIFont.fontAwesome(ofSize: 16)
            emailLabel.adjustsFontSizeToFitWidth = true
            
             let websitefont = String.fontAwesomeIcon(name: FontAwesome.globe)
            
            
            websiteLabel.text = websitefont + "  " + website
            websiteLabel.font = UIFont.fontAwesome(ofSize: 16)
            websiteLabel.adjustsFontSizeToFitWidth = true
            
            
            ratingLabel.rating = Double(ratingValue)!
            
            }
        
        
        
        
        
    }
    
    
    
    //floating button
    
   





    
    

}
