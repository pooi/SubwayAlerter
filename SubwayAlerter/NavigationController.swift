import UIKit

class NavigationController : UINavigationController{
    //상태바 텍스트 하얀색으로 변경하는 함수
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    var cellIndex : Int = 0
    
    override func viewDidLoad() {
        
    }
}