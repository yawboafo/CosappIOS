//
//  HomeViewController.swift
//  Cosapp
//
//  Created by APPLE on 3/22/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import UIKit
import PageMenu
import FontAwesome_swift
import SwiftyJSON



class HomeViewController: UIViewController,CAPSPageMenuDelegate,APIRequestDelegate {
  
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var notificationButton: UIBarButtonItem!
    let linearBar: LinearProgressBar = LinearProgressBar()
    var names = [String]()
    var icons = [URL]()
    var refreshControl = UIRefreshControl()
    var pageMenu : CAPSPageMenu?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLinearProgressBar();
        setNotificationIcon();
        //setPageMenuOfline();
        getCategories();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNotificationIcon(){
       // notificationButton.title =  String.fontAwesomeIcon(name: FontAwesome.bell)
        //notificationButton.setTitleTextAttributes([NSFontAttributeName:  UIFont.fontAwesome(ofSize: 17)], for: UIControlState.normal)
    }

    func setPageMenuOfline(){
        
        
        
        var controllerArray : [UIViewController] = []
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController2 = storyboard.instantiateViewController(withIdentifier: "homrtab") as! HomeTabViewController
        viewController2.title =   "Home"
        controllerArray.append(viewController2)
        
        
        let viewController1 = storyboard.instantiateViewController(withIdentifier: "categories") as! CategoriesViewController
        viewController1.title =   "Categories"
        controllerArray.append(viewController1)
        
        
       
        
        let viewController3 = storyboard.instantiateViewController(withIdentifier: "company") as! CompanyViewController
        viewController3.title =   "Recent Search"
        controllerArray.append(viewController3)
        
        
        
        
        //UIColor(hue: 0.5472, saturation: 1, brightness: 0.88, alpha: 1.0)
        
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .scrollMenuBackgroundColor( UIColor.white),
            .viewBackgroundColor(UIColor(hue: 0.5472, saturation: 1, brightness: 0.88, alpha: 1.0)),
            //.bottomMenuHairlineColor(UIColor(hue: 0.5722, saturation: 1, brightness: 0.32, alpha: 1.0)),
            .selectionIndicatorColor(UIColor(hue: 0.5472, saturation: 1, brightness: 0.88, alpha: 1.0)),
            .menuMargin(20.0),
            
          
            .menuHeight(55.0),
            .selectionIndicatorColor(UIColor(hue: 0.5472, saturation: 1, brightness: 0.88, alpha: 1.0)),
            .selectedMenuItemLabelColor(UIColor(hue: 0.5583, saturation: 1, brightness: 0.86, alpha: 1.0)),
            .unselectedMenuItemLabelColor(UIColor(hue: 0.5472, saturation: 1, brightness: 0.88, alpha: 1.0)),
            .menuItemFont(UIFont(name: "Assistant-SemiBold", size: 16.0)!),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorRoundEdges(true),
            .selectionIndicatorHeight(2.0),
            .enableHorizontalBounce(false),
            .menuItemSeparatorPercentageHeight(0.0)
        ]
        
        let navheight = (navBar.frame.size.height ) // + UIApplication.shared.statusBarFrame.size.height
        
//let navheight = CGFloat(44.0)
        let frame = CGRect(x: 0, y: navheight, width: view.frame.width, height: view.frame.height-navheight)
        
      
        
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame:frame, pageMenuOptions: parameters)
        
        
        pageMenu!.delegate = self
        
        
       /** pageMenu!.view.subviews
            .map { $0 as? UIScrollView }
            .forEach { $0?.isScrollEnabled = false }
        **/
        
        
        self.addChildViewController(self.pageMenu!)
        self.view.addSubview(pageMenu!.view)
        self.pageMenu?.didMove(toParentViewController: self)
        
        
        
        
        
        
    }
    
    func requestWillBegin() {
        
        // self.refreshControl.beginRefreshing()
        self.linearBar.startAnimation()
        
    }
    func requestDidTerminateWithError(_ error: NSError?) {
        print(error ?? "falied")
        self.linearBar.stopAnimation();
        setPageMenuOfline();
        
    }
    func requestDidCompleteWithResponse(_ response: JSON) {
         print("response : \(response) ")
         var  statusCode = response["ecoachlabs"]["status"].stringValue;
        if statusCode == "201" {
        
             AppConfig.setcompany_categories(response)
            
            
       
            
            
            
        
        }
        
       
        
         self.linearBar.stopAnimation()
        setPageMenuOfline();
        
        
        
        
    }
    
    
    func getCategories() {
        var parameters = [String:AnyObject]()
        
        parameters["fetch_public_info"] = "1" as AnyObject?
        parameters["scope"] = "company_categories" as AnyObject?
        //parameters["filter"] = "" as AnyObject?
        
        
        APIRequest.getCompanyCategories(withParameters: parameters, andRegisterRequestDelegate: self)
    }
    
    func configureLinearProgressBar(){
        
        linearBar.backgroundColor = UIColor(red:0.68, green:0.81, blue:0.72, alpha:1.0)
        linearBar.progressBarColor = UIColor(hue: 0.5583, saturation: 1, brightness: 0.86, alpha: 1.0)
        linearBar.heightForLinearBar = 1
        navBar.addSubview(linearBar)
      //  self.navigationController!.view.addSubview(linearBar)
        //self.view.addSubview(linearBar)
        
    }

    

}
