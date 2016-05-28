import UIKit


class FavoriteViewController : UITableViewController {
    
    var fvo = FavoriteVO()//사용자 함수를 위해
    
    @IBOutlet var addAlertBtn: UIButton!
    @IBOutlet var addListBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        
        addAlertBtn.setFontSize(settingFontSize(1))
        addListBtn.setFontSize(settingFontSize(1))
        
        //여기부터 네비게이션바 관련
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
        //여기까지 네비게이션바 관련
        
        
        
        closeBtnTitle.title = "닫기"
        editBtnTitle.title = "편집"
        
        
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    @IBOutlet var closeBtnTitle: UIBarButtonItem!
    @IBAction func closeBtn(sender: AnyObject) {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    @IBOutlet var editBtnTitle: UIBarButtonItem!
    @IBAction func editBtn(sender: AnyObject) {
        
        
    }
    
    
    @IBAction func addFavoriteBtn(sender: AnyObject) {
        
        
        
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return settingFontSize(9)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        
        return cell
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
}