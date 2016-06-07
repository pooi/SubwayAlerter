import UIKit

class FavoriteAddListViewController2 : UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    var fvo = FavoriteVO()//사용자 함수를 위해
    
    var subwayNames : Array<StationNm> = []
    var filteredSubway  : Array<StationNm> = []
    var startStation : String = ""
    var finishStation : String = ""
    
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func closeBtn(sender: AnyObject) {
        
        searchBar.resignFirstResponder()
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        
        
        for parent in self.searchBar.subviews{
            for childView in parent.subviews{
                if(childView is UIImageView){
                    childView.removeFromSuperview()
                }
            }
        }
        
        self.tableView.dataSource = self
        searchBar.delegate = self
        searchBar.barTintColor = UIColor(red:  233/255.0, green: 97/255.0, blue: 97/255.0, alpha: 0.0)
        searchBar.placeholder = "도착역 검색(ex.서울 또는 ㅅㅇ)"
        
        //self.subwayNames = Array()
        self.filteredSubway = self.subwayNames
        searchBar.placeholder = "도착역 검색(ex.서울 또는 ㅅㅇ)"
        
        
        
        
        self.tableView.reloadData()
    }
    
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
        searchBar.resignFirstResponder()
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var friend : StationNm
        
        friend = self.filteredSubway[indexPath.row]
        finishStation = friend.name
        
        
        if(self.startStation == self.finishStation){
            
            let alert = UIAlertController(title: "오류", message: "출발역과 도착역이 같습니다.\n도착역을 다시 설정해주세요.", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "확인", style: .Cancel, handler: nil)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }else{
            //fvo에 저장하기
            
            let alert = UIAlertController(title: "저장하시겠습니까?", message: "출발역 : \(self.startStation)역\n도착역 : \(self.finishStation)역", preferredStyle: .ActionSheet)
            let okAction = UIAlertAction(title: "저장", style: UIAlertActionStyle.Default){ (_) in
                
                var list : Array<String> = self.fvo.config.objectForKey("favoriteArray") as! Array<String>
                list.append(self.startStation + "," + self.finishStation)
                
                self.fvo.config.setObject(list, forKey: "favoriteArray")
                
                self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            }
            alert.addAction(okAction)
            let cancelAction = UIAlertAction(title: "취소", style: .Cancel){ (_) in
                
            }
            
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
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
    
}