import Foundation
import UIKit

func returnLineColor(SubwayId subwayId : String) -> UIColor {
    
    
    var color : UIColor = UIColor.whiteColor()
    
    switch subwayId
    {
    case "1001" :
        color = UIColor(red: 37/255, green: 58/255, blue: 127/255, alpha: 1.0)
        break;
    case "1002" :
        color = UIColor(red: 0/255, green: 163/255, blue: 83/255, alpha: 1/0)
        break;
    case "1003" :
        color = UIColor(red: 229/255, green: 121/255, blue: 55/255, alpha: 1.0)
        break;
    case "1004" :
        color = UIColor(red: 0/255, green: 165/255, blue: 216/255, alpha: 1.0)
        break;
    case "1005" :
        color = UIColor(red: 146/255, green: 80/255, blue: 141/255, alpha: 1.0)
        break;
    case "1006" :
        color = UIColor(red: 189/255, green: 130/255, blue: 65/255, alpha: 1.0)
        break;
    case "1007" :
        color = UIColor(red: 99/255, green: 109/255, blue: 65/255, alpha: 1.0)
        break;
    case "1008" :
        color = UIColor(red: 222/255, green: 85/255, blue: 110/255, alpha: 1.0)
        break;
    case "1009" :
        color = UIColor(red: 168/255, green: 134/255, blue: 65/255, alpha: 1.0)
        break;
    case "1069" : //인천 1호선
        color = UIColor(red: 100/255, green: 145/255, blue: 189/255, alpha: 1.0)
        break;
    case "1063" : //경의중앙선
        color = UIColor(red: 113/255, green: 189/255, blue: 156/255, alpha: 1.0)
        break;
    case "1075" : //분당선
        color = UIColor(red: 247/255, green: 197/255, blue: 58/255, alpha: 1.0)
        break;
    case "1065" : //공항철도
        color = UIColor(red: 0/255, green: 138/255, blue: 150/255, alpha: 1.0)
        break;
    case "1067" : //경춘선
        color = UIColor(red: 0/255, green: 134/255, blue: 140/255, alpha: 1.0)
        break;
    case "1077" : //신분당선
        color = UIColor(red: 178/255, green: 51/255, blue: 63/255, alpha: 1.0)
        break;
    case "1071" : //수인선
        color = UIColor(red: 241/255, green: 177/255, blue: 59/255, alpha: 1.0)
        break;
    default :
        break;
    }
    
    return color
}

func returnLineName(SubwayId subwayId : String) -> String{
    
    
    var name : String = ""
    
    switch subwayId
    {
    case "1001" :
        name = "1호선"
        break;
    case "1002" :
        name = "2호선"
        break;
    case "1003" :
        name = "3호선"
        break;
    case "1004" :
        name = "4호선"
        break;
    case "1005" :
        name = "5호선"
        break;
    case "1006" :
        name = "6호선"
        break;
    case "1007" :
        name = "7호선"
        break;
    case "1008" :
        name = "8호선"
        break;
    case "1009" :
        name = "9호선"
        break;
    case "1069" :
        name = "인천 1호선"
        break;
    case "1063" :
        name = "경의중앙선"
        break;
    case "1075" :
        name = "분당선"
        break;
    case "1065" :
        name = "공항철도"
        break;
    case "1067" :
        name = "경춘선"
        break;
    case "1077" :
        name = "신분당선"
        break;
    case "1071" :
        name = "수인선"
        break;
    default :
        break;
    }
    
    return name
}

struct StationNm{
    var line : String
    var name : String
    var code : String
}

func returnLineList(SubwayId subwayId : String) -> Array<StationNm>{
    
    let line : Array<StationNm> = [
        //StationNm(line: "1001", name: "소요산", code: "100"),
    ]
    
    var list : Array<StationNm> = line
    
    if(subwayId == ""){
        
    }else{
        list = line.filter({$0.line == subwayId})
    }
    
    
    
    return list
}