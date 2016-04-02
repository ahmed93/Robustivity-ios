//
//  DirectoryAdapter.swift
//  Robustivity
//
//  Created by MacBook Pro on 3/28/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import UIKit

class DirectoryAdapter: BaseTableAdapter {
    
    
    override init(viewController: UIViewController, tableView: UITableView, registerCellWithNib name: String, withIdentifier identifier: String) {
        super.init(viewController: viewController, tableView: tableView, registerCellWithNib: name, withIdentifier: identifier)
        
        // any extra stuff to be done
    }
    
    
    func fetchItems() {
        if tableItems == nil {
            tableItems = ListModel()
        }
        tableItems.addObject([["name":"Ahmed Abousafy","position":"Account Manager","imagename":"Stroke 751 + Stroke 752"],["name":"Islam Abdelraouf","position":"Project Manager","imagename":"Stroke 751 + Stroke 752"]])
        tableItems.addObject([["name":"Ahmed Abousafy","position":"Account Manager","imagename":"Stroke 751 + Stroke 752"],["name":"Islam Abdelraouf","position":"Project Manager","imagename":"Stroke 751 + Stroke 752"],["name":"Ahmed Abousafy","position":"Account Manager","imagename":"Stroke 751 + Stroke 752"],["name":"Islam Abdelraouf","position":"Project Manager","imagename":"Stroke 751 + Stroke 752"]])
     
        tableView.reloadData()
    }
    
    func resizeImage(image:UIImage, toTheSize size:CGSize)->UIImage{
        
        
        let scale = CGFloat(max(size.width/image.size.width,
            size.height/image.size.height))
        let width:CGFloat  = image.size.width * scale
        let height:CGFloat = image.size.height * scale;
        
        let rr:CGRect = CGRectMake( 0, 0, width, height);
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        image.drawInRect(rr)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return newImage
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableItems.count
    }
   func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0
        {return "  In Office"}
        if section == 1{
        return "  Out of Office"}
        else{
        return ""
        }
    }
    
    /*func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50; // space b/w cells
    }*/
    
    

     func tableView(tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView! {
        
        
        let label : UILabel = UILabel()
        if section == 0{
            label.text = "  In Office"
            label.font = UIFont.boldSystemFontOfSize(20)
            label.textColor = Theme.greenColor()
        } else if section == 1{
            
            label.text = "  Out of Office"
            label.font = UIFont.boldSystemFontOfSize(20)
            label.textColor = Theme.lighterBlackColor()
        }
        return label
    }
   
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableItems.objectAtIndex(section) as! NSArray).count
    }
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0;
    }
    
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func configure(cell: UITableViewCell, indexPath: NSIndexPath) {
        let _cell = cell as? DirectoryCell
        
       // _cell?.userName.text = "Section \(indexPath.section) Row \(indexPath.row)"
         let w =  tableItems.objectAtIndex(indexPath.section)
        let x = w?.objectAtIndex(indexPath.row)?.objectForKey("name")
        let y = w?.objectAtIndex(indexPath.row)?.objectForKey("position")
        let z = w?.objectAtIndex(indexPath.row)?.objectForKey("imagename")
        _cell?.userName.text = x as! String
        _cell?.userTitle.text = y as! String
        
        //let imageName = "Stroke 751 + Stroke 752"
        let image = UIImage(named: z as! String)
        let newImage = resizeImage(image!, toTheSize: CGSizeMake(70, 70))
        var cellImageLayer: CALayer?  = _cell?.userImage.layer
        cellImageLayer!.cornerRadius = cellImageLayer!.frame.size.width / 2
        cellImageLayer!.masksToBounds = true
        _cell?.userImage.image = newImage
        
     }
    
    
    
    /*func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {cell.contentView.backgroundColor=UIColor.clearColor()
        
        var whiteRoundedCornerView:UIView!
        whiteRoundedCornerView=UIView(frame: CGRectMake(5,10,400,70))
        whiteRoundedCornerView.backgroundColor=UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        whiteRoundedCornerView.layer.masksToBounds=false
        
        whiteRoundedCornerView.layer.shadowOpacity = 1.55;
        
        
        
        whiteRoundedCornerView.layer.shadowOffset = CGSizeMake(1, 0);
        whiteRoundedCornerView.layer.shadowColor=UIColor(red: 53/255.0, green: 143/255.0, blue: 185/255.0, alpha: 1.0).CGColor
        
        
        
        whiteRoundedCornerView.layer.cornerRadius=3.0
        whiteRoundedCornerView.layer.shadowOffset=CGSizeMake(-1, -1)
        whiteRoundedCornerView.layer.shadowOpacity=0.5
        cell.contentView.addSubview(whiteRoundedCornerView)
        cell.contentView.sendSubviewToBack(whiteRoundedCornerView)
        
        
    }*/

    
    
}
