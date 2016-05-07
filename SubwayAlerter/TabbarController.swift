import UIKit

class TabbarController : UITabBarController {
    
    
    override func viewDidLoad() {
        
        UITabBar.appearance().barTintColor = UIColor(red:  20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 1.0)
        
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        self.hidesBottomBarWhenPushed = true
        
    }
    
}