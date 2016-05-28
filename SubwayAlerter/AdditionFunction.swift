//
//  AdditionFunction.swift
//  SubwayAlerter
//
//  Created by 유태우 on 2016. 5. 5..
//  Copyright © 2016년 유태우. All rights reserved.
//

import Foundation
import UIKit

// 사용자 설정을 저장할 함수
class FavoriteVO {
    
    let config = NSUserDefaults.standardUserDefaults()
    
}

// 주요 색 저장
let settingColor = [
    UIColor(red: 233/255, green: 97/255, blue: 97/255, alpha: 1.0),
    UIColor(red: 208/255, green: 84/255, blue: 84/255, alpha: 1.0),
    UIColor(red: 194/255, green: 75/255, blue: 75/255, alpha: 1.0),
    UIColor(red: 175/255, green: 64/255, blue: 64/255, alpha: 1.0),
    UIColor(red: 157/255, green: 55/255, blue: 55/255, alpha: 1.0),
    UIColor(red: 139/255, green: 46/255, blue: 46/255, alpha: 1.0)
]


struct SubwayInfo {
    var navigate : Array<String>
    var navigateId : Array<String>
    let copyNavigate : Array<String>
    let copyNavigateId : Array<String>
    var navigateTm : Array<Int>
    var subwayId : String
    var time : Int
    let copyTime : Int
    var updn : String
    var startTime : Int
    var startSchedule : Array<Schedule>
    var startScheduleIndex : Int
    var expressYN : Bool
    var fastExit : String
}

struct Root{
    var statnFid : String = ""
    var statnTid : String = ""
    var shtTravelTm : Int = 0
    var shtTransferCnt : Int = 0
    var minTravelTm : Int = 0
    var minTransferCnt : Int = 0
    var shtStatnId : String = ""
    var shtStatnNm : String = ""
    var minStatnId : String = ""
    var minStatnNm : String = ""
}


struct Transfer {
    var name : String //환승역명
    var Id : String //환승역 ID
}

struct SubwayList {
    var line : String //열차 호선
    var stationNm : String //지하철 역명
    var chosung : String //지하철 역명 초성
}

struct Schedule {
    var arriveTime : Int //도착 시간 단위 : 초
    var leftTime : Int //출발 시간
    var directionNm : String //열차 방향 예 : 구파발행
    var trainNo : String //열차 번호
    var expressYN : String //급행여부 Yes or No
}

struct trainTime{
    var station : String
    var arriveTime : Int
}

struct nealStation{
    var statnNm : String = ""
    var subwayId : String = ""
    var subwayNm : String = ""
    var ord : Int = 0
}

extension String { // 초성을 가져오기 위해 함수 추가
    var hangul: String {
        get {
            let hangle = [ // 초성, 중성, 종성 순
                ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"],
                ["ㅏ","ㅐ","ㅑ","ㅒ","ㅓ","ㅔ","ㅕ","ㅖ","ㅗ","ㅘ","ㅙ","ㅚ","ㅛ","ㅜ","ㅝ","ㅞ","ㅟ","ㅠ","ㅡ","ㅢ","ㅣ"],
                ["","ㄱ","ㄲ","ㄳ","ㄴ","ㄵ","ㄶ","ㄷ","ㄹ","ㄺ","ㄻ","ㄼ","ㄽ","ㄾ","ㄿ","ㅀ","ㅁ","ㅂ","ㅄ","ㅅ","ㅆ","ㅇ","ㅈ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
            ]
            
            return characters.reduce("") { result, char in
                if case let code = Int(String(char).unicodeScalars.reduce(0){$0.0 + $0.1.value}) - 44032
                    where code > -1 && code < 11172 {
                    let cho = code / 21 / 28//, jung = code % (21 * 28) / 28, jong = code % 28;
                    return result + hangle[0][cho]// + hangle[1][jung] + hangle[2][jong]
                }
                return result + String(char)
            }
        }
    }
}


extension UILabel {
    
