import UIKit

class FinishSTViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet var finishTableView: UITableView!
    
    @IBOutlet var InfoLabel: UILabel!
    
    @IBOutlet var nextBtn: UIBarButtonItem!
    
    @IBOutlet var searchBar: UISearchBar!
    
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var bottomBarCon: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        
        for parent in self.searchBar.subviews{
            for childView in parent.subviews{
                if(childView is UIImageView){
                    childView.removeFromSuperview()
                }
            }
        }
        
        self.finishTableView.dataSource = self
        searchBar.delegate = self
        searchBar.barTintColor = UIColor(red:  233/255.0, green: 97/255.0, blue: 97/255.0, alpha: 0.0)
        searchBar.placeholder = "도착역 검색(ex.서울 또는 ㅅㅇ)"
        
        self.finishTableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = finishTableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as UITableViewCell
        
        
        return cell
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.finishTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        var cancelButton: UIButton
        let topView: UIView = searchBar.subviews[0] as UIView
        for subView in topView.subviews {
            if subView.isKindOfClass(NSClassFromString("UINavigationButton")!) {
                cancelButton = subView as! UIButton
                cancelButton.setTitle("닫기", forState: UIControlState.Normal)
            }
        }
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = false
        return true
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}