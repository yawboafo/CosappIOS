//
//  RegisteredCompaniesViewController.swift
//  Cosapp
//
//  Created by APPLE on 3/23/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import UIKit
import SwiftyJSON
import Cosmos
import FontAwesome_swift
import Kingfisher
import Letters
class RegisteredCompaniesViewController: UIViewController,APIRequestDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var navBar: UINavigationBar!
    var names  = [String]()
    var IDS  = [String]()
    var storages = [String]()
    var ratings  = [String]()
    var paths = [String]()
    var avators = [String]()
   
    @IBOutlet weak var tableView: UITableView!
    

     let linearBar: LinearProgressBar = LinearProgressBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLinearProgressBar();
        navBar.topItem?.title = AppConfig.getselected_category_Name()
         self.tableView.backgroundView = nil
        getCategories();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            
            
            stripCompanyCategories()
            
            
            
        }
        
        
        
        self.linearBar.stopAnimation()
       // setPageMenuOfline();
        
        
        
        
    }
    func configureLinearProgressBar(){
        
        linearBar.backgroundColor = UIColor.white
        linearBar.progressBarColor = UIColor(hue: 0.5583, saturation: 1, brightness: 0.86, alpha: 1.0)
        linearBar.heightForLinearBar = 1
        navBar.addSubview(linearBar)
       //self.navigationController!.view.addSubview(linearBar)
        //self.view.addSubview(linearBar)
        
    }
    func getCategories() {
        var parameters = [String:AnyObject]()
        
        parameters["fetch_public_info"] = "1" as AnyObject?
        parameters["category_id"] = AppConfig.getselected_category_id() as AnyObject?
        parameters["scope"] = "company_list" as AnyObject?
        //parameters["filter"] = "" as AnyObject?
        
        
        APIRequest.getCompanyCategories(withParameters: parameters, andRegisterRequestDelegate: self)
    }
    func stripCompanyCategories(){
        
        if let info = AppConfig.getcompany_registered()["ecoachlabs"]["info"].array{
            
            for item in info {
                
                if let category_name = item["company_name"].string{
                    
                    names.append(category_name)
                    
                    print("URL " + category_name )
                    
                }
                
                if let company_id = item["id"].string{
                    
                    IDS.append(company_id)
                    
                    print("company_id " + company_id )
                    
                }
                
                if let company_path = item["path"].string{
                    
                    paths.append(company_path)
                    
                    print("company_path " + company_path )
                    
                }
                
                
                if let company_storage = item["storage"].string{
                    
                    storages.append(company_storage)
                    
                    print("company_storage " + company_storage )
                    
                }
                
                
                if let company_rating = item["rating"].string{
                    
                    ratings.append(company_rating)
                    
                    print("company_rating " + company_rating )
                    
                }
                
                if let company_avatar = item["avatar"].string{
                    
                    avators.append(company_avatar)
                    
                    print("company_rating " + company_avatar )
                    
                }else{
                    avators.append("nothing")
                    
                    print("avators " + "null nothing" )
                
                }
                
              
            }
            
        }
        
        tableView.reloadData()
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if names.count <= 0{
            let emptyStateLabel = UILabel(frame: tableView.frame)
            emptyStateLabel.text = "No Companies Found Under this Category"
            emptyStateLabel.textAlignment = .center;
            emptyStateLabel.font =  UIFont(name: "Assistant-Semibold",
                                           size: 16.0)
            emptyStateLabel.numberOfLines = 0
            emptyStateLabel.textColor = UIColor(hue: 0.5583, saturation: 1, brightness: 0.86, alpha: 1.0)
            self.tableView.backgroundView = emptyStateLabel
            
            return 0;
        
        }else{
        self.tableView.backgroundView = nil
        return names.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "registered",for: indexPath) as! RegisteredCompaniesViewCell
        
        
        cell.businessname.text = names[indexPath.row]
        cell.rate.rating = Double(ratings[indexPath.row])!
        cell.hiddenIDlABEL.text = IDS[indexPath.row]
        
        
        if(avators[indexPath.row] == "nothing"){
        
        cell.avatar?.setImage(string: names[indexPath.row], color: UIColor(hue: 0.5472, saturation: 1, brightness: 0.88, alpha: 1.0), circular: true)
            
            let finalPath = paths[indexPath.row] + "" + storages[indexPath.row] + "/" +  avators[indexPath.row]
            
            
            print("final path \(finalPath)")
        }else{
        
            
            let finalPath = paths[indexPath.row] + "" + storages[indexPath.row] + "/" +  avators[indexPath.row]
            
            
            print("final path \(finalPath)")
            
        cell.avatar.kf.setImage(with: URL(string: finalPath)!)
        }
        
        
        cell.avatar.layer.cornerRadius = 25;
        cell.avatar.layer.masksToBounds = true;
        
        let value =  String.fontAwesomeIcon(name: FontAwesome.commentsO)
        
         cell.chatButton.setTitle( value, for: UIControlState.normal)
         cell.chatButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 34)
        
        
        
        cell.viewContent.addBottomBorder(color: UIColor(hue: 0.5694, saturation: 0.02, brightness: 0.95, alpha: 1.0) , width: cell.viewContent.frame.width)
        
        
        
