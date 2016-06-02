import UIKit

// 테이블뷰에 포함된 아웃렛들
class AllRouteViewCell : UITableViewCell{
    
    @IBOutlet var lineColor: UILabel!
    
    @IBOutlet var stationLabel: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    
}

class AllRouteViewController : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var info : Array<SubwayInfo> = []//경로 분석 정보
    
    var totalTime : Int = 0
    
    var lastPageCheck : Bool = false
    
    var timeList : Array<Int> = []
    
    var timer = NSTimer()//타이머 관련
    
    var currentStationTime : Int = 0
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var informView: UIView!
    
    @IBOutlet var subject1: UILabel!
    @IBOutlet var subject2: UILabel!
    @IBOutlet var subject3: UILabel!
    
    @IBOutlet var transferTimeLabel: UILabel!
    @IBOutlet var viaStationLabel: UILabel!
    @IBOutlet var transferNumLabel: UILabel!
    
    
    @IBAction func closeBtn(sender: AnyObject) {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)//페이지 닫기
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        timer.invalidate()
    }
    
    
    override func viewDidLoad() {
        for parent in self.navigationController!.navigationBar.subviews{
            for childView in parent.subviews{
                if(childView is UIImageView){
                    childView.removeFromSuperview()
                }
            }
        }
        //네비게이션바 색상변경
        let navBarColor = navigationController!.navigationBar
        navBarColor.barTintColor = UIColor(red:  230/255.0, green: 70/255.0, blue: 70/255.0, alpha: 0.0)
        navBarColor.tintColor = UIColor.whiteColor()
        navBarColor.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        informView.setHeight(settingFontSize(6)+10)
        self.transferNumLabel.setFontSize(settingFontSize(1)+1)
        self.transferTimeLabel.setFontSize(settingFontSize(1)+1)
        self.viaStationLabel.setFontSize(settingFontSize(1)+1)
        self.subject1.setFontSize(settingFontSize(1))
        self.subject2.setFontSize(settingFontSize(1))
        self.subject3.setFontSize(settingFontSize(1))
        
        var time : Int = 0
        
        if(info.count == 1){
            if(totalTime == 0){
                time = self.info[0].time
            }else{
                time = totalTime
            }
                    }else{
            if(self.info[0].navigateTm.count == 0){
                
                if(totalTime == 0){
                    for i in 0..<info.count{
                        time = time + info[i].time
                    }
                }else{
                    time = totalTime
                }
                
                
            }else{
                if(self.info[self.info.count-1].navigateTm.count == 0){
                    time = totalTime
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
        
        if(lastPageCheck == true){
            
            for cert in self.info{
                
                for ce in cert.navigateTm{
                    self.timeList.append(ce)
                }
                
            }
            
            let currentTime = returnCurrentTime()
            for time in self.timeList{
                
                if(time >= currentTime){
                    self.currentStationTime = time
                    break
                }
                
            }
            
            timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(AllRouteViewController.updateCounter), userInfo: nil, repeats: true)
        }
        
        self.tableView.reloadData()
    }
    
    // 현재시간 기준 현재 무슨역인지 표시하기 위해 타이머를 통해 주기적으로 체크함
    func updateCounter() {
        
        let currentTime = returnCurrentTime()
        for time in self.timeList{
            
            if(time >= currentTime){
                self.currentStationTime = time
                self.tableView.reloadData()
                break
            }
            
        }
        
    }
    
    //**************************테이블 생성**************************
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return info.count
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return info[section].navigate.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! AllRouteViewCell;
        
            
        var count : Int = 0
        
        for i in 0..<section{
            count = count + info[i].navigate.count
        }
        count = count+row+1
        
        cell.backgroundColor = UIColor.whiteColor()
        
        cell.lineColor.backgroundColor = returnLineColor(SubwayId: info[section].subwayId)
        
        cell.stationLabel.text = "#\(count) " + info[section].navigate[row] + "역"
        cell.stationLabel.setFontSize(settingFontSize(1)+1)
        
        if(info[section].navigateTm.count == 0){
            if(row == 0){
                cell.timeLabel.text = "시간 미설정"
            }else{
                cell.timeLabel.text = ""
            }
            
        }else{
            cell.timeLabel.text = convertSecondToString(info[section].navigateTm[row], Mode: 1)
        }
        cell.timeLabel.setFontSize(settingFontSize(1))
        
        if(self.lastPageCheck == true){
            
            if(self.info[section].navigateTm[row] == self.currentStationTime){
                cell.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
                //cell.stationLabel.text = cell.stationLabel.text! + " (현재역)"
            }
            
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var name : String = ""
        
        if(info[section].expressYN == true){
            name = "(급행)"
        }
        
        switch info[section].subwayId
        {
        case "1001" :
            name = "1호선" + name
            break;
        case "1002" :
            name = "2호선" + name
            break;
        case "1003" :
            name = "3호선" + name
            break;
        case "1004" :
            name = "4호선" + name
            break;
        case "1005" :
            name = "5호선" + name
            break;
        case "1006" :
            name = "6호선" + name
            break;
        case "1007" :
            name = "7호선" + name
            break;
        case "1008" :
            name = "8호선" + name
            break;
        case "1009" :
            name = "9호선" + name
            break;
        case "1069" :
            name = "인천 1호선" + name
            break;
        case "1063" :
            name = "경의중앙선" + name
            break;
        case "1075" :
            name = "분당선" + name
            break;
        case "1065" :
            name = "공항철도" + name
            break;
        case "1067" :
            name = "경춘선" + name
            break;
        case "1077" :
            name = "신분당선" + name
            break;
        case "1071" :
            name = "수인선" + name
            break;
        default :
            break;
        }
        
        
        
        return name
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        
        header.textLabel!.textColor = UIColor.whiteColor()
        header.alpha = 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        
        var time : Int = 0
        var waitTime : Int = 0
        
        if(info[section].navigateTm.count == 0){
            time = info[section].time
        }else{
            time = info[section].navigateTm[info[section].navigateTm.count-1] - info[section].navigateTm[0]
        }
        
        if(section != info.count-1){
            if(info[section+1].navigateTm.count != 0){
                
                waitTime = info[section+1].navigateTm[0] - info[section].navigateTm[info[section].navigateTm.count-1]
            }
            
        }
        
        if(waitTime == 0){
            let version = UILabel(frame: CGRectMake(0, 0, tableView.frame.width, settingFontSize(10)))
            //version.setFontSize(settingFontSize(1))
            version.font = version.font.fontWithSize(settingFontSize(1))
            version.numberOfLines = 2
            
            if(info[section].fastExit == ""){
                version.text = "\(info[section].navigate.count)개역 이동 (약 \(convertSecondToString(time, Mode: 4)) 소요)"
            }else{
                version.text = "\(info[section].navigate.count)개역 이동 (약 \(convertSecondToString(time, Mode: 4)) 소요)\n빠른환승 : \(info[section].fastExit)"
            }
            
            
            version.textColor = UIColor.whiteColor()
            version.textAlignment = .Center;
            
            view.addSubview(version)
            
            return view
        }else{
            let version = UILabel(frame: CGRectMake(0, 0, tableView.frame.width, settingFontSize(10)))
            //version.setFontSize(settingFontSize(1))
            version.font = version.font.fontWithSize(settingFontSize(1))
            version.numberOfLines = 2
            
            if(info[section].fastExit == ""){
                version.text = "\(info[section].navigate.count)개역 이동 (약 \(convertSecondToString(time, Mode: 4)) 소요)\n환승 대기시간 : 약 \(convertSecondToString(waitTime, Mode: 4))"
            }else{
                version.text = "\(info[section].navigate.count)개역 이동 (약 \(convertSecondToString(time, Mode: 4)) 소요)\n환승 대기시간 : 약 \(convertSecondToString(waitTime, Mode: 4)) | 빠른환승 : \(info[section].fastExit)"
            }
            
            
            version.textColor = UIColor.whiteColor()
            version.textAlignment = .Center;
            
            view.addSubview(version)
            
            return view
        }
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
//        if(info[section].navigateTm.count == 0){
//            return settingFontSize(1)
//        }else{
//            return settingFontSize(1)*2
//        }
        return settingFontSize(10)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return settingFontSize(9)
    }
    
}