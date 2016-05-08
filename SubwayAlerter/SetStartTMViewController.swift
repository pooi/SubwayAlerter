import UIKit

class SetStartTMViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var start : String = "" //segue를 통해 가져옴
    var finish : String = ""  //segue를 통해 가져옴
    
    
    @IBOutlet var spinnerView: UIView!
    
    @IBOutlet var bottomBarCon: NSLayoutConstraint!
    
    @IBOutlet var spinnerCon: NSLayoutConstraint!
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var tableView: UITableView!
    
    
    @IBOutlet var informView: UIView!
    
    @IBOutlet var subject1: UILabel!
    @IBOutlet var subject2: UILabel!
    @IBOutlet var subject3: UILabel!
    
    @IBOutlet var transferTimeLabel: UILabel!
    @IBOutlet var viaStationLabel: UILabel!
    @IBOutlet var transferNumLabel: UILabel!
    
    @IBOutlet var setTimeTitle: UILabel!
    
    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet var toolBar: UIToolbar!
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    
    @IBAction func toolbarDone(sender: AnyObject) {
        pickerView.hidden = true
        toolBar.hidden = true
    }
    
    
    //*****************************테이블셀*****************************//
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentOffset.y<=0) {
            scrollView.contentOffset = CGPointZero;
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! RouteTableCell
        
        return cell
    }
    
    
    
    //*****************************피커뷰*****************************//
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        
        pickerView.hidden = true
        toolBar.hidden = true
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
        
        super.viewDidLoad()
    }
    
    
    @IBAction func standardBtn(sender: AnyObject) {
        
        
    }
    
    
    @IBOutlet var startTimeText1: UIButton!
    @IBAction func startTime1(sender: AnyObject) {
        
        
        
    }
    
    @IBOutlet var startTimeText2: UIButton!
    @IBAction func startTime2(sender: AnyObject) {
        
        
        
    }
    
    @IBOutlet var startTimeText3: UIButton!
    @IBAction func startTime3(sender: AnyObject) {
        
        
        
    }
    
    @IBOutlet var startTimeText4: UIButton!
    @IBAction func startTimeText4(sender: AnyObject) {
        
        
        
    }
    
    
    
    @IBOutlet var standardBtnText: UIButton!
    @IBOutlet var viewAllRouteText: UIButton!
    
    
    @IBOutlet var finishTime: UILabel!
    
    @IBOutlet var nextBtn: UIBarButtonItem!
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    
    
    
}