    func setFontSize (sizeFont: CGFloat) {
        self.font =  UIFont(name: self.font.fontName, size: sizeFont)!
        self.sizeToFit()
    }
    
}

extension UIButton {
    func setFontSize (size : CGFloat){
        self.titleLabel?.font = UIFont(name: self.titleLabel!.font.fontName, size: size)
    }
}

//################################# 부가 기능 함수 #################################

func settingFontSize(mode : Int) -> CGFloat{
    
    if(UIScreen.mainScreen().bounds.size.width == 320.0 && UIScreen.mainScreen().bounds.size.height == 480.0){
        //3.5인치
        switch mode{
        case 0:
            return 14.0 //메인 버튼, 라벨
        case 1:
            return 12.0 //부가 버튼
        case 3:
            return 20 //마지막 페이지 맨위 레이블 constraint
        case 4:
            return 24.0 //마지막 페이지 맨위 레이블
        case 5:
            return 64.0 //마지막 페이지 시간초 레이블
        case 6:
            return 42 //하단바 높이
        case 7:
            return 40 //첫페이지 타이틀
        case 8:
            return 80 //셀 높이
        case 9:
            return 42 //셀 높이2
        case 10:
            return 38 //footer 높이
        case 11:
            return -15 //메인페이지 기차 이미지 constraint
        case 12:
            return 73.5 * 4 //메인페이지 높이 constraint
        case 13:
            return 16 //메인페이지 역 이름
        case 14:
            return 11 //메인페이지 서브 역 이름
        default:
            return 1
        }
    }else if(UIScreen.mainScreen().bounds.size.width == 320.0){
        //4인치
        switch mode{
        case 0:
            return 15.0 //메인 버튼, 라벨
        case 1:
            return 13.0 //부가 버튼
        case 3:
            return 35 //마지막 페이지 맨위 레이블 constraint
        case 4:
            return 24 //마지막 페이지 맨위 레이블
        case 5:
            return 64 //마지막 페이지 시간초 레이블
        case 6:
            return 45 //하단바 높이
        case 7:
            return 43 //첫페이지 타이틀
        case 8:
            return 90 //셀 높이
        case 9:
            return 43 //셀 높이2
        case 10:
            return 39 //footer 높이
        case 11:
            return -20 //메인페이지 기차 이미지 constraint
        case 12:
            return 73.5 * 5 //메인페이지 높이 constraint
        case 13:
            return 16 //메인페이지 역 이름
        case 14:
            return 11 //메인페이지 서브 역 이름
        default:
            return 1
        }
    }else if(UIScreen.mainScreen().bounds.size.width == 375.0){
        
        //4.7인치
        switch mode{
        case 0:
            return 16.0 //메인 버튼, 라벨
        case 1:
            return 14.0 //부가 버튼
        case 3:
            return 45 //마지막 페이지 맨위 레이블 constraint
        case 4:
            return 28 //마지막 페이지 맨위 레이블
        case 5:
            return 72.0 //마지막 페이지 시간초 레이블
        case 6:
            return 50 //하단바 높이
        case 7:
            return 46 //첫페이지 타이틀
        case 8:
            return 100 //셀 높이
        case 9:
            return 44 //셀 높이2
        case 10:
            return 40 //footer 높이
        case 11:
            return -25 //메인페이지 기차 이미지 constraint
        case 12:
            return 86.5 * 5 //메인페이지 높이 constraint
        case 13:
            return 18 //메인페이지 역 이름
        case 14:
            return 13 //메인페이지 서브 역 이름
        default:
            return 1
        }
        
    }else{
        //5.5인치
        switch mode{
        case 0:
            return 17.0 //메인 버튼, 라벨
        case 1:
            return 15.0 //부가 버튼
        case 3:
            return 50 //마지막 페이지 맨위 레이블 constraint
        case 4:
            return 30 //마지막 페이지 맨위 레이블
        case 5:
            return 76.0 //마지막 페이지 시간초 레이블
        case 6:
            return 50 //하단바 높이
        case 7:
            return 49 //첫페이지 타이틀
        case 8:
            return 110 //셀 높이1
        case 9:
            return 45 //셀 높이2
        case 10:
            return 41 //footer 높이
        case 11:
            return -30 //메인페이지 기차 이미지 constraint
        case 12:
            return 95 * 5 //메인페이지 높이 constraint
        case 13:
            return 18 //메인페이지 역 이름
        case 14:
            return 13 //메인페이지 서브 역 이름
        default:
            return 1
        }
    }
    
}

func convertStartToFinishString(let Start start : Int, let Finish finish : Int, let string str : String) -> String{
    
    var count : Int = 1
    var extraText : String = ""
    
    
    for ce in str.characters{
        if(count >= start && count <= finish){
            //count++
            extraText = extraText + String(ce)
            
            if(count == finish){break;}
            count+=1
        }else{count+=1}
        
    }
    
    if(extraText == "1061"){extraText = "1063"}
    
    return extraText
    
}

//문자를 시간초로 변경 ex)15:30:30 -> 55830
func convertStringToSecond(set : String, Mode mode2 : Int) -> Int {
    var mode = mode2
    var time : Int = 0
    var count : Int = 0
    var hour : String = "0"
    var min : String = "0"
    var sec : String = "0"
    
    for ce in set.characters{
        if(ce == "-"){
            mode = 0
        }
    }
    
    switch mode{
    case 1:
        for se in set.characters{
            if(se == ":"){
                count+=1
            }else if(count<2){
                hour = hour + String(se)
                count+=1
            }else if(count<6){
                min = min + String(se)
                count+=1
            }else if(count<10){
                sec = sec + String(se)
                count+=1
            }
        }
        break;
    case 2:
        for se in set.characters{
            if(Int(String(se)) != nil){
                if(count == 0){
                    hour = hour + String(se)
                }else if(count == 1){
                    min = min + String(se)
                }else if(count == 2){
                    sec = sec + String(se)
                }
            }else if(se == "시"){
                count+=1
            }else if(se == "분"){
                count+=1
            }else if(se == "초"){
                count+=1
            }
        }
        break;
    case 3:
        hour = "0"
        for se in set.characters{
            if(Int(String(se)) != nil){
                if(count == 0){
                    min = min + String(se)
                }else if(count == 1){
                    sec = sec + String(se)
                }
            }else if(se == "분"){
                count+=1
            }else if(se == "초"){
                count+=1
            }
        }
        break;
    case 4:
        hour=""
        min=""
        for se in set.characters{
            if(se == ":"){
                count+=1
            }else if(count<2){
                hour = hour + String(se)
                count+=1
            }else if(count<5){
                min = min + String(se)
                count+=1
            }else if(count>=5){
                break;
            }
        }
        break;
    default:
        break;
    }
    
    if(hour == "0" && min == "0" && sec == "0"){
        time = 0
    }else if(hour == "" && min == "" && sec == ""){
        time = 0
    }else{
        time = Int(hour)!*3600 + Int(min)!*60 + Int(sec)!
    }
    
    
    return time
    
}

func removeComma(Name name : String) -> (String, String){
    
    var start : String = ""
    var finish : String = ""
    
    var count : Int = 0
    
    for ce in name.characters{
        if(ce == ","){
            count += 1
        }else{
            if(count == 0){
                start = start + String(ce)
            }else{
                finish = finish + String(ce)
            }
        }
    }
    
    return (start, finish)
    
}

func convertTitle(Title name : String) -> String{
    
    var start : String = ""
    var finish : String = ""
    
    var count : Int = 0
    for ce in name.characters{
        if(ce == ","){
            count += 1
        }else{
            if(count == 0){
                start = start + String(ce)
            }else{
                finish = finish + String(ce)
            }
        }
    }
    
    return start + "역 -> " + finish + "역"
    
}

func removeString(Name name : String) -> String {
    
    var stationYN : Bool = false
    var count : Int = 0
    var count2 : Int = 0
    var tempS : String = ""
    
    for _ in name.characters{
        count += 1
    }
    for ce in name.characters{
        count2+=1
        if(count2 == count){
            if(ce == "역"){
                stationYN = true
            }
        }
    }
    if(stationYN == true){
        
        count2 = 0
        if(stationYN == true){
            for ce in name.characters{
                count2+=1
                if(count2<count){
                    tempS = tempS + String(ce)
                }
            }
        }
        
        return tempS
    }else{
        return name
    }
    
    
}

//시간초를 문자로 변경 ex)55830 -> 15시 30분 30초
func convertSecondToString(let set : Int, let Mode mode : Int) -> String{
    var timeText : String = ""
    
    var hour : Int = 0
    var min : Int = 0
    var sec : Int = 0
    
    hour = set/3600
    min = (set - (hour*3600))/60
    sec = set - hour*3600 - min*60
    
    switch mode{
    case 1:
        if(sec == 0){
            timeText = String(hour) + "시 " + String(min) + "분 " + "00초"
        }else {
            timeText = String(hour) + "시 " + String(min) + "분 " + String(sec) + "초"
        }
        break;
    case 2:
        if(sec >= 30){
            if(min + 1 == 60){hour = hour + 1; min = -1}
            timeText = String(hour) + "시 " + String(min+1) + "분"
        }
        else{ timeText = String(hour) + "시 " + String(min) + "분" }
        break;
    case 3:
        if(hour == 0){
            timeText = String(min) + "분"
        }else{
            timeText = String(hour) + "시간 " + String(min) + "분"
        }
        break;
    case 4:
        min = hour * 60 + min
        timeText = String(min) + "분 " + String(sec) + "초"
        break;
    case 5:
        min = set/60
        timeText = String(min)
        break;
    default:
        break;
    }
    
    
    return timeText
}

func returnCurrentTime() -> Int {
    
    var temp : Int = 0
    
    let now = NSDate()
    let dateFormatter = NSDateFormatter()
    dateFormatter.locale = NSLocale(localeIdentifier: "ko_KR") // 로케일 설정
    
    dateFormatter.dateFormat = "HH"
    if(Int(dateFormatter.stringFromDate(now)) == 0){
        temp = 24
    }else if(Int(dateFormatter.stringFromDate(now)) == 1){
        temp = 25
    }
    
    dateFormatter.dateFormat = "HH:mm:ss" // 날짜 형식 설정
    
    
    let mainCurrentTime = convertStringToSecond(dateFormatter.stringFromDate(now), Mode: 1) + (temp * 3600)
    
    return mainCurrentTime
}

func weekTag() -> String {
    
    let holiday : Array<String> = [
        "01-01",
        "03-01",
        "05-05",
        "05-14",
        "06-06",
        "08-15",
        "10-03",
        "10-09",
        "12-25",
        "02-08",//2016 설날, 추석
        "02-09",
        "02-10",
        "09-14",
        "09-15",
        "09-16"
    ]
    
    //(평일:1, 토요일:2, 휴일/일요일:3)
    
    let now = NSDate()
    let dateFormatter = NSDateFormatter()
    dateFormatter.locale = NSLocale(localeIdentifier: "ko_KR") // 로케일 설정
    
    dateFormatter.dateFormat = "MM-dd"
    let checkHoliday : String = dateFormatter.stringFromDate(now)
    
    var check : Bool = false
    
    for ce in holiday{
        if(checkHoliday == ce){
            check = true
        }
    }
    
    if(check == true){
        return "3"
    }else{
        dateFormatter.dateFormat = "EEE" // 날짜 형식 설정
        let currentTime : String = dateFormatter.stringFromDate(now)
        
        if(currentTime == "일"){
            return "3"
        }else if(currentTime == "토"){
            return "2"
        }else{
            return "1"
        }
    }
}

//################################# 부가 함수 #################################

func checkNetworkApiData(ApiURI apiURI : NSURL) -> NSData?{
    
    
    //let apidata : NSData? = NSData(contentsOfURL: apiURI)!
    
    var data : NSData?
    
    while(true){
        do{
            if(true){
                data = try NSData(contentsOfURL: apiURI, options: [])
                break;
            }else{
                data = nil
            }
        }catch{
            
            data = nil
        }
    }
    
    
    return data
}

func setAllTimeToInfo(Info info2 : Array<SubwayInfo>, Index mainIndex : Int) -> Array<SubwayInfo>{
    
    var info = info2
    info[mainIndex] = setInfoToTrainNo(Info: info[mainIndex])
    
    
    
    var fTime : Int = info[mainIndex].navigateTm[info[mainIndex].navigateTm.count-1]
    
    let fvo = FavoriteVO()
    
    var addTime : Int = fvo.config.objectForKey("addTransTime") as! Int
    
    switch addTime{
    case 0:
        addTime = 30
        break;
    case 1:
        addTime = 60
        break;
    case 2:
        addTime = 120
        break;
    case 3:
        addTime = 180
        break;
    default:
        break;
    }
    
    for i in mainIndex+1..<info.count{
        
        fTime = fTime + addTime
        
        var indexTemp : Int = 0
        for ce in info[i].startSchedule{
            if(ce.arriveTime >= fTime){
                
                break;
            }else{indexTemp += 1}
        }
        
        if(indexTemp == info[i].startSchedule.count){
            info[i].navigateTm.removeAll()
            info[i].expressYN = false
            //indexTemp--
        }else{
            info[i].startTime = info[i].startSchedule[indexTemp].arriveTime
            info[i].startScheduleIndex = indexTemp
            info[i] = setInfoToTrainNo(Info: info[i])
            //info[i].navigateTm[0] = info[i].startTime
            fTime = info[i].navigateTm[info[i].navigateTm.count-1]
        }
        if(fTime == 0){
            break;
        }
        
        
    }
    
    
    
    return info
}



func returnRootApi(StartNm start2 : String, FinishNm finish2 : String, Mode mode2 : Int) -> (Root, Int){
    
    var start = start2
    var finish = finish2
    var mode = mode2
    
    var rootlist : Array<Root> = []
    var mainRow : Root?
    
    
    ////checkNetworkAvailable()
    
    let baseUrl = "http://swopenapi.seoul.go.kr/api/subway/\(KEY)/json/shortestRoute/0/100/"
    let text : String = start + "/" + finish //추후 수정 요망**
    let escapedText = text.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
    let reuqestUrl : String = baseUrl + escapedText!
    let apiURI = NSURL(string: reuqestUrl)
    let apiURL : NSURL = apiURI!
    let apidata : NSData? = checkNetworkApiData(ApiURI: apiURL)//NSData(contentsOfURL: apiURL)
    
    
    do{
        //checkNetworkAvailable()
        
        let apiDictionary = try NSJSONSerialization.JSONObjectWithData(apidata!, options: []) as! NSDictionary
        
        let sub = apiDictionary["shortestRouteList"] as! NSArray
        
        
        
        //row["statnFid"] as! String
        for row in sub{
            
            rootlist.append(
                Root(
                    statnFid: row["statnFid"] as! String,
                    statnTid: row["statnTid"] as! String,
                    shtTravelTm: Int(row["shtTravelTm"] as! String)! * 60,
                    shtTransferCnt: Int(row["shtTransferCnt"] as! String)!,
                    minTravelTm: Int(row["minTravelTm"] as! String)! * 60,
                    minTransferCnt: Int(row["minTransferCnt"] as! String)!,
                    shtStatnId: row["shtStatnId"] as! String,
                    shtStatnNm: row["shtStatnNm"] as! String,
                    minStatnId: row["minStatnId"] as! String,
                    minStatnNm: row["minStatnNm"] as! String
                )
            )
            
            
        }
        
        
        
        var shtTime : Array<Int> = []//최소시간
        var minTime : Array<Int> = []//최소경로
        
        
        for i in 0..<rootlist.count{
            
            shtTime.append(rootlist[i].shtTravelTm + rootlist[i].shtTransferCnt * 60)
            minTime.append(rootlist[i].minTravelTm + rootlist[i].minTransferCnt * 60)
            
        }
        
        
        
        switch mode{
        case 0:
            var sht : Int = shtTime[0]
            var min : Int = minTime[0]
            var indexSht : Int = 0
            var indexMin : Int = 0
            
            for cert in shtTime{
                if(cert < sht){
                    sht = cert
                    indexSht = shtTime.indexOf(sht)!
                }
            }
            
            for cert in minTime{
                if(cert < min){
                    min = cert
                    indexMin = minTime.indexOf(min)!
                }
            }
            
            if(sht <= min){
                mode = 1
                
                mainRow = rootlist[indexSht]
            }else{
                mode = 2
                
                mainRow = rootlist[indexMin]
            }
            
            
            break;
        case 1://최소시간 기준
            
            var sht : Int = shtTime[0]
            var indexSht : Int = 0
            
            for cert in shtTime{
                if(cert < sht){
                    sht = cert
                    indexSht = shtTime.indexOf(sht)!
                }
            }
            
            mode = 1
            mainRow = rootlist[indexSht]
            
            break;
        case 2://최소환승 기준
            
            var min : Int = minTime[0]
            var indexMin : Int = 0
            
            for cert in minTime{
                if(cert < min){
                    min = cert
                    indexMin = minTime.indexOf(min)!
                }
            }
            
            mode = 2
            mainRow = rootlist[indexMin]
            
            break;
        default:
            break;
        }
        
        
        
        
        
        
    }catch{
        
    }
    
    if(mainRow == nil){
        let rowTemp = Root()
        
        return (rowTemp, mode)
    }else{
        
        return (mainRow!, mode)
    }
    
}


//상행인지 하행인지 체크
func checkUpOrDown(StartSTNm startSTNm : String, StartSTId startSTId : String, NextSTNm nextSTNm : String) -> String{
    
    var UpDn : String = ""
    
    ////checkNetworkAvailable()
    
    let baseUrl = "http://swopenapi.seoul.go.kr/api/subway/\(KEY)/json/stationInfo/0/10/\(startSTNm)"
    let escapedText = baseUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
    let apiURI = NSURL(string: escapedText!)
    let apidata : NSData? = checkNetworkApiData(ApiURI: apiURI!)//NSData(contentsOfURL: apiURI!)
    
    do{
        
        //checkNetworkAvailable()
        
        let apiDictionary = try NSJSONSerialization.JSONObjectWithData(apidata!, options: []) as! NSDictionary
        
        let sub = apiDictionary["stationList"] as! NSArray
        
        for row in sub{
            
            if(row["statnId"] as! String == startSTId || convertStartToFinishString(Start: 1, Finish: 4, string: row["statnId"] as! String) == startSTId){
                
                if(row["statnFnm"] as! String == nextSTNm){
                    if(row["subwayNm"] as! String == "2호선" || row["subwayNm"] as! String == "9호선"){
                        UpDn = "0"
                    }else{
                        UpDn = "1"
                    }
                }else{
                    if(row["subwayNm"] as! String == "2호선" || row["subwayNm"] as! String == "9호선"){
                        UpDn = "1"
                    }else{
                        UpDn = "0"
                    }
                    
                }
                
            }
            
        }
    }catch{
        
    }
    
    return UpDn
}


func parsingRoot(minStatNm statNm : Array<String>, minStatId statId : Array<String>) -> Array<SubwayInfo>{
    
    var info : Array<SubwayInfo> = []
    
    var timeArray : Array<Int> = []
    var startschedule : Array<Array<Schedule>> = []
    //var finishschedule : Array<Array<Schedule>> = []
    var subwayIdArray : Array<String> = []
    var updnArray : Array<String> = []
    var mainNmArray : Array<Array<String>> = []
    var mainIdArray : Array<Array<String>> = []
    var tempArray : Array<String> = []
    //var express : Array<Bool> = []
    var subwayIdTemp : String = convertStartToFinishString(Start: 1, Finish: 4, string: statNm[0])
    
    for ce in statId{
        let temp = convertStartToFinishString(Start: 1, Finish: 4, string: ce)
        
        if(temp != subwayIdTemp){
            subwayIdTemp = temp
            tempArray.append(ce)
            mainIdArray.append(tempArray)
            tempArray.removeAll()
            tempArray.append(ce)
        }else{
            tempArray.append(ce)
        }
    }
    mainIdArray.append(tempArray)
    tempArray.removeAll()
    mainIdArray.removeAtIndex(0)
    
    for ce in mainIdArray{
        for te in ce{
            tempArray.append(statNm[statId.indexOf(te)!])
        }
        mainNmArray.append(tempArray)
        tempArray.removeAll()
    }
    
    
    
    
    
    let count = mainIdArray.count
    
    for ce in 0..<count{
        var subwayIdTemp = convertStartToFinishString(Start: 1, Finish: 4, string: mainIdArray[ce][0])
        
        if(subwayIdTemp == "1061"){subwayIdTemp = "1063"}
        
        subwayIdArray.append(subwayIdTemp)
        
        
        
        var updn = checkUpOrDown(StartSTNm: mainNmArray[ce][0], StartSTId: subwayIdTemp, NextSTNm: mainNmArray[ce][1])
        
        
        
        updnArray.append(updn)
        
        let checkExpress : Bool = setExpress(SubwayId: subwayIdTemp, Navigate: mainNmArray[ce])
        
        //시작역
        var scheduleTemp = setTranferTimeBySubwayId2(StationNm: mainNmArray[ce][0], SubwayId: subwayIdTemp, UpDnLine: updn, ExpressCheck: checkExpress)
        
        
        startschedule.append(scheduleTemp)
        
        
        let timeTemp = returnRootApi(StartNm: mainNmArray[ce][0], FinishNm: mainNmArray[ce][mainNmArray[ce].count - 1], Mode: 0).0.shtTravelTm
        timeArray.append(timeTemp)
    }
    
    for ce in 0..<count{
        
        info.append(SubwayInfo(navigate: mainNmArray[ce], navigateId: mainIdArray[ce], copyNavigate: mainNmArray[ce], copyNavigateId: mainIdArray[ce], navigateTm: [], subwayId: subwayIdArray[ce], time: timeArray[ce], copyTime: timeArray[ce], updn: updnArray[ce], startTime: 0, startSchedule: startschedule[ce], startScheduleIndex: 0,/* finishSchedule: finishschedule[ce],*/ expressYN: false, fastExit : ""))
        
    }
    
    for i in 0..<info.count{
        
        if(i+1 == info.count){
            info[i].fastExit = ""
        }else{
            
            let firstNm : String = info[i].navigate[info[i].navigate.count-2]
            let secondNm : String = info[i+1].navigate[1]
            let subwayId : String = info[i+1].subwayId
            
            let firstFastExit = returnFastExit(SubwayId: info[i].subwayId)
            
            let index : Int? = firstFastExit.indexOf({
                
                var check : Bool = false
                
                if($0.toLine == ""){
                    check = ($0.FirstNm == firstNm && $0.SecondNm == secondNm)
                }else{
                    check = $0.FirstNm == firstNm && $0.SecondNm == secondNm && $0.toLine == subwayId
                }
                
                return check
            })
            
            if(index != nil){
                if(firstFastExit[index!].Exit == "20"){
                    info[i].fastExit = "모든문"
                }else{
                    info[i].fastExit = firstFastExit[index!].Exit
                }
            }else{
                info[i].fastExit = ""
            }
        }
        
    }
    
    return info
}

func setTranferTimeBySubwayId2(StationNm stationNm : String, SubwayId subwayId : String, UpDnLine updnLine2 : String, ExpressCheck express : Bool) -> Array<Schedule> {
    
    var updnLine = updnLine2
    
    //if(subwayId == "1061"){subwayId = "1063"}
    //var checkData : Bool = false
    //print(subwayId)
    //var totalCount : Int = 1
    //var realCount : Int = 0
    var tranSchdule : Array<Schedule> = []
    
    let StationList = returnLineList(SubwayId: subwayId)
    
    let StationId = StationList[StationList.indexOf({$0.name == stationNm})!].code
    
    if(updnLine == "0"){updnLine = "2"}
    
    ////checkNetworkAvailable()
    
    let baseUrl = "http://openapi.seoul.go.kr:8088/\(KEY)/json/SearchSTNTimeTableByFRCodeService/1/1000/\(StationId)/\(weekTag())/\(updnLine)/"
    let escapedText = baseUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
    let apiURI = NSURL(string: escapedText!)
    let apidata : NSData? = checkNetworkApiData(ApiURI: apiURI!)//NSData(contentsOfURL: apiURI!)
    
    do{
        
        //checkNetworkAvailable()
        
        
        let apiDictionary = try NSJSONSerialization.JSONObjectWithData(apidata!, options: []) as! NSDictionary
        
        if(apiDictionary["SearchSTNTimeTableByFRCodeService"] as? NSDictionary != nil){
            
            let sub = apiDictionary["SearchSTNTimeTableByFRCodeService"] as! NSDictionary
            
            let sub2 = sub["row"] as! NSArray
            
            for row in sub2{
                
                if(express == true){
                    if(row["ARRIVETIME"] as! String == "00:00:00"){
                        
                        tranSchdule.append(Schedule.init(
                            arriveTime: convertStringToSecond(row["LEFTTIME"] as! String, Mode: 1)-60,//-30,
                            leftTime: convertStringToSecond(row["LEFTTIME"] as! String, Mode: 1),
                            directionNm: row["SUBWAYENAME"] as! String,
                            trainNo:row["TRAIN_NO"] as! String,
                            expressYN: row["EXPRESS_YN"] as! String
                            ))
                        
                    }else if(row["LEFTTIME"] as! String == "99:99:99"){
                        
                    }else{
                        
                        tranSchdule.append(Schedule.init(
                            arriveTime: convertStringToSecond(row["ARRIVETIME"] as! String, Mode: 1),//-30,
                            leftTime: convertStringToSecond(row["LEFTTIME"] as! String, Mode: 1),
                            directionNm: row["SUBWAYENAME"] as! String,
                            trainNo:row["TRAIN_NO"] as! String,
                            expressYN: row["EXPRESS_YN"] as! String
                            ))
                        
                    }
                }else{
                    if(row["ARRIVETIME"] as! String == "00:00:00"){
                        
                        if(row["EXPRESS_YN"] as! String == ""){
                            tranSchdule.append(Schedule.init(
                                arriveTime: convertStringToSecond(row["LEFTTIME"] as! String, Mode: 1)-60,//-30,
                                leftTime: convertStringToSecond(row["LEFTTIME"] as! String, Mode: 1),
                                directionNm: row["SUBWAYENAME"] as! String,
                                trainNo:row["TRAIN_NO"] as! String,
                                expressYN: row["EXPRESS_YN"] as! String
                                ))
                        }
                        
                    }else if(row["LEFTTIME"] as! String == "99:99:99"){
                        
                    }else{
                        
                        if(row["EXPRESS_YN"] as! String == ""){
                            tranSchdule.append(Schedule.init(
                                arriveTime: convertStringToSecond(row["ARRIVETIME"] as! String, Mode: 1),//-30,
                                leftTime: convertStringToSecond(row["LEFTTIME"] as! String, Mode: 1),
                                directionNm: row["SUBWAYENAME"] as! String,
                                trainNo:row["TRAIN_NO"] as! String,
                                expressYN: row["EXPRESS_YN"] as! String
                                ))
                        }
                        
                    }
                }
                
                
            }
            
            
        }else{
            
            
            
        }
        
        
        
        
    }catch{
        
        
        
    }
    
    
    tranSchdule = tranSchdule.sort({$0.arriveTime < $1.arriveTime})
    //print(tranSchdule)
    
    return tranSchdule
}


func setInfoToTrainNo(Info info2 : SubwayInfo) -> SubwayInfo{
    
    var info = info2
    let index : Int = info.startSchedule.indexOf({$0.arriveTime == info.startTime})!
    
    info.navigateTm.removeAll()
    
    info.expressYN = false
    
    let trainNo = info.startSchedule[index].trainNo
    
    if(info.startSchedule[index].expressYN == "Y"){
        info.expressYN = true
        info = setNavigateToExpress(Info: info, SubwayId: info.subwayId)
    }else{
        
        info.navigate = info.copyNavigate
        info.navigateId = info.copyNavigateId
        info.navigateTm.removeAll()
        info.time = info.copyTime
        
    }
    
    
    
    var trainTemp : Array<trainTime> = returnTrainSchedule(TrainNo: trainNo, UpDn: info.updn)
    
    var list : Array<Int> = []
    for _ in 0..<info.navigate.count{
        list.append(0)
    }
    
    
    if(trainTemp.indexOf({$0.arriveTime == "00:00:00"}) != nil){
        trainTemp.removeAtIndex(trainTemp.indexOf({$0.arriveTime == "00:00:00"})!)
    }
    
    for row in trainTemp{
        if(info.navigate.indexOf(row.station) != nil){
            let index : Int = info.navigate.indexOf(row.station)!
            
            list[index] = row.arriveTime
        }
        
    }
    list[0] = info.startTime
    
    var count : Int = -1
    
    for i in 1..<list.count{
        //count++
        if(list[i-1] > list[i]){
            count = i
            break;
        }
        
    }
    
    if(count >= 0){
        
        trainTemp.removeAll()
        
        let index : Int = count
        
        let previousTime : Int = list[index-1]
        
        let schedule = setTranferTimeBySubwayId2(StationNm: info.navigate[index], SubwayId: info.subwayId, UpDnLine: info.updn, ExpressCheck: info.expressYN)
        
        for i in 0..<schedule.count{
            
            if(schedule[i].arriveTime > previousTime){
                trainTemp = returnTrainSchedule(TrainNo: schedule[i].trainNo, UpDn: info.updn)
                break;
            }
            
        }
        
        for i in index..<list.endIndex{
            
            let index2 : Int? = trainTemp.indexOf({$0.station == info.navigate[i]})
            
            if(index2 != nil){
                list[i] = trainTemp[index2!].arriveTime
            }
            
        }
    }
    
    
    info.navigateTm = list
    
    if(info.expressYN == true){
        info.time = info.navigateTm[info.navigateTm.count-1] - info.startTime
    }
    
    return info
}

func returnTrainSchedule(TrainNo trainNo : String, UpDn updn2 : String) -> Array<trainTime>{
    var updn = updn2
    
    var trainTemp : Array<trainTime> = []
    
    if(updn == "0"){updn = "2"}
    
    //checkNetworkAvailable()
    
    let baseUrl = "http://openapi.seoul.go.kr:8088/\(KEY)/json/SearchViaSTNArrivalTimeByTrainService/1/1000/\(trainNo)/\(weekTag())/\(updn)/"
    let escapedText = baseUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
    let apiURI = NSURL(string: escapedText!)
    let apidata : NSData? = checkNetworkApiData(ApiURI: apiURI!)//NSData(contentsOfURL: apiURI!)
    
    do{
        
        //checkNetworkAvailable()
        
        let apiDictionary = try NSJSONSerialization.JSONObjectWithData(apidata!, options: []) as! NSDictionary
        
        let sub = apiDictionary["SearchViaSTNArrivalTimeByTrainService"] as! NSDictionary
        let sub2 = sub["row"] as! NSArray
        
        for row in sub2{
            
            trainTemp.append(trainTime(station: row["STATION_NM"] as! String, arriveTime: convertStringToSecond(row["ARRIVETIME"] as! String, Mode: 1) ))
        }
        
        trainTemp = trainTemp.sort({$0.arriveTime < $1.arriveTime})
        
    }catch{
        
    }
    
    return trainTemp
}


extension UIView {
    
    func setWidth(width:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.width = width
        self.frame = frame
    }
    
    func setHeight(height:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.height = height
        self.frame = frame
    }
}


































