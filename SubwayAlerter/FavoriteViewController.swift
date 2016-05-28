import UIKit


class FavoriteViewController : UITableViewController {
    
    var fvo = FavoriteVO()//사용자 함수를 위해
    
    @IBOutlet var addAlertBtn: UIButton!
    @IBOutlet var addListBtn: UIButton!
    
    
    
    override func viewDidLoad() {
//        var tabFrame : CGRect = (self.tabBarController?.tabBar.frame)!
//        tabFrame.size.height = settingFontSize(6)//+10
//        tabFrame.origin.y = self.view.frame.size.height - tabFrame.size.height + 1
//        self.tabBarController!.tabBar.frame = tabFrame
        
        addAlertBtn.setFontSize(settingFontSize(1))
        addListBtn.setFontSize(settingFontSize(1))
        
        
        //self.tabBarController?.tabBar.hidden = true
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
        
        
        
        closeBtnTitle.title = "닫기"
        editBtnTitle.title = "편집"
        
        
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
//        self.tabBarController?.tabBar.hidden = false
    }
    
    @IBOutlet var closeBtnTitle: UIBarButtonItem!
    @IBAction func closeBtn(sender: AnyObject) {
        
        if(closeBtnTitle.title == "닫기"){
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        }else{
            fvo.config.removeObjectForKey("favoriteArray")
    
            let list : Array<String> = []
            self.fvo.config.setObject(list, forKey: "favoriteArray")
    
            self.tableView.reloadData()
        }
        
    }
    
    @IBOutlet var editBtnTitle: UIBarButtonItem!
    @IBAction func editBtn(sender: AnyObject) {
        
        //self.editing = !self.editing
        
        if(self.editing.boolValue == true && editBtnTitle.title == "편집"){
            self.editing = !self.editing
            editBtnTitle.title = "완료"
            closeBtnTitle.title = "전체삭제"
            self.editing = !self.editing
        }else if(self.editing.boolValue == true && editBtnTitle.title == "완료"){
            self.editing = !self.editing
            editBtnTitle.title = "편집"
            closeBtnTitle.title = "닫기"
        }else if(self.editing.boolValue == false && editBtnTitle.title == "편집"){
            self.editing = !self.editing
            editBtnTitle.title = "완료"
            closeBtnTitle.title = "전체삭제"
        }
        
    }
    
    
    @IBAction func addFavoriteBtn(sender: AnyObject) {
        
        
        let alert = UIAlertController(title: nil, message: "즐겨찾기 추가", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "출발역 입력"
        })
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "도착역 입력"
        })
        
        alert.addAction(UIAlertAction(title: "취소", style: .Default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "추가", style: .Default, handler: { (action) -> Void in

            let startField = alert.textFields![0] as UITextField
            let finishField = alert.textFields![1] as UITextField
            //let title : String = startField.text! + "역 -> " + finishField.text! + "역"
            let startStation : String = removeString(Name: startField.text!)
            let finishStation : String = removeString(Name: finishField.text!)
            
            
            
            
            var list : Array<String> = self.fvo.config.objectForKey("favoriteArray") as! Array<String>
            list.append(startStation + "," + finishStation)
            
            self.fvo.config.setObject(list, forKey: "favoriteArray")
            
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
        
        
        let list : Array<String> = self.fvo.config.objectForKey("favoriteArray") as! Array<String>
        
        return list.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        let list : Array<String> = self.fvo.config.objectForKey("favoriteArray") as! Array<String>
        
        
        
        cell.textLabel?.text = convertTitle(Title: list[indexPath.row])
        
        cell.textLabel?.setFontSize(settingFontSize(0))
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return settingFontSize(9)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        

        
        //var alert2: UIAlertView = UIAlertView(title: "Title", message: "Please wait...", delegate: nil, cancelButtonTitle: "Cancel");
//        let alert: UIAlertView = UIAlertView(title: "잠시만 기다려주세요.", message: nil, delegate: nil, cancelButtonTitle: "")
//        
//        
//        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(50, 10, 37, 37)) as UIActivityIndicatorView
//        loadingIndicator.center = self.view.center;
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
//        loadingIndicator.startAnimating();
//        
//        alert.setValue(loadingIndicator, forKey: "accessoryView")
//        loadingIndicator.startAnimating()
//        
//        alert.show();
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
            switch editingStyle {
            case .Delete:
                
                var list : Array<String> = self.fvo.config.objectForKey("favoriteArray") as! Array<String>
                list.removeAtIndex(indexPath.row)
                self.fvo.config.setObject(list, forKey: "favoriteArray")
                self.tableView.reloadData()
                
            default:
                return
            }
        
    }
    
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true}
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
            var list : Array<String> = self.fvo.config.objectForKey("favoriteArray") as! Array<String>
            let itemToMove = list[fromIndexPath.row]
            list.removeAtIndex(fromIndexPath.row)
            list.insert(itemToMove, atIndex: toIndexPath.row)
            
            self.fvo.config.setObject(list, forKey: "favoriteArray")
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "moveToSet") {
            let path = self.tableView.indexPathForCell(sender as! UITableViewCell)
            
            let list : Array<String> = self.fvo.config.objectForKey("favoriteArray") as! Array<String>
            
            let (start,finish) = removeComma(Name: list[path!.row])
            //let bottom = UIStoryboardSegue.
//            let bottomBar = segue.destinationViewController as! SetStartTMViewController
//            bottomBar.hidesBottomBarWhenPushed = true
            
            
            (segue.destinationViewController as? SetStartTMViewController)?.start = start
            (segue.destinationViewController as? SetStartTMViewController)?.finish = finish
            
            
        }
    }

}