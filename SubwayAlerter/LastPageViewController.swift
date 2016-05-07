import UIKit

class LastPageViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBOutlet var fastExitLabel: UILabel!
    @IBOutlet var infoNextTopCon: NSLayoutConstraint!
    
    @IBOutlet var bottomBarCon: NSLayoutConstraint!
    
    @IBOutlet var completeBtnOutlet: UIBarButtonItem!
    @IBAction func completeBtn(sender: AnyObject) {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBOutlet var viewAllRouteBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    @IBAction func cancelBtnAct(sender: AnyObject) {
        let alert = UIAlertController(title: "현재 경로를 취소하시겠습니까?", message: nil, preferredStyle: .ActionSheet)
        let okAction = UIAlertAction(title: "예", style: .Default){ (_) in
            
            
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)//페이지 닫기
        }
        let cancelAction = UIAlertAction(title: "아니오", style: .Cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelNotification(sender: AnyObject) {
        
        
    }
    
    
    @IBOutlet var returnTransferBtn: UIButton!
    @IBAction func returnTransfer(sender: AnyObject) {
        
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
        
        pickerView.hidden = true
        tabBar.hidden = true
        returnTransferBtn.hidden = true
        returnTransferBtn.enabled = false
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
        
    }
    
    
    
    @IBOutlet var transferInfo: UILabel!
    
    @IBOutlet var transferBtn1: UIButton!
    @IBAction func transferBtnAct1(sender: AnyObject) {
        
        
        
        
    }
    
    @IBOutlet var transferBtn2: UIButton!
    @IBAction func transferBtnAct2(sender: AnyObject) {
        
        
        
    }
    
    @IBOutlet var transferBtn3: UIButton!
    @IBAction func transferBtnAct3(sender: AnyObject) {
        
        
        
    }
    
    
    @IBOutlet var infoNextST: UILabel!
    @IBOutlet var countTimeAct: UILabel!
    
    @IBOutlet var finishTime: UILabel!
    
    
    
    
    
    
    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet var tabBar: UIToolbar!
    
    @IBAction func doneBtn(sender: AnyObject) {
        
        pickerView.hidden = true
        tabBar.hidden = true
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return ""
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    
}