//        cell.selectionStyle = UITableViewCellSelectionStyle.none
//        cell.title.text = names[indexPath.row]
//        cell.title.adjustsFontSizeToFitWidth = true
//        
//        ViewUtil.DecorateUILabel(cell.amount)
//        cell.amount.text = amount[indexPath.row]
//        cell.descrip.text = descrip[indexPath.row]
//        cell.descrip.adjustsFontSizeToFitWidth = true
//        cell.pseudoName.text = pseudoName[indexPath.row]
//        cell.pseudoName.adjustsFontSizeToFitWidth = false
//
//        
//        print("pusedo name   \(pseudoName[indexPath.row])")
        
        return cell
    }
    var lastSelection: IndexPath!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print("i was clicked")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let currentCell = self.tableView.cellForRow(at: indexPath) as! RegisteredCompaniesViewCell
       // currentCell.selectionStyle = UITableViewCellSelectionStyle.default
        
        let selectname = currentCell.businessname.text
        
        AppConfig.setselected_company_name(id: selectname!)
        AppConfig.setselected_company_id(id: currentCell.hiddenIDlABEL.text!)
        
       
      let vc = storyboard.instantiateViewController(withIdentifier: "companydetails") as! CompanyDetailsViewController
       
        self.present(vc, animated: true, completion: nil)
        
        
    }
    

    
}

extension UIView {
    
    func addTopBorder(color: UIColor, width: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutAttribute.height,
                                                relatedBy: NSLayoutRelation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutAttribute.height,
                                                multiplier: 1, constant: 1))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.top,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.top,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.leading,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.leading,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.trailing,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.trailing,
                                              multiplier: 1, constant: 0))
    }
    func addBottomBorder(color: UIColor, width: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutAttribute.height,
                                                relatedBy: NSLayoutRelation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutAttribute.height,
                                                multiplier: 1, constant: 1))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.bottom,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.bottom,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.leading,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.leading,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.trailing,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.trailing,
                                              multiplier: 1, constant: 0))
    }
    func addLeftBorder(color: UIColor, width: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutAttribute.width,
                                                relatedBy: NSLayoutRelation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutAttribute.width,
                                                multiplier: 1, constant: 1))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.leading,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.leading,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.bottom,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.bottom,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.top,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.top,
                                              multiplier: 1, constant: 0))
    }
    func addRightBorder(color: UIColor, width: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: NSLayoutAttribute.width,
                                                relatedBy: NSLayoutRelation.equal,
                                                toItem: nil,
                                                attribute: NSLayoutAttribute.width,
                                                multiplier: 1, constant: 1))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.trailing,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.trailing,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.bottom,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.bottom,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: NSLayoutAttribute.top,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: self,
                                              attribute: NSLayoutAttribute.top,
                                              multiplier: 1, constant: 0))
    }
}

