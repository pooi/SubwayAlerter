import UIKit
import CoreLocation

class LocationViewController : UIViewController,CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var lat : String = ""
    var lng : String = ""
    
    var mainRow : Array<nealStation> = []
    
    @IBOutlet var underView: UIView!
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
    
    @IBOutlet var refresh: UIButton!
    @IBAction func refreshBtn(sender: AnyObject) {
        
        
        self.lat = ""
        self.lng = ""
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        //self.tableView.reloadData()
     
        
        
        
    }
    
    
    @IBAction func closeBtn(sender: AnyObject) {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)//페이지 닫기
        
    }
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        underView.bounds.size.height = settingFontSize(9)
        refresh.setFontSize(settingFontSize(0))
        
        refresh.hidden = true
        
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
        
        self.lat = ""
        self.lng = ""
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.spinner.startAnimating()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
            
        if(self.mainRow.count != 0){
            self.tableView.reloadData()
        }
            
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
            
        if(self.lng != "" && self.lat != ""){
            
            self.mainRow = returnLocationRow()
            
            if(self.mainRow.count != 0){
                self.tableView.reloadData()
                //self.refresh.hidden = false
            }
            
        }else{
            
            let alert = UIAlertController(title: "오류", message: "현재 위치 정보를 가져오지 못하였습니다.", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "확인", style: .Cancel){(_) in
                
                self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)//페이지 닫기
                
                
            }
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
            
            
        
        self.spinner.stopAnimating()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return mainRow.count
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return settingFontSize(9)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell;
        
        cell.textLabel?.text = "#\(indexPath.row+1) " + self.mainRow[indexPath.row].statnNm
        cell.detailTextLabel?.text = self.mainRow[indexPath.row].subwayNm
        
        cell.textLabel?.setFontSize(settingFontSize(0))
        cell.detailTextLabel?.setFontSize(settingFontSize(0))
        cell.detailTextLabel?.textColor = returnLineColor(SubwayId: self.mainRow[indexPath.row].subwayId)
        
        return cell
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if (segue.identifier == "moveToFinish") {
            let index = self.tableView.indexPathForCell(sender as! UITableViewCell)
            
            (segue.destinationViewController as? FinishSTViewController)?.startStation = self.mainRow[index!.row].statnNm
            
        }
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        
        let location = locations.last
        
        //let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        //let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.lat = String(location!.coordinate.latitude)
        self.lng = String(location!.coordinate.longitude)
        //print("r")
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        let alert = UIAlertController(title: "오류", message: "위치정보를 가져오지 못하였습니다.", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "확인", style: .Cancel){(_) in
            
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)//페이지 닫기
            
            
        }
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    
    func returnLocationRow() -> Array<nealStation>{
        
        self.mainRow.removeAll()
        
        var nealTemp : Array<nealStation> = []
        
        let wtm = getWTM()//wgs84 -> WTM convert
        
        let baseUrl = "http://swopenapi.seoul.go.kr/api/subway/\(KEY)/json/nearBy/0/50/\(wtm.0)/\(wtm.1)"
        let escapedText = baseUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        let apiURI = NSURL(string: escapedText!)
        let apidata : NSData? = NSData(contentsOfURL: apiURI!)
        
        do{
            
            let apiDictionary = try NSJSONSerialization.JSONObjectWithData(apidata!, options: []) as! NSDictionary
            
            if(apiDictionary["stationList"] as? NSArray != nil){
                
                let sub = apiDictionary["stationList"] as! NSArray
                //let sub2 = sub["row"] as! NSArray
                
                for row in sub{
                    
                    nealTemp.append(nealStation(
                        statnNm: row["statnNm"] as! String,
                        subwayId: row["subwayId"] as! String,
                        subwayNm: row["subwayNm"] as! String,
                        ord: Int(row["ord"] as! String)!
                        ))
                }
                
                nealTemp = nealTemp.sort({$0.ord < $1.ord})
                
            }else{
                
                let alert = UIAlertController(title: "오류", message: "목록을 가져오는데 실패하였습니다.(1)", preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "확인", style: .Cancel, handler: nil)
                alert.addAction(cancelAction)
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
            
            
        }catch{
            
            let alert = UIAlertController(title: "오류", message: "목록을 가져오는데 실패하였습니다.(2)", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "확인", style: .Cancel, handler: nil)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        return nealTemp
    }
    
    func getWTM() -> (String, String){
        
        var x : Double = 0
        var y : Double = 0
        
        let baseUrl = "http://apis.daum.net/maps/transcoord?apikey=874c220047db1145942dd82def9e2f8f&x=\(self.lng)&y=\(self.lat)&toCoord=WTM&fromCoord=WGS84&output=json"
        let escapedText = baseUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        let apiURI = NSURL(string: escapedText!)
        let apidata : NSData? = NSData(contentsOfURL: apiURI!)
        
        do{
            
            let apiDictionary = try NSJSONSerialization.JSONObjectWithData(apidata!, options: []) as? NSDictionary
            
            if(apiDictionary != nil){
                
                let sub = apiDictionary!
                
                x = sub["x"] as! Double
                y = sub["y"] as! Double
                
            }else{
                
                let alert = UIAlertController(title: "오류", message: "좌표정보를 가져오는데 실패하였습니다.(1)", preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "확인", style: .Cancel, handler: nil)
                alert.addAction(cancelAction)
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
            
            
            
        }catch{
            
            let alert = UIAlertController(title: "오류", message: "좌표정보를 가져오는데 실패하였습니다.(2)", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "확인", style: .Cancel, handler: nil)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        return (String(x), String(y))
    }
    
}