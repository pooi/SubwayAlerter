import UIKit


class ViewControllerMain : UIViewController {
    
    var fvo = FavoriteVO()//사용자 함수를 위해
    
    // 상태바 흰색으로 바꿔주기 위한 함수
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBOutlet var mainHeightCon: NSLayoutConstraint!
    
    @IBOutlet var bottomBarCon: NSLayoutConstraint!
    
    @IBOutlet var trainImageCon: NSLayoutConstraint!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var mainImageView: UIView!
    @IBOutlet var mainTrainView: UIImageView!
    
    @IBOutlet var view0: UIView!
    @IBOutlet var view0Label: UILabel!
    
    
    
    
    
    override func viewDidAppear(animated: Bool) {
        //self.tableView.reloadData()
    }
        
    override func viewDidLoad() {
        
        self.mainHeightCon.constant = settingFontSize(12)
        
        view0Label.setFontSize(settingFontSize(7))
        self.trainImageCon.constant = settingFontSize(11)
        
        self.bottomBarCon.constant = settingFontSize(6)
        
        if(fvo.config.objectForKey("favoriteArray") == nil){
            let list : Array<String> = []
            self.fvo.config.setObject(list, forKey: "favoriteArray")
        }
        
        if(fvo.config.objectForKey("RecentArray") == nil){
            let list : Array<String> = []
            self.fvo.config.setObject(list, forKey: "RecentArray")
        }
        
        if(fvo.config.objectForKey("STpageView") == nil){
            let switchBool : Bool = false
            self.fvo.config.setObject(switchBool, forKey: "STpageView")
        }
        
        if(fvo.config.objectForKey("SetAlert") == nil){
            let switchBool : Bool = true
            self.fvo.config.setObject(switchBool, forKey: "SetAlert")
        }
        
        if(fvo.config.objectForKey("addTransTime") == nil){
            self.fvo.config.setObject(1, forKey: "addTransTime")
        }
        
        if(fvo.config.objectForKey("setAlertTime") == nil){
            self.fvo.config.setObject(0, forKey: "setAlertTime")
        }
        
        if(fvo.config.objectForKey("shortCut") == nil){
            
            var arr : Array<Array<String>> = []
            /*
             **[0] = 역이름
             **[1] = 호선ID
             **[2] = 상,하행선
             **[3] = 다음역 이름
             */
            
            if(UIScreen.mainScreen().bounds.size.width == 320.0 && UIScreen.mainScreen().bounds.size.height == 480.0){
                
                for _ in 0..<4{
                    arr.append(["","","",""])
                }
                
            }else{
                for _ in 0..<5{
                    arr.append(["","","",""])
                }
            }
            
            self.fvo.config.setObject(arr, forKey: "shortCut")
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
    }
    
}



