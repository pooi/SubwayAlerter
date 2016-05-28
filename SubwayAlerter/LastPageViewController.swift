import UIKit

class LastPageViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    var stimeMain : Int = 0 //타이머에서 사용
    var totaltimeMain : Int = 0
    
    var transferTimeSchedulCount : Int = 0
    var notiStartTm : String = ""
    var notiNextTm : Int = 0
    
    var timer = NSTimer()//타이머 관련
    
    var info : Array<SubwayInfo> = []//경로 분석 정보
    
    var setTransTimeBtnText1 : String = ""
    var setTransTimeBtnText2 : String = ""
    
    //알림 관련 변수
    var setAlertTime : Int = 0 //x분전 알림
    var setAlertMessage : String = ""//x분전 알림 문구
    
    var datePickerSource : Array<Schedule> = []
    var datePickerBool : Bool = false
    
    var checkTouchAlert : Bool = false
    
    
    var checkWhile : Bool = false
    var checkReturnBtn : Bool = false
    
    var fvo = FavoriteVO()//사용자 함수를 위해
    
    
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
            self.timer.invalidate()//타이머 종료
            
            UIApplication.sharedApplication().cancelAllLocalNotifications()//모든 알람 종료
            
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)//페이지 닫기
        }
        let cancelAction = UIAlertAction(title: "아니오", style: .Cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelNotification(sender: AnyObject) {
        
        let alert = UIAlertController(title: "확인", message: "해당 경로의 모든 알림이 해제됩니다.\n모든 알림을 해제하시겠습니까?", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "확인", style: .Default){ (_) in
            UIApplication.sharedApplication().cancelAllLocalNotifications()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .Cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet var returnTransferBtn: UIButton!
    @IBAction func returnTransfer(sender: AnyObject) {
        
        if Reachability.isConnectedToNetwork() == true {
            
            self.checkReturnBtn = true
            self.transferTimeSchedulCount -= 2
            
            //self.info[transferTimeSchedulCount+1].expressYN = false
            //self.info[transferTimeSchedulCount+1].navigateTm = []
            
            transferAct1(ButtonNumber: 3)
            
            if(countTimeAct.text == "환승역 도착"){
                timer.invalidate()
            }
            
            self.checkReturnBtn = false
            
        }else {
            
            networkAlert(0)
            
        }
        
    }
    
    func addRecentList(){
        
        let name : String = self.info[0].navigate[0] + "," + self.info[self.info.count-1].navigate[self.info[self.info.count-1].navigate.count-1]
        
        var list : Array<String> = self.fvo.config.objectForKey("RecentArray") as! Array<String>
        
        var check : Bool = false
        
        for ce in list{
            
            if(ce == name){
                check = true
                
                list.removeAtIndex(list.indexOf(ce)!)
                list.append(ce)
                self.fvo.config.setObject(list, forKey: "RecentArray")
                
                break;
            }
            
        }
        
        if(check == false){
            
            if(list.count >= 20){
                list.removeAtIndex(0)
            }
            
            list.append(name)
            self.fvo.config.setObject(list, forKey: "RecentArray")
            
        }
        
        
    }
    
    func swipedViewRight(){
        
        timer.invalidate()
        UIApplication.sharedApplication().cancelAllLocalNotifications()//모든 알람 종료
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.transferInfo.setFontSize(settingFontSize(0))
        self.transferBtn1.setFontSize(settingFontSize(0))
        self.transferBtn2.setFontSize(settingFontSize(0))
        self.transferBtn3.setFontSize(settingFontSize(0))
        self.finishTime.setFontSize(settingFontSize(0))
        self.returnTransferBtn.setFontSize(settingFontSize(1))
        self.infoNextST.setFontSize(settingFontSize(4))
        self.countTimeAct.setFontSize(settingFontSize(5))
        self.fastExitLabel.setFontSize(settingFontSize(1)-1)
        
        self.infoNextTopCon.constant = settingFontSize(3)
        self.viewAllRouteBtn.setFontSize(settingFontSize(1))
        self.cancelBtn.setFontSize(settingFontSize(1))
        
        self.bottomBarCon.constant = settingFontSize(6)
        
        pickerView.hidden = true
        tabBar.hidden = true
        returnTransferBtn.hidden = true
        returnTransferBtn.enabled = false
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
        
        
        completeBtnOutlet.tintColor = UIColor(red:  230/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 0.0)
        completeBtnOutlet.enabled = false
        
        let swipeRec = UISwipeGestureRecognizer()
        swipeRec.direction = .Right
        swipeRec.addTarget(self, action: #selector(LastPageViewController.swipedViewRight))
        mainView.addGestureRecognizer(swipeRec)
        mainView.userInteractionEnabled = true
        
        let fvo = FavoriteVO()
        
        self.setAlertTime = fvo.config.objectForKey("setAlertTime") as! Int
        
        switch setAlertTime{
        case 0:
            self.setAlertTime = 30
            self.setAlertMessage = "역까지 약 30초 남았습니다."
            break;
        case 1:
            self.setAlertTime = 60
            self.setAlertMessage = "역까지 약 1분 남았습니다."
            break;
        case 2:
            self.setAlertTime = 90
            self.setAlertMessage = "역까지 약 90초 남았습니다."
            break;
        case 3:
            self.setAlertTime = 120
            self.setAlertMessage = "역까지 약 2분 남았습니다."
            break;
        default:
            break;
        }
        
        timer.invalidate()
        UIApplication.sharedApplication().cancelAllLocalNotifications()//모든 알람 종료
        
        self.transferTimeSchedulCount = 0
        countTimeAct.text = "00분 00초"
        
        addRecentList()//최근경로에 추가
        
        self.checkTouchAlert = false
        
        
        if(self.info.count != 1){ //환승역이 있을 경우
            infoNextST.text = "환승역(" + String(self.info[transferTimeSchedulCount+1].navigate[0]) + ")까지" + "\n" + "남은 시간"
            
            transferInfo.text = self.info[transferTimeSchedulCount+1].navigate[0] + "역 출발 시간 설정"
            
            transferStationTimeSchduel(StartTime: self.info[0].startTime)
            
            if(convertStringToSecond(countTimeAct.text!, Mode: 3) <= 0){
                countTimeAct.text = "환승역 도착"
            }else{
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LastPageViewController.updateCounter), userInfo: nil, repeats: true)
            }
            
            
        }else { //환승역이 없을 경우
            self.transferTimeSchedulCount = 1
            
            infoNextST.text = "목적지(" + String(self.info[self.info.count-1].navigate[self.info[self.info.count-1].navigate.count-1]) + ")까지" + "\n" + "남은 시간"
            transferInfo.text = "다음 환승역 없음"
            transferBtn1.setTitle("없음", forState: .Normal)
            transferBtn2.setTitle("없음", forState: .Normal)
            transferBtn3.setTitle("없음", forState: .Normal)
            transferBtn1.enabled = false
            transferBtn2.enabled = false
            transferBtn3.enabled = false
            
            let currentTime : Int = returnCurrentTime()
            
            let fTime : Int = self.info[0].navigateTm[self.info[0].navigateTm.count-1]
            
            if((fTime - currentTime) <= 0){
                countTimeAct.text = "00분 00초"
            }else{
                stimeMain = self.info[0].navigateTm[0]//convertStringToSecond(self.startTimeText, Mode: 2)
                totaltimeMain = fTime - self.info[0].navigateTm[0]
                countTimeAct.text = convertSecondToString(fTime - currentTime, Mode: 4)
            }
            
            
            if(convertStringToSecond(countTimeAct.text!, Mode: 3) <= 0){
                countTimeAct.text = "목적지 도착"
                
                returnTransferBtn.hidden = true
                returnTransferBtn.enabled = false
                
                completeBtnOutlet.enabled = true
                completeBtnOutlet.tintColor = UIColor.whiteColor()
            }else{
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LastPageViewController.updateCounter), userInfo: nil, repeats: true)
                
                
            }
            
            
            finishTime.text = "목적지 예상 도착 시간 : " + convertSecondToString(fTime, Mode: 2)
            
            
            
        }
    
        
    }
    
    //푸시알림관련====================================
    func localNotificationFunc(FinishTime finishTm : Int, StationName stationNm : String, FirstSchedule first : String, SecondSchedule second : String, FastExit fastExit : String){
        
        let fvo = FavoriteVO()
        
        if(fvo.config.objectForKey("SetAlert") as! Bool == true){
        
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LastPageViewController.notificationAct1(_:)), name: "actionOnePressed", object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LastPageViewController.notificationAct2(_:)), name: "actionTwoPressed", object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LastPageViewController.notificationAct3(_:)), name: "actionThreePressed", object: nil)
            
            let now = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "ko_KR") // 로케일 설정
            dateFormatter.dateFormat = "HH:mm:ss" // 날짜 형식 설정
            let current : Int = returnCurrentTime()
            
            let alertTime : Int = current + finishTm - self.setAlertTime//%%60 //
            
            if(current < alertTime){ //현재시간보다 알람시간이 더 큰 경우 알람 설정
                
                let hour : Int = Int(alertTime/3600)
                let min : Int = (alertTime - (hour*3600))/60
                let sec : Int = alertTime - hour*3600 - min*60
                
                
                let dateComp:NSDateComponents = NSDateComponents()
                
                dateFormatter.dateFormat = "yyyy"
                var currentTime : Int = Int(dateFormatter.stringFromDate(now))!
                dateComp.year = currentTime//local notification 설정
                
                dateFormatter.dateFormat = "MM"
                currentTime = Int(dateFormatter.stringFromDate(now))!
                dateComp.month = currentTime//local notification 설정
                
                dateFormatter.dateFormat = "dd"
                currentTime = Int(dateFormatter.stringFromDate(now))!
                dateComp.day = currentTime//local notification 설정
                
                
                dateComp.hour = hour//local notification 설정
                dateComp.minute = min//local notification 설정
                dateComp.second = sec//local notification 설정
                
                
                dateComp.timeZone = NSTimeZone.systemTimeZone()
                
                
                let calender:NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
                let date:NSDate = calender.dateFromComponents(dateComp)!
                
                let notification:UILocalNotification = UILocalNotification()
                
                var fastExitText : String = ""
                
                if (first == ""){
                    notification.alertBody = stationNm + self.setAlertMessage//%%"역까지 1분 남았습니다."
                    notification.soundName = UILocalNotificationDefaultSoundName
                }else{
                    
                    if(fastExit == ""){
                        fastExitText = ""
                    }else{
                        fastExitText = "\n빠른환승 : " + fastExit
                    }
                    
                    notification.category = "FIRST_CATEGORY"
                    notification.soundName = UILocalNotificationDefaultSoundName
                    notification.alertBody = stationNm + "\(self.setAlertMessage)\n첫번째 : \(first)\n두번째 : \(second)\(fastExitText)\n다음 시간표 미설정시 첫번째로 설정됩니다."
                }
                
                
                
                notification.fireDate = date
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
            }else{ //아닐경우 알람설정 안함
                
                if(checkTouchAlert == false && checkReturnBtn == false){
                    
                    
                    var message : String = ""
                    
                    switch fvo.config.objectForKey("setAlertTime") as! Int{
                    case 0:
                        message = "남은 시간이 30초 미만이라 알림을 설정하지 않습니다."
                        break;
                    case 1:
                        message = "남은 시간이 1분 미만이라 알림을 설정하지 않습니다."
                        break;
                    case 2:
                        message = "남은 시간이 1분 30초 미만이라 알림을 설정하지 않습니다."
                        break;
                    case 3:
                        message = "남은 시간이 2분 미만이라 알림을 설정하지 않습니다."
                        break;
                    default:
                        break;
                    }
                    
                    let alert = UIAlertController(title: "확인", message: message, preferredStyle: .Alert)
                    let cancelAction = UIAlertAction(title: "확인", style: .Default, handler: nil)
                    alert.addAction(cancelAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
            }
        }
        
    }
    
    
    //타이머 관련 함수 ========================================
    func updateCounter() {
        
        let currentTime : Int = returnCurrentTime()
        
        let sec : Int = convertStringToSecond(countTimeAct.text!, Mode: 3) - 1
        //print("sec : \(sec)")
        if(sec >= 0){
            if(stimeMain + totaltimeMain - currentTime < 0){
                countTimeAct.text = "0분 0초"
            }else{
                countTimeAct.text = convertSecondToString(stimeMain + totaltimeMain - currentTime, Mode: 4)
                //print(countTimeAct.text)
            }
        }else{
            //timer.invalidate()
            countTimeAct.text = "0분 0초"
            if(currentTime >= self.notiNextTm){
                
                timer.invalidate()
                self.checkTouchAlert = true
                transferAct1(ButtonNumber: 1)
                
                while currentTime > self.notiNextTm{
                    //currentTime = convertStringToSecond(dateFormatter.stringFromDate(now), Mode: 1)
                    timer.invalidate()
                    self.checkTouchAlert = true
                    transferAct1(ButtonNumber: 1)
                    if(countTimeAct.text! == "목적지 도착" || checkWhile == true){
                        break;
                    }
                }
                
                self.checkTouchAlert = false
            }
            
        }
        
    }
    
    //끝 ==================================================
    
    func notificationAct1(notification:NSNotification){
        
        if Reachability.isConnectedToNetwork() == true {
            
            let index : Int = self.transferTimeSchedulCount
            
            for i in  index..<self.info.count{
                
                if(self.info[i].navigateTm[self.info[i].navigateTm.count-1] - self.setAlertTime > returnCurrentTime()){
                    break;
                }else{
                    self.checkReturnBtn = true
                    transferAct1(ButtonNumber: 1)
                    self.checkReturnBtn = false
                }
                
            }
            
            
            transferAct1(ButtonNumber: 1)
            
        }else {
            
            setlocalNotificationWhenNotNetworkConnection()
            //networkAlert(0)
            
        }
        
    }
    
    func notificationAct2(notification:NSNotification){
        
        
        if Reachability.isConnectedToNetwork() == true {
            
            let index : Int = self.transferTimeSchedulCount
            
            for i in  index..<self.info.count{
                
                if(self.info[i].navigateTm[self.info[i].navigateTm.count-1] - self.setAlertTime > returnCurrentTime()){
                    break;
                }else{
                    self.checkReturnBtn = true
                    transferAct1(ButtonNumber: 1)
                    self.checkReturnBtn = false
                }
                
            }
            
            
            transferAct1(ButtonNumber: 2)
            
        }else {
            
            setlocalNotificationWhenNotNetworkConnection()
            //networkAlert(0)
            
        }
        
        
    }
    
    func notificationAct3(notification:NSNotification){
        transferActPicker()
    }
    
    func setlocalNotificationWhenNotNetworkConnection(){
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()//모든 알람 종료
        
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ko_KR") // 로케일 설정
        dateFormatter.dateFormat = "HH:mm:ss" // 날짜 형식 설정
        let current : Int = returnCurrentTime()
        
        let hour : Int = Int(current/3600)
        let min : Int = (current - (hour*3600))/60
        let sec : Int = current - hour*3600 - min*60 + 2 //현재시간 2초뒤 알림 설정
        
        
        let dateComp:NSDateComponents = NSDateComponents()
        
        dateFormatter.dateFormat = "yyyy"
        var currentTime : Int = Int(dateFormatter.stringFromDate(now))!
        dateComp.year = currentTime//local notification 설정
        
        dateFormatter.dateFormat = "MM"
        currentTime = Int(dateFormatter.stringFromDate(now))!
        dateComp.month = currentTime//local notification 설정
        
        dateFormatter.dateFormat = "dd"
        currentTime = Int(dateFormatter.stringFromDate(now))!
        dateComp.day = currentTime//local notification 설정
        
        
        dateComp.hour = hour//local notification 설정
        dateComp.minute = min//local notification 설정
        dateComp.second = sec//local notification 설정
        
        
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        
        
        let calender:NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let date:NSDate = calender.dateFromComponents(dateComp)!
        
        let notification:UILocalNotification = UILocalNotification()
        
        
        
        
        notification.alertBody = "네트워크가 연결되지 않아 알림이 설정되지 않았습니다.\n네트워크를 연결 후 시간표를 다시 선택해주세요.\n미설정시 남은 경로의 알림이 제공되지 않습니다."
        notification.soundName = UILocalNotificationDefaultSoundName
        
        notification.fireDate = date
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
    
    
    func transferAct1(ButtonNumber number : Int){ //첫번째 시간표
        
        
        
        
        if(self.info.count - 1 < transferTimeSchedulCount){
            
            if(convertStringToSecond(countTimeAct.text!, Mode: 3) <= 0){
                countTimeAct.text = "목적지 도착"
                returnTransferBtn.hidden = true
                returnTransferBtn.enabled = false
                
                completeBtnOutlet.enabled = true
                completeBtnOutlet.tintColor = UIColor.whiteColor()
            }
            else{
                self.checkWhile = true
                timer.invalidate()
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LastPageViewController.updateCounter), userInfo: nil, repeats: true)
            }
            
        }else{
            
            switch number{
            case 1:
                transferStationTimeSchduel(StartTime: convertStringToSecond(/*(transferBtn1.titleLabel?.text)!*/self.setTransTimeBtnText1, Mode: 2))
                break;
            case 2:
                transferStationTimeSchduel(StartTime: convertStringToSecond(/*(transferBtn2.titleLabel?.text)!*/self.setTransTimeBtnText2, Mode: 2))
                break;
            case 3:
                transferStationTimeSchduel(StartTime: self.info[transferTimeSchedulCount].startTime)
                break;
            default:
                break;
            }
            
            
            if(self.transferTimeSchedulCount >= self.info.count){
                self.infoNextST.text = "목적지(" + self.info[self.transferTimeSchedulCount-1].navigate[self.info[self.transferTimeSchedulCount-1].navigate.count-1] + ")까지\n남은 시간"
                
                self.transferInfo.text = "다음 환승역 없음"
            }else{
                self.infoNextST.text = "환승역(" + self.info[self.transferTimeSchedulCount].navigate[0] + ")까지" + "\n" + "남은 시간"
                
                self.transferInfo.text = self.info[self.transferTimeSchedulCount].navigate[0] + "역 출발 시간 설정"
            }
            
            
            
            if(convertStringToSecond(countTimeAct.text!, Mode: 3) <= 0){
                countTimeAct.text = "환승역 도착"
            }else{
                timer.invalidate()
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LastPageViewController.updateCounter), userInfo: nil, repeats: true)
            }
        }
        
        
    }
    
    func transferActPicker(){ //기타 버튼
        
        if(datePickerBool == true){
            
            //if Reachability.isConnectedToNetwork() == true {
            
            let alert = UIAlertController(title: "해당 시간표로 설정하시겠습니까?", message: "\((transferBtn3.titleLabel?.text)!)", preferredStyle: .ActionSheet)
            let okAction = UIAlertAction(title: "설정", style: UIAlertActionStyle.Default){ (_) in
                
                if Reachability.isConnectedToNetwork() == true {
                    
                    self.datePickerBool = false
                    if(self.info.count - 1 < self.transferTimeSchedulCount){
                        
                        if(convertStringToSecond(self.countTimeAct.text!, Mode: 3) <= 0){
                            self.countTimeAct.text = "목적지 도착"
                            self.returnTransferBtn.hidden = true
                            self.returnTransferBtn.enabled = false
                            
                            self.completeBtnOutlet.enabled = true
                            self.completeBtnOutlet.tintColor = UIColor.whiteColor()
                        }else{
                            self.timer.invalidate()
                            self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LastPageViewController.updateCounter), userInfo: nil, repeats: true)
                        }
                        
                    }else{
                        
                        self.transferStationTimeSchduel(
                            StartTime: convertStringToSecond((self.transferBtn3.titleLabel?.text)!, Mode: 2))
                        
                        if(self.transferTimeSchedulCount >= self.info.count){
                            self.infoNextST.text = "목적지(" + self.info[self.transferTimeSchedulCount-1].navigate[self.info[self.transferTimeSchedulCount-1].navigate.count-1] + ")까지\n남은 시간"
                            
                            self.transferInfo.text = "다음 환승역 없음"
                        }else{
                            self.infoNextST.text = "환승역(" + self.info[self.transferTimeSchedulCount].navigate[0] + ")까지" + "\n" + "남은 시간"
                            
                            self.transferInfo.text = self.info[self.transferTimeSchedulCount].navigate[0] + "역 출발 시간 설정"
                        }
                        
                        
                        
                        if(convertStringToSecond(self.countTimeAct.text!, Mode: 3) <= 0){
                            self.countTimeAct.text = "환승역 도착"
                        }else{
                            self.timer.invalidate()
                            self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LastPageViewController.updateCounter), userInfo: nil, repeats: true)
                        }
                    }
                    
                }else {
                    
                    self.networkAlert(0)
                    
                }
                
            }
            let okAction2 = UIAlertAction(title:"재설정", style: .Destructive){(_) in
                self.pickerView.hidden = false
                self.tabBar.hidden = false
            }
            let cancelAction = UIAlertAction(title: "취소", style: .Cancel){ (_) in
                
            }
            
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            alert.addAction(okAction2)
            self.presentViewController(alert, animated: true, completion: nil)
            
            
            
            
        }else{
            
            if(self.transferBtn3.titleLabel?.text == "기타" && self.datePickerSource.count >= 3){
                if(self.datePickerSource[2].expressYN == "Y"){
                    transferBtn3.setTitle(convertSecondToString(self.datePickerSource[2].arriveTime, Mode: 1) + " " + self.datePickerSource[2].directionNm + "행 (급행)", forState: .Normal)
                }else{
                    transferBtn3.setTitle(convertSecondToString(self.datePickerSource[2].arriveTime, Mode: 1) + " " + self.datePickerSource[2].directionNm + "행", forState: .Normal)
                }
                
                
                
                self.datePickerBool = true
            }
            
            pickerView.hidden = false
            tabBar.hidden = false
        }
        
    }
    
    
    
    
    func transferStationTimeSchduel(StartTime sTime : Int) {
        
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()//모든 알람 종료
        
        self.datePickerBool = false
        
        //info에 시작시간 추가
        if(self.info[transferTimeSchedulCount].startTime != sTime){
            
            self.info[transferTimeSchedulCount].startTime = sTime
            
            info = setAllTimeToInfo(Info: info, Index: transferTimeSchedulCount)
            
        }
        
        if(self.info[self.transferTimeSchedulCount].fastExit == ""){
            self.fastExitLabel.text = ""
        }else{
            self.fastExitLabel.text = "빠른환승\n\(self.info[self.transferTimeSchedulCount].fastExit)"
        }
        
        
        let viaTime : Int = self.info[transferTimeSchedulCount].navigateTm[self.info[transferTimeSchedulCount].navigateTm.count-1] - self.info[transferTimeSchedulCount].navigateTm[0]
        
        
        
        //여기까지 전역의 시작시간과 이동시간 끝나는 시간을 구하기 위한 구문임
        //----------------------------------------------------------------
        //여기부터 다음역의 시간표를 가져오기 위한 구문임
        
        transferTimeSchedulCount += 1
        
        if(transferTimeSchedulCount >= 2){
            returnTransferBtn.enabled = true
            returnTransferBtn.hidden = false
        }else{
            returnTransferBtn.hidden = true
            returnTransferBtn.enabled = false
        }
        
        
        
        
        if(self.info.count != transferTimeSchedulCount){//만약 다음역이 있다면
            
            var schedule = self.info[transferTimeSchedulCount].startSchedule //다음역의 시간표
            
            
            let indexTemp : Int = self.info[transferTimeSchedulCount].startScheduleIndex //다음역의 출발 시간 인덱스
            
            self.datePickerSource = schedule
            self.datePickerSource.removeRange(0..<indexTemp)
            
            if(schedule.count - 1 >= indexTemp){
                transferBtn1.enabled = true
                
                if(schedule[indexTemp].expressYN == "Y"){
                    self.setTransTimeBtnText1 = convertSecondToString(schedule[indexTemp].arriveTime, Mode: 1) + " " + schedule[indexTemp].directionNm + "행 (급행)"
                }else{
                    self.setTransTimeBtnText1 = convertSecondToString(schedule[indexTemp].arriveTime, Mode: 1) + " " + schedule[indexTemp].directionNm + "행"
                }
                
                
                transferBtn1.setTitle(self.setTransTimeBtnText1, forState: .Normal)
                
                
                self.notiStartTm = self.setTransTimeBtnText1//schedule1 //다다음 출발 시간을 설정하기 위함
                
                let fTime : Int = self.info[transferTimeSchedulCount].navigateTm[self.info[transferTimeSchedulCount].navigateTm.count-1] //다음역의 도착시간
                
                let currentTime : Int = returnCurrentTime()
                
                if((fTime - currentTime) <= 0){
                    
                    self.notiNextTm = 0
                }else{
                    
                    self.notiNextTm = fTime - (self.setAlertTime + 10)//%%70
                }
                
                
            }else{
                transferBtn1.setTitle("없음", forState: .Normal)
                transferBtn1.enabled = false
            }
            
            if(schedule.count - 2 >= indexTemp){
                transferBtn2.enabled = true
                
                if(schedule[indexTemp+1].expressYN == "Y"){
                    self.setTransTimeBtnText2 = convertSecondToString(schedule[indexTemp+1].arriveTime, Mode: 1) + " " + schedule[indexTemp+1].directionNm + "행 (급행)"
                }else{
                    self.setTransTimeBtnText2 = convertSecondToString(schedule[indexTemp+1].arriveTime, Mode: 1) + " " + schedule[indexTemp+1].directionNm + "행"
                }
                
                transferBtn2.setTitle(self.setTransTimeBtnText2, forState: .Normal)
                
            }else{
                transferBtn2.setTitle("없음", forState: .Normal)
                transferBtn2.enabled = false
            }
            
            transferBtn3.enabled = true
            transferBtn3.setTitle("기타", forState: .Normal)
            if(datePickerSource.count >= 3){
                pickerView.selectRow(2, inComponent: 0, animated: true)
            }
            
            
            pickerView.reloadAllComponents()
            
            
        }else{//다음역이 없을 경우 (마지막 열차 라인일 경우)
            self.setTransTimeBtnText1 = ""
            self.setTransTimeBtnText2 = ""
            
            transferBtn1.setTitle("없음", forState: .Normal)
            transferBtn2.setTitle("없음", forState: .Normal)
            transferBtn3.setTitle("기타", forState: .Normal)
            transferBtn1.enabled = false
            transferBtn2.enabled = false
            transferBtn3.enabled = false
        }
        
        
        let currentTime : Int = returnCurrentTime()
        
        //sTime과 viaTime은 현재 라인의 출발시간과 이동시간임
        if((sTime + viaTime - currentTime) <= 0){//비정상적인 경우
            countTimeAct.text = "00분 00초"
            //self.notiNextTm = sTime + viaTime
            
        }else{//정상적인 경우 - 화면에 표시되는 카운트 다운을 위한 설정 구문
            stimeMain = sTime
            totaltimeMain = viaTime
            countTimeAct.text = convertSecondToString(stimeMain + totaltimeMain - currentTime, Mode: 4)
        }
        
        
        if(self.info.count == transferTimeSchedulCount){ // 다음 역이 없을 경우
            //finishTime.numberOfLines = 1
            finishTime.text = "목적지 예상 도착 시간 : " + convertSecondToString(sTime + viaTime, Mode: 2)
            
            localNotificationFunc(FinishTime: convertStringToSecond(countTimeAct.text!, Mode: 3), StationName: self.info[transferTimeSchedulCount-1].navigate[self.info[transferTimeSchedulCount-1].navigate.count - 1], FirstSchedule: /*schedule1*/self.setTransTimeBtnText1, SecondSchedule: /*schedule2*/self.setTransTimeBtnText2, FastExit: self.info[transferTimeSchedulCount-1].fastExit)
            
        }else{ //다음 역이 있는 경우
            
            finishTime.text = String(transferTimeSchedulCount) + "번째 환승역 예상 도착 시간 : " + convertSecondToString(sTime + viaTime, Mode: 2)
            
            localNotificationFunc(FinishTime: convertStringToSecond(countTimeAct.text!, Mode: 3), StationName: self.info[transferTimeSchedulCount].navigate[0], FirstSchedule: /*schedule1*/self.setTransTimeBtnText1, SecondSchedule: /*schedule2*/self.setTransTimeBtnText2,FastExit: self.info[transferTimeSchedulCount-1].fastExit)
            
        }
        
        pickerView.hidden = true
        tabBar.hidden = true
        pickerView.reloadAllComponents()
        
        for i in self.transferTimeSchedulCount..<self.info.count{
            
            self.checkTouchAlert = true
            transferStationTimeSchduel2(StartTime: convertStringToSecond(self.notiStartTm, Mode: 2), Index: i)
            self.checkTouchAlert = false
            
        }
        
        
    }
    
    //전체적으로 알림을 설정하기 위한 함수
    func transferStationTimeSchduel2(StartTime sTime : Int, Index index : Int) {
        
        let fTime : Int = self.info[index].navigateTm[self.info[index].navigateTm.count-1]
        
        var schedule1 : String = ""
        var schedule2 : String = ""
        
        var countTimeActTemp : String = ""
        
        
        //여기부터 다음 역에 대한 구문임
        
        if(self.info.count != index+1){//다음역이 있을경우
            
            let schedule = self.info[index+1].startSchedule
            
            
            let indexTemp : Int = self.info[index+1].startScheduleIndex
            
            if(schedule.count - 1 > indexTemp){
                
                if(schedule[indexTemp].expressYN == "Y"){
                    schedule1 = convertSecondToString(schedule[indexTemp].arriveTime, Mode: 1) + " " + schedule[indexTemp].directionNm + "행 (급행)"
                }else{
                    schedule1 = convertSecondToString(schedule[indexTemp].arriveTime, Mode: 1) + " " + schedule[indexTemp].directionNm + "행"
                }
                
                
            }else{
                schedule1 = ""
            }
            self.notiStartTm = schedule1
            
            if(schedule.count - 2 > indexTemp){
                
                if(schedule[indexTemp+1].expressYN == "Y"){
                    schedule2 = convertSecondToString(schedule[indexTemp+1].arriveTime, Mode: 1) + " " + schedule[indexTemp+1].directionNm + "행 (급행)"
                }else{
                    schedule2 = convertSecondToString(schedule[indexTemp+1].arriveTime, Mode: 1) + " " + schedule[indexTemp+1].directionNm + "행"
                }
                
            }else{
                schedule2 = ""
            }
            
            
        }
        
        
        let currentTime : Int = returnCurrentTime()
        
        if((fTime - currentTime) <= 0){
            countTimeActTemp = "00분 00초"
        }else{
            countTimeActTemp = convertSecondToString(fTime - currentTime, Mode: 4)
        }
        
        if(index+1 == self.info.count){
            localNotificationFunc(FinishTime: convertStringToSecond(countTimeActTemp, Mode: 3), StationName: self.info[index].navigate[self.info[index].navigate.count - 1], FirstSchedule: schedule1, SecondSchedule: schedule2, FastExit: self.info[index].fastExit)
        }else{
            localNotificationFunc(FinishTime: convertStringToSecond(countTimeActTemp, Mode: 3), StationName: self.info[index+1].navigate[0], FirstSchedule: schedule1, SecondSchedule: schedule2, FastExit: self.info[index].fastExit)
        }
        
    }
    
    func networkAlert(mode : Int){
        
        let alert = UIAlertController(title: "오류", message: "네트워크 연결을 확인해주세요.", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "확인", style: .Cancel){(_) in
            
            if(mode == 1){
                self.navigationController?.popViewControllerAnimated(true)
            }
            
        }
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    
    @IBOutlet var transferInfo: UILabel!
    
    @IBOutlet var transferBtn1: UIButton!
    @IBAction func transferBtnAct1(sender: AnyObject) {
        
        transferAct1(ButtonNumber: 1)
        
        
    }
    
    @IBOutlet var transferBtn2: UIButton!
    @IBAction func transferBtnAct2(sender: AnyObject) {
        
        transferAct1(ButtonNumber: 2)
        
    }
    
    @IBOutlet var transferBtn3: UIButton!
    @IBAction func transferBtnAct3(sender: AnyObject) {
        
        transferActPicker()
        
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
        return self.datePickerSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(self.datePickerSource[row].expressYN == "Y"){
            return convertSecondToString(self.datePickerSource[row].arriveTime, Mode: 1) + " " + self.datePickerSource[row].directionNm + "행 (급행)"
        }else{
            return convertSecondToString(self.datePickerSource[row].arriveTime, Mode: 1) + " " + self.datePickerSource[row].directionNm + "행"
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(self.datePickerSource[row].expressYN == "Y"){
            transferBtn3.setTitle(convertSecondToString(self.datePickerSource[row].arriveTime, Mode: 1) + " " + self.datePickerSource[row].directionNm + "행 (급행)", forState: .Normal)
        }else{
            transferBtn3.setTitle(convertSecondToString(self.datePickerSource[row].arriveTime, Mode: 1) + " " + self.datePickerSource[row].directionNm + "행", forState: .Normal)
        }
        
        
        
        self.datePickerBool = true
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var titleData : String = ""
        
        if(self.datePickerSource[row].expressYN == "Y"){
            titleData = convertSecondToString(self.datePickerSource[row].arriveTime, Mode: 1) + " " + self.datePickerSource[row].directionNm + "행(급행)"
        }else{
            titleData = convertSecondToString(self.datePickerSource[row].arriveTime, Mode: 1) + " " + self.datePickerSource[row].directionNm + "행"
        }
        
        let myTitle = NSAttributedString(string: titleData, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        return myTitle
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "viewToRoute2") {
            
            let navController = segue.destinationViewController as! NavigationController
            let detailController = navController.topViewController as! AllRouteViewController
            
            detailController.info = self.info
            detailController.lastPageCheck = true
            
        }
    }
    
    
}