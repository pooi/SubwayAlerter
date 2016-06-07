import UIKit

class SettingViewController : UITableViewController {
    
    var fvo = FavoriteVO()//사용자 함수를 위해
    
    @IBOutlet var setStartCellLabel: UILabel!
    @IBOutlet var addTransTimeLabel: UILabel!
    @IBOutlet var setAlertTimeLabel: UILabel!
    @IBOutlet var startPageYNLabel: UILabel!
    @IBOutlet var alertYNLabel: UILabel!
    @IBOutlet var informationLabel: UILabel!
    
    // 환승역 가중치 설정 도움말
    @IBOutlet var addTransTimeHelp: UIButton!
    @IBAction func addTransTimeHelpAct(sender: AnyObject) {
        
        let alert = UIAlertController(title: "도움말", message: "환승역에 도착 후 예상 이동시간을 의미합니다. 환승역에 예상 도착 시간과 가중치를 합산해서 다음 역의 시간표를 가져옵니다.", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "확인", style: .Cancel, handler: nil)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    // 알람 시간 설정 도움말
    @IBOutlet var setAlertTimeHelp: UIButton!
    @IBAction func setAlertTimeHelpAct(sender: AnyObject) {
        
        let alert = UIAlertController(title: "도움말", message: "예상 도착시간 몇 분 또는 몇 초 전에 알림을 받을지 결정합니다.", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "확인", style: .Cancel, handler: nil)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        //네비게이션바 색상변경
        let navBarColor = navigationController!.navigationBar
        navBarColor.barTintColor = settingColor[0]//UIColor(red:  230/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 0.0)
        navBarColor.tintColor = UIColor.whiteColor()
        navBarColor.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navBarColor.translucent = false
        
        addTransTimeHelp.setFontSize(settingFontSize(1))
        setAlertTimeHelp.setFontSize(settingFontSize(1))
        
        addTransTimeLabel.setFontSize(settingFontSize(0))
        setAlertTimeLabel.setFontSize(settingFontSize(0))
        alertYNLabel.setFontSize(settingFontSize(0))
        informationLabel.setFontSize(settingFontSize(0))
        
        
        
        
        
        addTrans.selectedSegmentIndex = self.fvo.config.objectForKey("addTransTime") as! Int
        setAlertTime.selectedSegmentIndex = self.fvo.config.objectForKey("setAlertTime") as! Int
    }
    
    override func viewWillAppear(animated: Bool) {
        var switchBool : Bool = self.fvo.config.objectForKey("SetAlert") as! Bool
        AlertSwitch.setOn(switchBool, animated: false)
    }
    
    @IBAction func closeBtn(sender: AnyObject) {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // 환승 가중치 설정
    @IBOutlet var addTrans: UISegmentedControl!
    @IBAction func addTransBtn(sender: AnyObject) {
        
        switch addTrans.selectedSegmentIndex
        {
        case 0:
            self.fvo.config.setObject(0, forKey: "addTransTime")
            break;
        case 1:
            self.fvo.config.setObject(1, forKey: "addTransTime")
            break;
        case 2:
            self.fvo.config.setObject(2, forKey: "addTransTime")
            break;
        case 3:
            self.fvo.config.setObject(3, forKey: "addTransTime")
            break;
        default:
            break; 
        }
        
    }
    
    // 알람 시간 설정
    @IBOutlet var setAlertTime: UISegmentedControl!
    @IBAction func setAlertTimeBtn(sender: AnyObject) {
        
        switch setAlertTime.selectedSegmentIndex
        {
        case 0:
            self.fvo.config.setObject(0, forKey: "setAlertTime")
            break;
        case 1:
            self.fvo.config.setObject(1, forKey: "setAlertTime")
            break;
        case 2:
            self.fvo.config.setObject(2, forKey: "setAlertTime")
            break;
        case 3:
            self.fvo.config.setObject(3, forKey: "setAlertTime")
            break;
        default:
            break;
        }
        
    }
    
    // 알림 기능 on off
    @IBOutlet var AlertSwitch: UISwitch!
    @IBAction func AlertSwitchBtn(sender: AnyObject) {
        
        if(AlertSwitch.on == false){
            
            let switchBool : Bool = false
            self.fvo.config.setObject(switchBool, forKey: "SetAlert")
            AlertSwitch.setOn(switchBool, animated: true)
        }else{
            let switchBool : Bool = true
            self.fvo.config.setObject(switchBool, forKey: "SetAlert")
            AlertSwitch.setOn(switchBool, animated: true)
            
        }
    }
    
}