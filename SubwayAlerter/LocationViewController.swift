import UIKit
import CoreLocation

class LocationViewController : UIViewController,CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var underView: UIView!
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
    
    @IBOutlet var refresh: UIButton!
    @IBAction func refreshBtn(sender: AnyObject) {
        
        
        
        
    }
    
    
    @IBAction func closeBtn(sender: AnyObject) {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)//페이지 닫기
        
    }
    
    override func viewDidLoad() {
        
        //네비게이션바 관련
        for parent in self.navigationController!.navigationBar.subviews{
            for childView in parent.subviews{
                if(childView is UIImageView){
                    childView.removeFromSuperview()
                }
            }
        }
        //네비게이션바 색상변경
        let navBarColor = navigationController!.navigationBar
        navBarColor.barTintColor = UIColor(red:  230/255.0, green: 70/255.0, blue: 70/255.0, alpha: 0.0)
        navBarColor.tintColor = UIColor.whiteColor()
        navBarColor.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        // 여기까지 네비게이션바 관련
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell;
        
        
        return cell
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
    }
    
        
}