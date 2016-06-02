import UIKit

class SetStartTMViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var start : String = "" //segue를 통해 가져옴
    var finish : String = ""  //segue를 통해 가져옴
    var StartStationCode : String?//열차시간표를 가져오기 위한 역번호
    var startStationInfo : Array<Schedule> = []//출발역의 정보 저장
    var upOrDown : String = "" //상행,내선 : 1 , 하행,외선 : 2
    var minStatnId : Array<String> = [] //경유하는 역 ID
    var minStatnNm : Array<String> = []//경유하는 역 이름
    //var listTransferStation : Array<Transfer> = [] //환승역들의 정보 저장
    var totalTime : Int = 0 //총 소요시간 저장 (분 단위)
    var standardInfo : Int = 0 //0 = 추천, 1 = 최소시간, 2 = 최소환승
    var startTimeText : String = ""
    var pickerViewFirstTime : String = ""
    var info : Array<SubwayInfo> = []//경로 분석정보
    var info2 : Array<SubwayInfo> = []//경로 분석정보 복사본
    var info3 : Array<SubwayInfo> = []//경로 분석정보 복사본
    
    var checkLoad : Bool = false
    //@IBOutlet var underView: UIView!
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
    //var pickerDataSoruce : Array<String> = []
    
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
        
        
        return self.info3.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! RouteTableCell
        
        let section = indexPath.section
        
        
        cell.startStation.text = "출발 : " + self.info3[section].navigate[0] + "역"
        cell.startStation.setFontSize(settingFontSize(1)+1)
        cell.finishStation.text = "도착 : " + self.info3[section].navigate[self.info3[section].navigate.count-1] + "역"
        cell.finishStation.setFontSize(settingFontSize(1)+1)
        
        
        cell.stationInfo.text = String(self.info3[section].navigate.count-2) + "개역 이동"
        
        if(self.info3[section].fastExit == ""){
            
            if(section < self.info3.count - 1){
                cell.stationInfo.text = cell.stationInfo.text! + ", 빠른환승 : 지원안함"
            }
            
            
            
        }else{
            
            cell.stationInfo.text = cell.stationInfo.text! + ", 빠른환승 : " + self.info3[section].fastExit
            
        }
        
        cell.stationInfo.setFontSize(settingFontSize(1)-1)
        
        
        if(self.info3[section].navigateTm.count != 0){
            
            cell.startTime.text = convertSecondToString(self.info3[section].navigateTm[0], Mode: 1)
            cell.finishTime.text = convertSecondToString(self.info3[section].navigateTm[self.info3[section].navigateTm.count-1], Mode: 1)
            
            
            
            let viaTime : Int = self.info3[section].navigateTm[self.info3[section].navigateTm.count-1] - self.info3[section].navigateTm[0]
            
            cell.timeInfo.text = convertSecondToString(viaTime, Mode: 4) + " 소요"
        }else{
            cell.startTime.text = "미설정"
            cell.finishTime.text = ""
            cell.timeInfo.text = "미설정"
        }
        cell.startTime.setFontSize(settingFontSize(1))
        cell.finishTime.setFontSize(settingFontSize(1))
        cell.timeInfo.setFontSize(settingFontSize(1)-1)
        
        cell.lineColor.backgroundColor = returnLineColor(SubwayId: self.info3[section].subwayId)
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        
        header.textLabel!.textColor = UIColor.whiteColor()
        header.alpha = 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return settingFontSize(8)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var name : String = ""
        
        if(info3[section].expressYN == true){
            name = "(급행)"
        }
        
        name = returnLineName(SubwayId: info3[section].subwayId) + name
        
        return name
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        
        var time : Int = 0
        var waitTime : Int = 0
        
        if(info3[section].navigateTm.count == 0){
            time = info3[section].time
        }else{
            time = info3[section].navigateTm[info3[section].navigateTm.count-1] - info3[section].navigateTm[0]
        }
        
        if(section != info3.count-1){
            if(info3[section+1].navigateTm.count != 0){
                
                waitTime = info3[section+1].navigateTm[0] - info3[section].navigateTm[info3[section].navigateTm.count-1]
            }
            
        }
        
        if(waitTime == 0){
            let version = UILabel(frame: CGRectMake(0, 0, tableView.frame.width, settingFontSize(10)))
            //version.setFontSize(settingFontSize(1))
            version.font = version.font.fontWithSize(settingFontSize(1))
            version.numberOfLines = 1
            version.text = "\(info3[section].navigate.count)개역 이동 (약 \(convertSecondToString(time, Mode: 4)) 소요)"
            version.textColor = UIColor.whiteColor()
            version.textAlignment = .Center;
            
            view.addSubview(version)
            
            return view
        }else{
            let version = UILabel(frame: CGRectMake(0, 0, tableView.frame.width, settingFontSize(10)))
            //version.setFontSize(settingFontSize(1))
            version.font = version.font.fontWithSize(settingFontSize(1))
            version.numberOfLines = 2
            
            if(info3[section].fastExit == ""){
                version.text = "\(info3[section].navigate.count)개역 이동 (약 \(convertSecondToString(time, Mode: 4)) 소요)\n환승 대기시간 : 약 \(convertSecondToString(waitTime, Mode: 4))"
            }else{
                version.text = "\(info3[section].navigate.count)개역 이동 (약 \(convertSecondToString(time, Mode: 4)) 소요)\n환승 대기시간 : 약 \(convertSecondToString(waitTime, Mode: 4)) | 빠른환승 : \(info3[section].fastExit)"
            }
            
            version.textColor = UIColor.whiteColor()
            version.textAlignment = .Center;
            
            view.addSubview(version)
            
            return view
        }
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return settingFontSize(10)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        
        
    }
    
    
    //*****************************피커뷰*****************************//
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return startStationInfo.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(startStationInfo[row].expressYN == "Y"){
            return convertSecondToString(startStationInfo[row].arriveTime, Mode: 1) + " " + startStationInfo[row].directionNm + "행 (급행)"
        }else{
            return convertSecondToString(startStationInfo[row].arriveTime, Mode: 1) + " " + startStationInfo[row].directionNm + "행"
        }
        
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if Reachability.isConnectedToNetwork() == true {
            
            checkInfo2()
            
            if(self.startStationInfo[row].expressYN == "Y"){
                startTimeText4.setTitle(convertSecondToString(self.startStationInfo[row].arriveTime, Mode: 1)+" "+startStationInfo[row].directionNm+"행 (급행)", forState: .Normal)
                
                self.startTimeText = convertSecondToString(self.startStationInfo[row].arriveTime, Mode: 1)+" "+startStationInfo[row].directionNm+"행 (급행)"
            }else{
                startTimeText4.setTitle(convertSecondToString(self.startStationInfo[row].arriveTime, Mode: 1)+" "+startStationInfo[row].directionNm+"행", forState: .Normal)
                
                self.startTimeText = convertSecondToString(self.startStationInfo[row].arriveTime, Mode: 1)+" "+startStationInfo[row].directionNm+"행"
            }
            
            self.info[0].startTime = convertStringToSecond(self.startTimeText, Mode: 2)
            
            info = setAllTimeToInfo(Info: info, Index: 0)
            
            checkFinishLine()
            
            setAllItem()
            
            finishTime.text = calculateFinishTime()
            
            
            nextBtn.enabled = true
            
        }else {
            
            networkAlert(0)
            
        }
        
        
        
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var titleData : String = ""
        
        if(startStationInfo[row].expressYN == "Y"){
            titleData = convertSecondToString(startStationInfo[row].arriveTime, Mode: 1) + " " + startStationInfo[row].directionNm + "행 (급행)"
        }else{
            titleData = convertSecondToString(startStationInfo[row].arriveTime, Mode: 1) + " " + startStationInfo[row].directionNm + "행"
        }
        
        let myTitle = NSAttributedString(string: titleData, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        return myTitle
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        spinnerView.layer.cornerRadius = 10
        
        informView.setHeight(settingFontSize(6)+10)
        
        self.transferNumLabel.setFontSize(settingFontSize(1)+1)
        self.transferTimeLabel.setFontSize(settingFontSize(1)+1)
        self.viaStationLabel.setFontSize(settingFontSize(1)+1)
        self.subject1.setFontSize(settingFontSize(1))
        self.subject2.setFontSize(settingFontSize(1))
        self.subject3.setFontSize(settingFontSize(1))
        
        self.viewAllRouteText.setFontSize(settingFontSize(1))
        self.standardBtnText.setFontSize(settingFontSize(1))
        
        self.setTimeTitle.setFontSize(settingFontSize(0))
        self.startTimeText1.setFontSize(settingFontSize(0))
        self.startTimeText2.setFontSize(settingFontSize(0))
        self.startTimeText3.setFontSize(settingFontSize(0))
        self.startTimeText4.setFontSize(settingFontSize(0))
        self.finishTime.setFontSize(settingFontSize(0))
        self.bottomBarCon.constant = settingFontSize(6)
        
        
        self.tabBarController?.tabBar.hidden = true
        
        spinnerView.hidden = false
        spinner.startAnimating()
        
        standardBtnText.hidden = true
        viewAllRouteText.hidden = true
        pickerView.hidden = true
        toolBar.hidden = true
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
        inital()
        
        
        
        let swipeLec = UISwipeGestureRecognizer()
        swipeLec.direction = .Left
        swipeLec.addTarget(self, action: #selector(SetStartTMViewController.swipedViewLeft))
        mainView.addGestureRecognizer(swipeLec)
        
        let swipeRec = UISwipeGestureRecognizer()
        swipeRec.direction = .Right
        swipeRec.addTarget(self, action: #selector(SetStartTMViewController.swipedViewRight))
        mainView.addGestureRecognizer(swipeRec)
        mainView.userInteractionEnabled = true
        
        
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        
        
        if(checkLoad == false){
            checkLoad = true
            
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
                self.callSubwayApi()
                dispatch_async(dispatch_get_main_queue()){
                    self.viewAllRouteText.hidden = false
                    self.standardBtnText.hidden = false
                    self.spinnerView.hidden = true
                    self.spinner.stopAnimating()
                }
                
            }
            
            
        }
        
        
        
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
        UIApplication.sharedApplication().cancelAllLocalNotifications()//모든 알람 종료
    }
    
    // 네트워크 경고창을 띄우는 함수
    func networkAlert(mode : Int){
        
        dispatch_async(dispatch_get_main_queue()){
            let alert = UIAlertController(title: "오류", message: "네트워크 연결을 확인해주세요.", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "확인", style: .Cancel){(_) in
                
                if(mode == 1){
                    self.navigationController?.popViewControllerAnimated(true)
                }
                
            }
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    
    // 스와이프 관련
    func swipedViewLeft(){
        
        
        if(nextBtn.enabled == true){
            performSegueWithIdentifier("moveToLast", sender: self)
        }
        
    }
    
    // 스와이프 관련
    func swipedViewRight(){
        
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    // 변수 초기화
    func inital(){
        self.StartStationCode = ""
        self.startStationInfo = Array()
        self.upOrDown = ""
        self.minStatnId = Array()
        self.minStatnNm = Array()
        //self.listTransferStation = Array()
        self.totalTime = 0
        self.standardInfo = 0 //0 = 추천, 1 = 최소시간, 2 = 최소환승
        self.startTimeText = ""
        finishTime.text = "예상 도착 시간 : "
        nextBtn.enabled = false
    }
    
    var timer = NSTimer()//타이머 관련
    
    // 최소시간기준, 최소환승기준 등 기준을 바꿔주는 버튼
    @IBAction func standardBtn(sender: AnyObject) {
        
        if Reachability.isConnectedToNetwork() == true {
            
            spinner.hidden = false
            spinner.startAnimating()
            spinnerView.hidden = false
            
            
            self.startTimeText1.setTitle("-", forState: .Normal)
            self.startTimeText2.setTitle("-", forState: .Normal)
            self.startTimeText3.setTitle("-", forState: .Normal)
            self.startTimeText4.setTitle("-", forState: .Normal)
            
            self.startTimeText1.setTitleColor(UIColor.blackColor(), forState: .Normal)
            self.startTimeText2.setTitleColor(UIColor.blackColor(), forState: .Normal)
            self.startTimeText3.setTitleColor(UIColor.blackColor(), forState: .Normal)
            self.startTimeText4.setTitleColor(UIColor.blackColor(), forState: .Normal)
            
            self.buttonsEnabled(false)
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
                
                
                self.inital()
                
                if(self.standardBtnText.titleLabel?.text == "최소 시간 기준"){
                    self.standardInfo = 2
                }else{
                    self.standardInfo = 1
                }
                
                
                self.callSubwayApi()
                
                dispatch_async(dispatch_get_main_queue()){
                    
                    self.spinnerView.hidden = true
                    self.spinner.stopAnimating()
                    
                    self.buttonsEnabled(true)
                    
                }
                
                
            }
            
        }else {
            
            networkAlert(0)
            
        }
        
        
    }
//    func updateCounter() {
//        timer.invalidate()
//        
//        inital()
//        
//        if(standardBtnText.titleLabel?.text == "최소 시간 기준"){
//            self.standardInfo = 2
//        }else{
//            self.standardInfo = 1
//        }
//        
//        startTimeText1.setTitle("-", forState: .Normal)
//        startTimeText2.setTitle("-", forState: .Normal)
//        startTimeText3.setTitle("-", forState: .Normal)
//        startTimeText4.setTitle("-", forState: .Normal)
//        
//        callSubwayApi()
//        
//        startTimeText1.setTitleColor(UIColor.blackColor(), forState: .Normal)
//        startTimeText2.setTitleColor(UIColor.blackColor(), forState: .Normal)
//        startTimeText3.setTitleColor(UIColor.blackColor(), forState: .Normal)
//        startTimeText4.setTitleColor(UIColor.blackColor(), forState: .Normal)
//        
//        spinnerView.hidden = true
//        spinner.stopAnimating()
//        
//    }
    
    
    //최초의 지하철 이동경로 가져옴
    func callSubwayApi() {
        
        if Reachability.isConnectedToNetwork() == true {
            
            let root = returnRootApi(StartNm: self.start, FinishNm: self.finish, Mode: self.standardInfo)
            
            let row = root.0
            self.standardInfo = root.1
            
            if(row.statnFid != ""){
                
                var extraMinStatIdString : String = ""
                var extraMinStatnNmString : String = ""
                
                
                if(standardInfo == 1){ //최소 시간 기준일 경우
                    extraMinStatIdString = row.shtStatnId
                    extraMinStatnNmString = row.shtStatnNm
                    totalTime = row.shtTravelTm + row.shtTransferCnt * 60
                    
                    standardInfo = 1
                    standardBtnText.setTitle("최소 시간 기준", forState: .Normal)
                }else if(standardInfo == 2){ //최소 환승 기준일 경우
                    extraMinStatIdString = row.minStatnId
                    extraMinStatnNmString = row.minStatnNm
                    totalTime = row.minTravelTm + row.minTransferCnt * 60
                    
                    standardInfo = 2
                    standardBtnText.setTitle("최소 환승 기준", forState: .Normal)
                }
                
                //===============경유하는 역ID 배열에 추가===============
                var textTemp : String = ""
                for ce in extraMinStatIdString.characters{
                    if(Int(String(ce)) != nil){
                        textTemp = textTemp + String(ce)
                    } else if(Int(String(ce)) == nil){
                        if(textTemp != ""){ minStatnId.append(textTemp) }
                        textTemp = ""
                    }
                }
                //===============경유하는 역명 배열에 추가===============
                
                textTemp = ""
                for ce in extraMinStatnNmString.characters{
                    if(String(ce) == "  " || String(ce) == " " || String(ce) == ","){//탭,공백,콤마 제외
                        if(textTemp != ""){ minStatnNm.append(textTemp) }
                        textTemp = ""
                    }else{
                        textTemp = textTemp + String(ce)
                    }
                }
                //=======================종료========================
                
                upOrDown = checkUpOrDown(StartSTNm: self.minStatnNm[0], StartSTId: self.minStatnId[0], NextSTNm: self.minStatnNm[1])
                
                //-----원래 밖에 있던 부분-------
                
                var temporaryString : String = convertStartToFinishString(Start: 1, Finish: 4, string: self.minStatnId[0])
                var indexTemp : Array<Int> = []
                for te in self.minStatnId{
                    if(convertStartToFinishString(Start: 1, Finish: 4, string: te) == temporaryString){
                        temporaryString = convertStartToFinishString(Start: 1, Finish: 4, string: te)
                    }else{
                        indexTemp.append(minStatnId.indexOf(te)!)
                        temporaryString = convertStartToFinishString(Start: 1, Finish: 4, string: te)
                    }
                }
                
                //**********************핵심************************
                self.info.removeAll()
                self.info = parsingRoot(minStatNm: self.minStatnNm, minStatId: self.minStatnId)
                //*************************************************
                
                
                var scheduleYN : Bool = false
                for ce in 0..<info.count{
                    if(self.info[ce].startSchedule.count == 0){
                        dispatch_async(dispatch_get_main_queue()) {
                            scheduleYN = true
                            
                            let alert = UIAlertController(title: "오류", message: "시간표 정보를 가져오는데 실패하였습니다.", preferredStyle: .Alert)
                            let cancelAction = UIAlertAction(title: "확인", style: .Cancel){(_) in
                                
                                //self.navigationController?.popViewControllerAnimated(true)
                                
                            }
                            alert.addAction(cancelAction)
                            self.presentViewController(alert, animated: true, completion: nil)
                            self.setAllItem()
                            //print(info)
                        }
                    }
                }
                
                if(scheduleYN == false){
                    dispatch_async(dispatch_get_main_queue()) {
                        self.setAllItem()
                        
                        self.pickerView.reloadAllComponents()
                        
                        self.setSubwayTime()
                    }
                    
                }
                
            }else{
                dispatch_async(dispatch_get_main_queue()) {
                    let alert = UIAlertController(title: "오류", message: "이동경로를 가져오는데 실패하였습니다.\n역명을 확인해주세요.", preferredStyle: .Alert)
                    let cancelAction = UIAlertAction(title: "확인", style: .Cancel){(_) in
                        
                        self.navigationController?.popViewControllerAnimated(true)
                        
                    }
                    alert.addAction(cancelAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
                
            }
            
        }else {
            
            networkAlert(1)
            
        }
        
        
        
        
        
    }
    
    // 경로에 대한 정보를 설정하는 함수
    func setAllItem(){
        
        self.info3 = self.info
        
        var time : Int = 0
        
        if(info[0].navigateTm.count == 0){
            time = self.totalTime
        }else{
            if(info.count == 1){
                time = self.info[0].time
            }else{
                if(self.info[self.info.count-1].navigateTm.count == 0){
                    time = self.totalTime
                }else{
                    time = self.info[self.info.count-1].navigateTm[self.info[self.info.count-1].navigateTm.count-1]-self.info[0].startTime
                }
            }
        }
        
        var number : Int = 0
        
        for cert in info{
            number = number + cert.navigate.count
        }
        
        transferTimeLabel.text = convertSecondToString(time, Mode: 5) + "분"
        viaStationLabel.text = String(number) + "개"
        transferNumLabel.text = String(self.info.count-1) + "회"
        
        
        self.tableView.reloadData()
        
    }
    
    //시작시간표 버튼의 내용을 설정하는 함수
    func setSubwayTime(){
        
        startStationInfo = self.info[0].startSchedule
        
        if(startStationInfo.count != 0){
            
            
            let currentTime : Int = returnCurrentTime()
            
            
            var extraCount : Int = 0
            
            for cert in startStationInfo{
                if(cert.arriveTime >= currentTime){
                    break;
                }else{extraCount += 1}
            }
            if(extraCount == 0){extraCount = 1}
            
            pickerView.reloadAllComponents()
            
            startTimeText4.setTitle("기타", forState: .Normal)
            if(self.startStationInfo.count >= extraCount){
                
                if(extraCount == self.startStationInfo.count && self.startStationInfo[extraCount-1].arriveTime <= returnCurrentTime()){
                    pickerView.selectRow(startStationInfo.count-1, inComponent: 0, animated: true)
                    
                    if(startStationInfo[startStationInfo.count-1].expressYN == "Y"){
                        pickerViewFirstTime = convertSecondToString(self.startStationInfo[startStationInfo.count-1].arriveTime, Mode: 1)+" "+startStationInfo[startStationInfo.count-1].directionNm+"행 (급행)"
                    }else if(startStationInfo[startStationInfo.count-1].expressYN == ""){
                        pickerViewFirstTime = convertSecondToString(self.startStationInfo[startStationInfo.count-1].arriveTime, Mode: 1)+" "+startStationInfo[startStationInfo.count-1].directionNm+"행"
                    }
                    
                    
                    
                    startTimeText1.setTitle("없음", forState: .Normal)
                    startTimeText1.enabled = false
                    
                }else{
                    
                    if(startStationInfo[extraCount-1].expressYN == "Y"){
                        startTimeText1.setTitle(convertSecondToString(self.startStationInfo[extraCount-1].arriveTime, Mode: 1)+" "+startStationInfo[extraCount-1].directionNm+"행 (급행)", forState: .Normal)
                    }else if(startStationInfo[extraCount-1].expressYN == ""){
                        startTimeText1.setTitle(convertSecondToString(self.startStationInfo[extraCount-1].arriveTime, Mode: 1)+" "+startStationInfo[extraCount-1].directionNm+"행", forState: .Normal)
                    }
                    
                }
                
            }else{
                pickerView.selectRow(startStationInfo.count-1, inComponent: 0, animated: true)
                
                if(startStationInfo[startStationInfo.count-1].expressYN == "Y"){
                    pickerViewFirstTime = convertSecondToString(self.startStationInfo[startStationInfo.count-1].arriveTime, Mode: 1)+" "+startStationInfo[startStationInfo.count-1].directionNm+"행 (급행)"
                }else if(startStationInfo[startStationInfo.count-1].expressYN == ""){
                    pickerViewFirstTime = convertSecondToString(self.startStationInfo[startStationInfo.count-1].arriveTime, Mode: 1)+" "+startStationInfo[startStationInfo.count-1].directionNm+"행"
                }
                
                startTimeText1.setTitle("없음", forState: .Normal)
                startTimeText1.enabled = false
            }
            
            if(self.startStationInfo.count - 1 >= extraCount){
                if(startStationInfo[extraCount].expressYN == "Y"){
                    startTimeText2.setTitle(convertSecondToString(self.startStationInfo[extraCount].arriveTime, Mode: 1)+" "+startStationInfo[extraCount].directionNm+"행 (급행)", forState: .Normal)
                }else if(startStationInfo[extraCount].expressYN == ""){
                    startTimeText2.setTitle(convertSecondToString(self.startStationInfo[extraCount].arriveTime, Mode: 1)+" "+startStationInfo[extraCount].directionNm+"행", forState: .Normal)
                }
                
                
            }else{
                startTimeText2.setTitle("없음", forState: .Normal)
                startTimeText2.enabled = false
            }
            
            if(self.startStationInfo.count - 2 >= extraCount){
                pickerView.selectRow(extraCount+1, inComponent: 0, animated: true)
                
                
                
                if(startStationInfo[extraCount+1].expressYN == "Y"){
                    startTimeText3.setTitle(convertSecondToString(self.startStationInfo[extraCount+1].arriveTime, Mode: 1)+" "+startStationInfo[extraCount+1].directionNm+"행 (급행)", forState: .Normal)
                    
                    pickerViewFirstTime = convertSecondToString(self.startStationInfo[extraCount+1].arriveTime, Mode: 1)+" "+startStationInfo[extraCount+1].directionNm+"행 (급행)"
                }else if(startStationInfo[extraCount+1].expressYN == ""){
                    startTimeText3.setTitle(convertSecondToString(self.startStationInfo[extraCount+1].arriveTime, Mode: 1)+" "+startStationInfo[extraCount+1].directionNm+"행", forState: .Normal)
                    
                    pickerViewFirstTime = convertSecondToString(self.startStationInfo[extraCount+1].arriveTime, Mode: 1)+" "+startStationInfo[extraCount+1].directionNm+"행"
                }
                
            }else{
                startTimeText3.setTitle("없음", forState: .Normal)
                startTimeText4.setTitle("없음", forState: .Normal)
                startTimeText3.enabled = false
                startTimeText4.enabled = false
            }
            
            
            
        }else{
            
            startTimeText1.setTitle("없음", forState: .Normal)
            startTimeText2.setTitle("없음", forState: .Normal)
            startTimeText3.setTitle("없음", forState: .Normal)
            startTimeText4.setTitle("없음", forState: .Normal)
            startTimeText1.enabled = false
            startTimeText2.enabled = false
            startTimeText3.enabled = false
            startTimeText4.enabled = false
            
            let alert = UIAlertController(title: "오류", message: "시간표 정보를 가져오는데 실패하였습니다.\n잠시 후 다시 시도해주세요.", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "확인", style: .Cancel){(_) in
                
                self.navigationController?.popViewControllerAnimated(true)
                
            }
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    func buttonsEnabled(check : Bool){
        
        self.startTimeText1.enabled = check
        self.startTimeText2.enabled = check
        self.startTimeText3.enabled = check
        self.startTimeText4.enabled = check
        self.standardBtnText.enabled = check
        self.viewAllRouteText.enabled = check
        
    }
    
    // 첫번째 시간표 버튼
    @IBOutlet var startTimeText1: UIButton!
    @IBAction func startTime1(sender: AnyObject) {
        
        
        if Reachability.isConnectedToNetwork() == true {
            
            if(startTimeText1.titleLabel?.text != "-"){
                
                spinnerView.hidden = false
                spinner.startAnimating()
                
                buttonsEnabled(false)
                
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
                    self.checkInfo2()
                    
                    self.startTimeText = (self.startTimeText1.titleLabel?.text)!
                    self.info[0].startTime = convertStringToSecond(self.startTimeText, Mode: 2)
                    
                    
                    self.info = setAllTimeToInfo(Info: self.info, Index: 0)
                    
                    
                    self.startTimeText1.setTitleColor(UIColor.blackColor(), forState: .Normal)
                    self.startTimeText2.setTitleColor(UIColor.grayColor(), forState: .Normal)
                    self.startTimeText3.setTitleColor(UIColor.grayColor(), forState: .Normal)
                    self.startTimeText4.setTitleColor(UIColor.grayColor(), forState: .Normal)
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue()){
                        self.checkFinishLine()
                        self.setAllItem()
                        
                        self.finishTime.text = self.calculateFinishTime()
                        
                        
                        self.nextBtn.enabled = true
                        self.nextBtn.tintColor = UIColor.whiteColor()
                        
                        self.buttonsEnabled(true)
                        
                        self.spinnerView.hidden = true
                        self.spinner.stopAnimating()
                    }
                    
                    
                }
                
            }
            
            
        }else {
            
            networkAlert(0)
            
        }
        
        
        
        
    }
    
    // 두번째 시간표 버튼
    @IBOutlet var startTimeText2: UIButton!
    @IBAction func startTime2(sender: AnyObject) {
        
        if Reachability.isConnectedToNetwork() == true {
            
            if(startTimeText2.titleLabel?.text != "-"){
                
                spinnerView.hidden = false
                spinner.startAnimating()
                
                buttonsEnabled(false)
                
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
                    self.checkInfo2()
                    
                    self.startTimeText = (self.startTimeText2.titleLabel?.text)!
                    self.info[0].startTime = convertStringToSecond(self.startTimeText, Mode: 2)
                    
                    
                    self.info = setAllTimeToInfo(Info: self.info, Index: 0)
                    
                    
                    
                    self.startTimeText2.setTitleColor(UIColor.blackColor(), forState: .Normal)
                    self.startTimeText1.setTitleColor(UIColor.grayColor(), forState: .Normal)
                    self.startTimeText3.setTitleColor(UIColor.grayColor(), forState: .Normal)
                    self.startTimeText4.setTitleColor(UIColor.grayColor(), forState: .Normal)
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue()){
                        self.checkFinishLine()
                        self.setAllItem()
                        
                        self.finishTime.text = self.calculateFinishTime()
                        
                        self.nextBtn.enabled = true
                        self.nextBtn.tintColor = UIColor.whiteColor()
                        
                        self.buttonsEnabled(true)
                        
                        self.spinnerView.hidden = true
                        self.spinner.stopAnimating()
                    }
                    
                    
                }
                
                
            }
            
        }else {
            
            networkAlert(0)
            
        }
        
        
        
    }
    
    // 세번째 시간표 버튼
    @IBOutlet var startTimeText3: UIButton!
    @IBAction func startTime3(sender: AnyObject) {
        
        if Reachability.isConnectedToNetwork() == true {
            
            if(startTimeText3.titleLabel?.text != "-"){
                
                spinnerView.hidden = false
                spinner.startAnimating()
                
                buttonsEnabled(false)
                
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
                    self.checkInfo2()
                    
                    self.startTimeText = (self.startTimeText3.titleLabel?.text)!
                    self.info[0].startTime = convertStringToSecond(self.startTimeText, Mode: 2)
                    
                    
                    self.info = setAllTimeToInfo(Info: self.info, Index: 0)
                    
                    
                    self.startTimeText3.setTitleColor(UIColor.blackColor(), forState: .Normal)
                    self.startTimeText1.setTitleColor(UIColor.grayColor(), forState: .Normal)
                    self.startTimeText2.setTitleColor(UIColor.grayColor(), forState: .Normal)
                    self.startTimeText4.setTitleColor(UIColor.grayColor(), forState: .Normal)
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue()){
                        self.checkFinishLine()
                        self.setAllItem()
                        
                        self.finishTime.text = self.calculateFinishTime()
                        
                        
                        self.nextBtn.enabled = true
                        self.nextBtn.tintColor = UIColor.whiteColor()
                        
                        self.buttonsEnabled(true)
                        
                        self.spinnerView.hidden = true
                        self.spinner.stopAnimating()
                    }
                    
                    
                }
                
                
            }
            
        }else {
            
            networkAlert(0)
            
        }
        
        
        
    }
    
    // 기타 시간표 버튼
    @IBOutlet var startTimeText4: UIButton!
    @IBAction func startTimeText4(sender: AnyObject) {
        
        if Reachability.isConnectedToNetwork() == true {
            
            if(startTimeText4.titleLabel?.text != "-"){
                
                startTimeText4.setTitleColor(UIColor.blackColor(), forState: .Normal)
                startTimeText1.setTitleColor(UIColor.grayColor(), forState: .Normal)
                startTimeText2.setTitleColor(UIColor.grayColor(), forState: .Normal)
                startTimeText3.setTitleColor(UIColor.grayColor(), forState: .Normal)
                
                checkInfo2()
                
                if(startTimeText4.titleLabel?.text != "기타"){
                    self.startTimeText = (startTimeText4.titleLabel?.text)!
                    self.info[0].startTime = convertStringToSecond(self.startTimeText, Mode: 2)
                    
                    info = setAllTimeToInfo(Info: info, Index: 0)
                    
                    checkFinishLine()
                    
                    setAllItem()
                    
                    finishTime.text = calculateFinishTime()
                    
                    nextBtn.enabled = true
                    self.nextBtn.tintColor = UIColor.whiteColor()
                }else if(startTimeText4.titleLabel?.text == "기타"){
                    
                    startTimeText4.setTitle(self.pickerViewFirstTime, forState: .Normal)
                    self.startTimeText = self.pickerViewFirstTime//(startTimeText4.titleLabel?.text)!
                    self.info[0].startTime = convertStringToSecond(self.startTimeText, Mode: 2)
                    
                    info = setAllTimeToInfo(Info: info, Index: 0)
                    
                    checkFinishLine()
                    
                    setAllItem()
                    
                    finishTime.text = calculateFinishTime()
                    
                    nextBtn.enabled = true
                    self.nextBtn.tintColor = UIColor.whiteColor()
                    
                }
                
                pickerView.hidden = false
                toolBar.hidden = false
                
            }
            
        }else {
            
            networkAlert(0)
            
        }
        
        
    }
    
    // 급행 경로이었다가 일반 경로로 바뀔경우 일반경로를 원상복구 해주기 위한 함수
    func checkInfo2(){
        
        if(self.info2.count != 0){
            self.info = self.info2 //백업을 통해 다시 원상복구
            self.info2.removeAll()
        }
        
    }
    
    // 막차가 종료되어 노선이 없는 경우 확인
    func checkFinishLine(){
        
        
        for i in 0..<self.info.count{
            
            if(self.info[i].navigateTm.count == 0){
                
                self.info2 = self.info //나중을 위한 백업
                
                
                let alert = UIAlertController(title: "알림", message: "\(returnLineName(SubwayId: self.info[i].subwayId)) \(self.info[i].navigate[0])의 운행이 종료되어 \(returnLineName(SubwayId: self.info[i].subwayId))부터의 알림은 설정하지 않습니다.", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "확인", style: .Default){(_) in
                    
                    
                    self.setAllItem()
                }
                alert.addAction(okAction)
                self.presentViewController(alert, animated: true, completion: nil)
                
                self.info.removeRange(i..<self.info.endIndex)
                
                break;
            }
            
        }
        
        
    }
    
    // 예상 도착 시간을 구하는 함수
    func calculateFinishTime() -> String{
        
        
        var finish : String = ""
        var timeTemp : Int = 0
        
        
        //timeTemp = self.info[self.info.count-1].navigateTm[self.info[self.info.count-1].navigateTm.count-1]
        if(self.info[self.info.count-1].navigateTm.count == 0){
            timeTemp = self.totalTime
        }else{
            timeTemp = self.info[self.info.count-1].navigateTm[self.info[self.info.count-1].navigateTm.count-1]-self.info[0].startTime
        }
        finish = "예상 도착 시간 : " + convertSecondToString(self.info[0].startTime + timeTemp, Mode: 2)
        
        
        return finish
    }
    
    
    
    
    
    @IBOutlet var standardBtnText: UIButton!
    @IBOutlet var viewAllRouteText: UIButton!
    
    
    @IBOutlet var finishTime: UILabel!
    
    @IBOutlet var nextBtn: UIBarButtonItem!
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "moveToLast") {
            
            (segue.destinationViewController as? LastPageViewController)?.info = self.info
            
        }else if (segue.identifier == "viewToRoute") {
            
            let navController = segue.destinationViewController as! NavigationController
            let detailController = navController.topViewController as! AllRouteViewController
            
            detailController.info = self.info
            detailController.totalTime = self.totalTime
            
            
        }
    }
    
    
}