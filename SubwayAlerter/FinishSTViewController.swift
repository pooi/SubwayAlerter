import UIKit

class FinishSTViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet var finishTableView: UITableView!
    
    @IBOutlet var InfoLabel: UILabel!
    
    @IBOutlet var nextBtn: UIBarButtonItem!
    
    @IBOutlet var searchBar: UISearchBar!
    
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var bottomBarCon: NSLayoutConstraint!
    
    
    var subwayNames : Array<StationNm> = []
    var filteredSubway  : Array<StationNm> = []
    var startStation : String = ""
    var finishStation : String = ""
    
    
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
        
        self.filteredSubway = self.subwayNames
        InfoLabel.text = "현재 설정된 도착역 : 없음"
        nextBtn.enabled = false
        searchBar.placeholder = "도착역 검색(ex.서울 또는 ㅅㅇ)"
        
        self.subwayNames = returnLineList(SubwayId: "")
        
        
        self.subwayNames = self.subwayNames.sort({$0.name <= $1.name})
        
        self.filteredSubway = self.subwayNames
        
        
        
        self.finishTableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.filteredSubway.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = finishTableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as UITableViewCell
        
        var friend : StationNm
        
        friend = self.filteredSubway[indexPath.row]
        
        cell.textLabel?.text = friend.name + "역"
        
        cell.detailTextLabel?.text = returnLineName(SubwayId : friend.line)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        searchBar.resignFirstResponder()
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var friend : StationNm
        
        friend = self.filteredSubway[indexPath.row]
        finishStation = friend.name
        InfoLabel.text = "현재 설정된 도착역 : " + finishStation
        
        if(self.startStation == self.finishStation){
            let alert = UIAlertController(title: "오류", message: "출발역과 도착역이 같습니다.\n도착역을 다시 설정해주세요.", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "확인", style: .Cancel, handler: nil)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
            InfoLabel.text = "현재 설정된 도착역 : 없음"
        }else{
            nextBtn.enabled = true
        }
        
        
        
        
        
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(searchText.isEmpty == true){
            self.filteredSubway = self.subwayNames
        }else{
            filteredSubway.removeAll(keepCapacity: false)
            let options = NSStringCompareOptions.DiacriticInsensitiveSearch
            
            filteredSubway = subwayNames.filter {
                $0.code.rangeOfString(searchBar.text!/*searchPredicate as! String*/, options: options) != nil
            }
        }
        
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
        if (segue.identifier == "moveToSetTm") {
            
            (segue.destinationViewController as? SetStartTMViewController)?.start = self.startStation
            (segue.destinationViewController as? SetStartTMViewController)?.finish = self.finishStation
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}