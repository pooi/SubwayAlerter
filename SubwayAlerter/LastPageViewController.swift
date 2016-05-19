import UIKit

class LastPageViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    var stimeMain : Int = 0 //타이머에서 사용
    var totaltimeMain : Int = 0
    
    var transferTimeSchedulCount : Int = 0
    
    var timer = NSTimer()//타이머 관련
    
    var info : Array<SubwayInfo> = []//경로 분석 정보
    
    var setTransTimeBtnText1 : String = ""
    var setTransTimeBtnText2 : String = ""
    
    var datePickerSource : Array<Schedule> = []
    var datePickerBool : Bool = false
    
    var notiNextTm : Int = 0
    var checkTouchAlert : Bool = false
    var checkWhile : Bool = false
    var checkReturnBtn : Bool = false
    
    
    
    
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
        
        self.checkReturnBtn = true
        self.transferTimeSchedulCount -= 2
        
        //self.info[transferTimeSchedulCount+1].expressYN = false
        //self.info[transferTimeSchedulCount+1].navigateTm = []
        
        transferAct1(ButtonNumber: 3)
        
        if(countTimeAct.text == "환승역 도착"){
            timer.invalidate()
        }
        
        self.checkReturnBtn = false
        
        
    }
    
    
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
        
        pickerView.hidden = true
        tabBar.hidden = true
        returnTransferBtn.hidden = true
        returnTransferBtn.enabled = false
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
        completeBtnOutlet.tintColor = UIColor(red:  230/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 0.0)
        completeBtnOutlet.enabled = false
        
        self.transferTimeSchedulCount = 0
        countTimeAct.text = "00분 00초"
        
        
        
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
            
        }else{ //다음 역이 있는 경우
            
            finishTime.text = String(transferTimeSchedulCount) + "번째 환승역 예상 도착 시간 : " + convertSecondToString(sTime + viaTime, Mode: 2)
            
            
        }
        
        pickerView.hidden = true
        tabBar.hidden = true
        pickerView.reloadAllComponents()
        
        
        
        
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
        
    }
    
    
}