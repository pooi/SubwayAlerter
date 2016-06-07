import UIKit

class FavoriteAddListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    var keyboradEnable : Bool = false
    var subwayNames : Array<StationNm> = []
    var filteredSubway  : Array<StationNm> = []
    var startStation : String = ""
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBAction func closeBtn(sender: AnyObject) {
        
        searchBar.resignFirstResponder()
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        self.tableView.dataSource = self
        searchBar.delegate = self
        searchBar.barTintColor = UIColor(red:  233/255.0, green: 97/255.0, blue: 97/255.0, alpha: 0.0)
        searchBar.placeholder = "출발역 검색(ex.서울 또는 ㅅㅇ)"
        
        
        for parent in self.searchBar.subviews{
            for childView in parent.subviews{
                if(childView is UIImageView){
                    childView.removeFromSuperview()
                }
            }
        }
        
        
        for parent in self.navigationController!.navigationBar.subviews{
            for childView in parent.subviews{
                if(childView is UIImageView){
                    childView.removeFromSuperview()
                }
            }
        }
        //네비게이션바 색상변경
        let navBarColor = navigationController!.navigationBar
        //        navBarColor.translucent = false
        //        navBarColor.barStyle = .Black
        navBarColor.barTintColor = UIColor(red:  230/255.0, green: 70/255.0, blue: 70/255.0, alpha: 0.0)
        navBarColor.tintColor = UIColor.whiteColor()
        navBarColor.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
        self.subwayNames = returnLineList(SubwayId: "")
        
        for i in 0..<self.subwayNames.count{
            self.subwayNames[i].code = self.subwayNames[i].name + self.subwayNames[i].name.hangul
        }
        
        self.subwayNames = self.subwayNames.sort({$0.name <= $1.name})
        
        self.filteredSubway = self.subwayNames
        
        
        
        self.tableView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        //nextBtn.title = "완료"
        //nextBtn.enabled = true
        
        if(searchText.isEmpty == true){
            self.filteredSubway = self.subwayNames
        }else{
            filteredSubway.removeAll(keepCapacity: false)
            let options = NSStringCompareOptions.DiacriticInsensitiveSearch
            
            filteredSubway = subwayNames.filter {
                $0.code.rangeOfString(searchBar.text!/*searchPredicate as! String*/, options: options) != nil
            }
        }
        
        
        self.tableView.reloadData()
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
                cancelButton.tintColor = UIColor.whiteColor()
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
    
    //---------------tabelView--------------------
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // 1
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.filteredSubway.count
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return settingFontSize(9)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        
        var friend : StationNm
        
        friend = self.filteredSubway[indexPath.row]
        
        cell.textLabel?.text = friend.name + "역"
        
        cell.textLabel?.setFontSize(settingFontSize(0))
        
        cell.detailTextLabel?.text = returnLineName(SubwayId : friend.line)
        
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //nextBtn.title = "다음"
        
        searchBar.resignFirstResponder()
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var friend : StationNm
        
        friend = self.filteredSubway[indexPath.row]
        self.startStation = friend.name
        //InfoLabel.text = "현재 설정된 출발역 : " + self.startStation
        
        //nextBtn.enabled = true
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "moveToFinish") {
            let index = self.tableView.indexPathForCell(sender as! UITableViewCell)
            var friend : StationNm
            
            friend = self.filteredSubway[index!.row]
            self.startStation = friend.name
            
            searchBar.resignFirstResponder()
            (segue.destinationViewController as? FavoriteAddListViewController2)?.startStation = self.startStation
            (segue.destinationViewController as? FavoriteAddListViewController2)?.subwayNames = self.subwayNames
        }
        
    }
    
}