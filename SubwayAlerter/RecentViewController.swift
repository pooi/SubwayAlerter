import UIKit

class RecentViewController : UITableViewController {
    
    var fvo = FavoriteVO()//사용자 함수를 위해
    
    var list : Array<String> = []
    
    override func viewDidLoad() {
        
        for parent in self.navigationController!.navigationBar.subviews{
            for childView in parent.subviews{
                if(childView is UIImageView){
                    childView.removeFromSuperview()
                }
            }
        }
        //네비게이션바 색상변경
        let navBarColor = navigationController!.navigationBar
        navBarColor.barTintColor = UIColor(red:  230/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 0.0)
        navBarColor.tintColor = UIColor.whiteColor()
        navBarColor.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        //let list : Array<String> = self.fvo.config.objectForKey("RecentArray") as! Array<String>
        
        self.list = self.fvo.config.objectForKey("RecentArray") as! Array<String>
        let temp = list
        
        self.list.removeAll()
        
        for i in 0..<temp.count{
            
            list.append(temp[temp.count-1-i])
            
        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
//        self.tabBarController?.tabBar.hidden = false
    }
    
    @IBAction func closeBtn(sender: AnyObject) {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func deleteBtn(sender: AnyObject) {
        
        let alert = UIAlertController(title: "확인", message: "최근 경로를 전부 삭제하시겠습니까?", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "취소", style: .Default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "확인", style: .Default, handler: { (action) -> Void in
            
            //fvo.config.removeObjectForKey("RecentArray")
            
            let list2 : Array<String> = []
            self.fvo.config.setObject(list2, forKey: "RecentArray")
            
            self.list = self.fvo.config.objectForKey("RecentArray") as! Array<String>
            
            self.tableView.reloadData()
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)

        
        
        
    }
    
    
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // 1
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        //let list : Array<String> = self.fvo.config.objectForKey("RecentArray") as! Array<String>
        
        return self.list.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        //let list : Array<String> = self.fvo.config.objectForKey("RecentArray") as! Array<String>
        
        
        
        cell.textLabel?.text = convertTitle(Title: self.list[indexPath.row])
        
        cell.textLabel?.setFontSize(settingFontSize(0))
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return settingFontSize(9)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "moveToSet") {
            let path = self.tableView.indexPathForCell(sender as! UITableViewCell)
            
            //let list : Array<String> = self.fvo.config.objectForKey("favoriteArray") as! Array<String>
            
            let (start,finish) = removeComma(Name: self.list[path!.row])
            
//            let bottomBar = segue.destinationViewController as! SetStartTMViewController
//            bottomBar.hidesBottomBarWhenPushed = true
            
            (segue.destinationViewController as? SetStartTMViewController)?.start = start
            (segue.destinationViewController as? SetStartTMViewController)?.finish = finish
            
            
        }
    }

}