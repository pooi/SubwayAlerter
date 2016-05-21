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
        StationNm(line: "1001", name: "소요산", code: "100"),
        StationNm(line: "1001", name: "동두천", code: "101"),
        StationNm(line: "1001", name:"보산", code: "102"),
        StationNm(line: "1001", name:"동두천중앙", code: "103"),
        StationNm(line: "1001", name:"지행", code: "104"),
        StationNm(line: "1001", name:"덕정", code: "105"),
        StationNm(line: "1001", name:"덕계", code: "106"),
        StationNm(line: "1001", name:"양주", code: "107"),
        StationNm(line: "1001", name:"녹양", code: "108"),
        StationNm(line: "1001", name:"가능", code: "109"),
        StationNm(line: "1001", name:"의정부", code: "110"),
        StationNm(line: "1001", name:"회룡", code: "111"),
        StationNm(line: "1001", name:"망월사", code: "112"),
        StationNm(line: "1001", name:"도봉산", code: "113"),
        StationNm(line: "1001", name:"도봉", code: "114"),
        StationNm(line: "1001", name:"방학", code: "115"),
        StationNm(line: "1001", name:"창동", code: "116"),
        StationNm(line: "1001", name:"녹천", code: "117"),
        StationNm(line: "1001", name:"월계", code: "118"),
        StationNm(line: "1001", name:"광운대", code: "119"),
        StationNm(line: "1001", name:"석계", code: "120"),
        StationNm(line: "1001", name:"신이문", code: "121"),
        StationNm(line: "1001", name:"외대앞", code: "122"),
        StationNm(line: "1001", name:"회기", code: "123"),
        StationNm(line: "1001", name:"청량리", code: "124"),
        StationNm(line: "1001", name:"제기동", code: "125"),
        StationNm(line: "1001", name:"신설동", code: "126"),
        StationNm(line: "1001", name:"동묘앞", code: "127"),
        StationNm(line: "1001", name:"동대문", code: "128"),
        StationNm(line: "1001", name:"종로5가", code: "129"),
        StationNm(line: "1001", name:"종로3가", code: "130"),
        StationNm(line: "1001", name:"종각", code: "131"),
        StationNm(line: "1001", name:"시청", code: "132"),
        StationNm(line: "1001", name:"서울", code: "133"),
        StationNm(line: "1001", name:"남영", code: "134"),
        StationNm(line: "1001", name:"용산", code: "135"),
        StationNm(line: "1001", name:"노량진", code: "136"),
        StationNm(line: "1001", name:"대방", code: "137"),
        StationNm(line: "1001", name:"신길", code: "138"),
        StationNm(line: "1001", name:"영등포", code: "139"),
        StationNm(line: "1001", name:"신도림", code: "140"),
        StationNm(line: "1001", name:"구로", code: "141"),
        StationNm(line: "1001", name:"구일", code: "142"),
        StationNm(line: "1001", name:"개봉", code: "143"),
        StationNm(line: "1001", name:"오류동", code: "144"),
        StationNm(line: "1001", name:"온수", code: "145"),
        StationNm(line: "1001", name:"역곡", code: "146"),
        StationNm(line: "1001", name:"소사", code: "147"),
        StationNm(line: "1001", name:"부천", code: "148"),
        StationNm(line: "1001", name:"중동", code: "149"),
        StationNm(line: "1001", name:"송내", code: "150"),
        StationNm(line: "1001", name:"부개", code: "151"),
        StationNm(line: "1001", name:"부평", code: "152"),
        StationNm(line: "1001", name:"백운", code: "153"),
        StationNm(line: "1001", name:"동암", code: "154"),
        StationNm(line: "1001", name:"간석", code: "155"),
        StationNm(line: "1001", name:"주안", code: "156"),
        StationNm(line: "1001", name:"도화", code: "157"),
        StationNm(line: "1001", name:"제물포", code: "158"),
        StationNm(line: "1001", name:"도원", code: "159"),
        StationNm(line: "1001", name:"동인천", code: "160"),
        StationNm(line: "1001", name:"인천", code: "161"),
        StationNm(line: "1001", name:"가산디지털단지", code: "P142"),
        StationNm(line: "1001", name:"독산", code: "P143"),
        StationNm(line: "1001", name:"금천구청", code: "P144"),
        StationNm(line: "1001", name:"광명", code: "K410"),
        StationNm(line: "1001", name:"석수", code: "P145"),
        StationNm(line: "1001", name:"관악", code: "P146"),
        StationNm(line: "1001", name:"안양", code: "P147"),
        StationNm(line: "1001", name:"명학", code: "P148"),
        StationNm(line: "1001", name:"금정", code: "P149"),
        StationNm(line: "1001", name:"군포", code: "P150"),
        StationNm(line: "1001", name:"당정", code: "P151"),
        StationNm(line: "1001", name:"의왕", code: "P152"),
        StationNm(line: "1001", name:"성균관대", code: "P153"),
        StationNm(line: "1001", name:"화서", code: "P154"),
        StationNm(line: "1001", name:"수원", code: "P155"),
        StationNm(line: "1001", name:"세류", code: "P156"),
        StationNm(line: "1001", name:"병점", code: "P157"),
        StationNm(line: "1001", name:"서동탄", code: "P157-1"),
        StationNm(line: "1001", name:"세마", code: "P158"),
        StationNm(line: "1001", name:"오산대", code: "P159"),
        StationNm(line: "1001", name:"오산", code: "P160"),
        StationNm(line: "1001", name:"진위", code: "P161"),
        StationNm(line: "1001", name:"송탄", code: "P162"),
        StationNm(line: "1001", name:"서정리", code: "P163"),
        StationNm(line: "1001", name:"지제", code: "P164"),
        StationNm(line: "1001", name:"평택", code: "P165"),
        StationNm(line: "1001", name:"성환", code: "P166"),
        StationNm(line: "1001", name:"직산", code: "P167"),
        StationNm(line: "1001", name:"두정", code: "P168"),
        StationNm(line: "1001", name:"천안", code: "P169"),
        StationNm(line: "1001", name:"봉명", code: "P170"),
        StationNm(line: "1001", name:"쌍용(나사렛대)", code: "P171"),
        StationNm(line: "1001", name:"아산", code: "P172"),
        StationNm(line: "1001", name:"탕정", code: "P173"),
        StationNm(line: "1001", name:"배방", code: "P174"),
        StationNm(line: "1001", name:"풍기", code: "P175"),
        StationNm(line: "1001", name:"온양온천", code: "P176"),
        StationNm(line: "1001", name:"신창", code: "P177"), //1호선
        StationNm(line: "1002", name: "시청", code: "201"),
        StationNm(line: "1002", name: "을지로입구", code: "202"),
        StationNm(line: "1002", name:"을지로3가", code: "203"),
        StationNm(line: "1002", name:"을지로4가", code: "204"),
        StationNm(line: "1002", name:"동대문역사문화공원", code: "205"),
        StationNm(line: "1002", name:"신당", code: "206"),
        StationNm(line: "1002", name:"상왕십리", code: "207"),
        StationNm(line: "1002", name:"왕십리", code: "208"),
        StationNm(line: "1002", name:"한양대", code: "209"),
        StationNm(line: "1002", name:"뚝섬", code: "210"),
        StationNm(line: "1002", name:"성수", code: "211"),
        StationNm(line: "1002", name:"용답", code: "211-1"),
        StationNm(line: "1002", name:"신답", code: "211-2"),
        StationNm(line: "1002", name:"용두", code: "211-3"),
        StationNm(line: "1002", name:"신설동", code: "211-4"),
        StationNm(line: "1002", name:"건대입구", code: "212"),
        StationNm(line: "1002", name:"구의", code: "213"),
        StationNm(line: "1002", name:"강변", code: "214"),
        StationNm(line: "1002", name:"잠실나루", code: "215"),
        StationNm(line: "1002", name:"잠실", code: "216"),
        StationNm(line: "1002", name:"신천", code: "217"),
        StationNm(line: "1002", name:"종합운동장", code: "218"),
        StationNm(line: "1002", name:"삼성", code: "219"),
        StationNm(line: "1002", name:"선릉", code: "220"),
        StationNm(line: "1002", name:"역삼", code: "221"),
        StationNm(line: "1002", name:"강남", code: "222"),
        StationNm(line: "1002", name:"교대", code: "223"),
        StationNm(line: "1002", name:"서초", code: "224"),
        StationNm(line: "1002", name:"방배", code: "225"),
        StationNm(line: "1002", name:"사당", code: "226"),
        StationNm(line: "1002", name:"낙성대", code: "227"),
        StationNm(line: "1002", name:"서울대입구", code: "228"),
        StationNm(line: "1002", name:"봉천", code: "229"),
        StationNm(line: "1002", name:"신림", code: "230"),
        StationNm(line: "1002", name:"신대방", code: "231"),
        StationNm(line: "1002", name:"구로디지털단지", code: "232"),
        StationNm(line: "1002", name:"대림", code: "233"),
        StationNm(line: "1002", name:"신도림", code: "234"),
        StationNm(line: "1002", name:"도림천", code: "234-1"),
        StationNm(line: "1002", name:"양천구청", code: "234-2"),
        StationNm(line: "1002", name:"신정네거리", code: "234-3"),
        StationNm(line: "1002", name:"까치산", code: "234-4"),
        StationNm(line: "1002", name:"문래", code: "235"),
        StationNm(line: "1002", name:"영등포구청", code: "236"),
        StationNm(line: "1002", name:"당산", code: "237"),
        StationNm(line: "1002", name:"합정", code: "238"),
        StationNm(line: "1002", name:"홍대입구", code: "239"),
        StationNm(line: "1002", name:"신촌", code: "240"),
        StationNm(line: "1002", name:"이대", code: "241"),
        StationNm(line: "1002", name:"아현", code: "242"),
        StationNm(line: "1002", name:"충정로", code: "243"),//2호선
        StationNm(line: "1003", name: "대화", code: "310"),
        StationNm(line: "1003", name: "주엽", code: "311"),
        StationNm(line: "1003", name:"정발산", code: "312"),
        StationNm(line: "1003", name:"마두", code: "313"),
        StationNm(line: "1003", name:"백석", code: "314"),
        StationNm(line: "1003", name:"대곡", code: "315"),
        StationNm(line: "1003", name:"화정", code: "316"),
        StationNm(line: "1003", name:"원당", code: "317"),
        StationNm(line: "1003", name:"원흥", code: "309"),
        StationNm(line: "1003", name:"삼송", code: "318"),
        StationNm(line: "1003", name:"지축", code: "319"),
        StationNm(line: "1003", name:"구파발", code: "320"),
        StationNm(line: "1003", name:"연신내", code: "321"),
        StationNm(line: "1003", name:"불광", code: "322"),
        StationNm(line: "1003", name:"녹번", code: "323"),
        StationNm(line: "1003", name:"홍제", code: "324"),
        StationNm(line: "1003", name:"무악재", code: "325"),
        StationNm(line: "1003", name:"독립문", code: "326"),
        StationNm(line: "1003", name:"경복궁", code: "327"),
        StationNm(line: "1003", name:"안국", code: "328"),
        StationNm(line: "1003", name:"종로3가", code: "329"),
        StationNm(line: "1003", name:"을지로3가", code: "330"),
        StationNm(line: "1003", name:"충무로", code: "331"),
        StationNm(line: "1003", name:"동대입구", code: "332"),
        StationNm(line: "1003", name:"약수", code: "333"),
        StationNm(line: "1003", name:"금호", code: "334"),
        StationNm(line: "1003", name:"옥수", code: "335"),
        StationNm(line: "1003", name:"압구정", code: "336"),
        StationNm(line: "1003", name:"신사", code: "337"),
        StationNm(line: "1003", name:"잠원", code: "338"),
        StationNm(line: "1003", name:"고속터미널", code: "339"),
        StationNm(line: "1003", name:"교대", code: "340"),
        StationNm(line: "1003", name:"남부터미널", code: "341"),
        StationNm(line: "1003", name:"양재", code: "342"),
        StationNm(line: "1003", name:"매봉", code: "343"),
        StationNm(line: "1003", name:"도곡", code: "344"),
        StationNm(line: "1003", name:"대치", code: "345"),
        StationNm(line: "1003", name:"학여울", code: "346"),
        StationNm(line: "1003", name:"대청", code: "347"),
        StationNm(line: "1003", name:"일원", code: "348"),
        StationNm(line: "1003", name:"수서", code: "349"),
        StationNm(line: "1003", name:"가락시장", code: "350"),
        StationNm(line: "1003", name:"경찰병원", code: "351"),
        StationNm(line: "1003", name:"오금", code: "352"),//3호선
        StationNm(line: "1004", name: "당고개", code: "409"),
        StationNm(line: "1004", name: "상계", code: "410"),
        StationNm(line: "1004", name:"노원", code: "411"),
        StationNm(line: "1004", name:"창동", code: "412"),
        StationNm(line: "1004", name:"쌍문", code: "413"),
        StationNm(line: "1004", name:"수유", code: "414"),
        StationNm(line: "1004", name:"미아", code: "415"),
        StationNm(line: "1004", name:"미아사거리", code: "416"),
        StationNm(line: "1004", name:"길음", code: "417"),
        StationNm(line: "1004", name:"성신여대입구", code: "418"),
        StationNm(line: "1004", name:"한성대입구", code: "419"),
        StationNm(line: "1004", name:"혜화", code: "420"),
        StationNm(line: "1004", name:"동대문", code: "421"),
        StationNm(line: "1004", name:"동대문역사문화공원", code: "422"),
        StationNm(line: "1004", name:"충무로", code: "423"),
        StationNm(line: "1004", name:"명동", code: "424"),
        StationNm(line: "1004", name:"회현", code: "425"),
        StationNm(line: "1004", name:"서울", code: "426"),
        StationNm(line: "1004", name:"숙대입구", code: "427"),
        StationNm(line: "1004", name:"삼각지", code: "428"),
        StationNm(line: "1004", name:"신용산", code: "429"),
        StationNm(line: "1004", name:"이촌", code: "430"),
        StationNm(line: "1004", name:"동작", code: "431"),
        StationNm(line: "1004", name:"총신대입구(이수)", code: "432"),
        StationNm(line: "1004", name:"사당", code: "433"),
        StationNm(line: "1004", name:"남태령", code: "434"),
        StationNm(line: "1004", name:"선바위", code: "435"),
        StationNm(line: "1004", name:"경마공원", code: "436"),
        StationNm(line: "1004", name:"대공원", code: "437"),
        StationNm(line: "1004", name:"과천", code: "438"),
        StationNm(line: "1004", name:"정부과천청사", code: "439"),
        StationNm(line: "1004", name:"인덕원", code: "440"),
        StationNm(line: "1004", name:"평촌", code: "441"),
        StationNm(line: "1004", name:"범계", code: "442"),
        StationNm(line: "1004", name:"금정", code: "443"),
        StationNm(line: "1004", name:"산본", code: "444"),
        StationNm(line: "1004", name:"수리산", code: "445"),
        StationNm(line: "1004", name:"대야미", code: "446"),
        StationNm(line: "1004", name:"반월", code: "447"),
        StationNm(line: "1004", name:"상록수", code: "448"),
        StationNm(line: "1004", name:"한대앞", code: "449"),
        StationNm(line: "1004", name:"중앙", code: "450"),
        StationNm(line: "1004", name:"고잔", code: "451"),
        StationNm(line: "1004", name:"초지", code: "452"),
        StationNm(line: "1004", name:"안산", code: "453"),
        StationNm(line: "1004", name:"신길온천", code: "454"),
        StationNm(line: "1004", name:"정왕", code: "455"),
        StationNm(line: "1004", name:"오이도", code: "456"),//4호선
        StationNm(line: "1005", name: "방화", code: "510"),
        StationNm(line: "1005", name: "개화산", code: "511"),
        StationNm(line: "1005", name:"김포공항", code: "512"),
        StationNm(line: "1005", name:"송정", code: "513"),
        StationNm(line: "1005", name:"마곡", code: "514"),
        StationNm(line: "1005", name:"발산", code: "515"),
        StationNm(line: "1005", name:"우장산", code: "516"),
        StationNm(line: "1005", name:"화곡", code: "517"),
        StationNm(line: "1005", name:"까치산", code: "518"),
        StationNm(line: "1005", name:"신정", code: "519"),
        StationNm(line: "1005", name:"목동", code: "520"),
        StationNm(line: "1005", name:"오목교", code: "521"),
        StationNm(line: "1005", name:"양평", code: "522"),
        StationNm(line: "1005", name:"영등포구청", code: "523"),
        StationNm(line: "1005", name:"영등포시장", code: "524"),
        StationNm(line: "1005", name:"신길", code: "525"),
        StationNm(line: "1005", name:"여의도", code: "526"),
        StationNm(line: "1005", name:"여의나루", code: "527"),
        StationNm(line: "1005", name:"마포", code: "528"),
        StationNm(line: "1005", name:"공덕", code: "529"),
        StationNm(line: "1005", name:"애오개", code: "530"),
        StationNm(line: "1005", name:"충정로", code: "531"),
        StationNm(line: "1005", name:"서대문", code: "532"),
        StationNm(line: "1005", name:"광화문", code: "533"),
        StationNm(line: "1005", name:"종로3가", code: "534"),
        StationNm(line: "1005", name:"을지로4가", code: "535"),
        StationNm(line: "1005", name:"동대문역사문화공원", code: "536"),
        StationNm(line: "1005", name:"청구", code: "537"),
        StationNm(line: "1005", name:"신금호", code: "538"),
        StationNm(line: "1005", name:"행당", code: "539"),
        StationNm(line: "1005", name:"왕십리", code: "540"),
        StationNm(line: "1005", name:"마장", code: "541"),
        StationNm(line: "1005", name:"답십리", code: "542"),
        StationNm(line: "1005", name:"장한평", code: "543"),
        StationNm(line: "1005", name:"군자", code: "544"),
        StationNm(line: "1005", name:"아차산", code: "545"),
        StationNm(line: "1005", name:"광나루", code: "546"),
        StationNm(line: "1005", name:"천호", code: "547"),
        StationNm(line: "1005", name:"강동", code: "548"),
        StationNm(line: "1005", name:"길동", code: "549"),
        StationNm(line: "1005", name:"굽은다리", code: "550"),
        StationNm(line: "1005", name:"명일", code: "551"),
        StationNm(line: "1005", name:"고덕", code: "552"),
        StationNm(line: "1005", name:"상일동", code: "553"),
        StationNm(line: "1005", name:"둔촌동", code: "P549"),
        StationNm(line: "1005", name:"올림픽공원", code: "P550"),
        StationNm(line: "1005", name:"방이", code: "P551"),
        StationNm(line: "1005", name:"오금", code: "P552"),
        StationNm(line: "1005", name:"개롱", code: "P553"),
        StationNm(line: "1005", name:"거여", code: "P554"),
        StationNm(line: "1005", name:"마천", code: "P555"),//5호선
        StationNm(line: "1006", name: "응암", code: "610"),
        StationNm(line: "1006", name: "역촌", code: "611"),
        StationNm(line: "1006", name:"불광", code: "612"),
        StationNm(line: "1006", name:"독바위", code: "613"),
        StationNm(line: "1006", name:"연신내", code: "614"),
        StationNm(line: "1006", name:"구산", code: "615"),
        StationNm(line: "1006", name:"새절", code: "616"),
        StationNm(line: "1006", name:"증산", code: "617"),
        StationNm(line: "1006", name:"디지털미디어시티", code: "618"),
        StationNm(line: "1006", name:"월드컵경기장", code: "619"),
        StationNm(line: "1006", name:"마포구청", code: "620"),
        StationNm(line: "1006", name:"망원", code: "621"),
        StationNm(line: "1006", name:"합정", code: "622"),
        StationNm(line: "1006", name:"상수", code: "623"),
        StationNm(line: "1006", name:"광흥창", code: "624"),
        StationNm(line: "1006", name:"대흥", code: "625"),
        StationNm(line: "1006", name:"공덕", code: "626"),
        StationNm(line: "1006", name:"효창공원앞", code: "627"),
        StationNm(line: "1006", name:"삼각지", code: "628"),
        StationNm(line: "1006", name:"녹사평", code: "629"),
        StationNm(line: "1006", name:"이태원", code: "630"),
        StationNm(line: "1006", name:"한강진", code: "631"),
        StationNm(line: "1006", name:"버티고개", code: "632"),
        StationNm(line: "1006", name:"약수", code: "633"),
        StationNm(line: "1006", name:"청구", code: "634"),
        StationNm(line: "1006", name:"신당", code: "635"),
        StationNm(line: "1006", name:"동묘앞", code: "636"),
        StationNm(line: "1006", name:"창신", code: "637"),
        StationNm(line: "1006", name:"보문", code: "638"),
        StationNm(line: "1006", name:"안암", code: "639"),
        StationNm(line: "1006", name:"고려대", code: "640"),
        StationNm(line: "1006", name:"월곡", code: "641"),
        StationNm(line: "1006", name:"상월곡", code: "642"),
        StationNm(line: "1006", name:"돌곶이", code: "643"),
        StationNm(line: "1006", name:"석계", code: "644"),
        StationNm(line: "1006", name:"태릉입구", code: "645"),
        StationNm(line: "1006", name:"화랑대", code: "646"),
        StationNm(line: "1006", name:"봉화산", code: "647"),//6호선
        StationNm(line: "1007", name: "장암", code: "709"),
        StationNm(line: "1007", name: "도봉산", code: "710"),
        StationNm(line: "1007", name:"수락산", code: "711"),
        StationNm(line: "1007", name:"마들", code: "712"),
        StationNm(line: "1007", name:"노원", code: "713"),
        StationNm(line: "1007", name:"중계", code: "714"),
        StationNm(line: "1007", name:"하계", code: "715"),
        StationNm(line: "1007", name:"공릉", code: "716"),
        StationNm(line: "1007", name:"태릉입구", code: "717"),
        StationNm(line: "1007", name:"먹골", code: "718"),
        StationNm(line: "1007", name:"중화", code: "719"),
        StationNm(line: "1007", name:"상봉", code: "720"),
        StationNm(line: "1007", name:"면목", code: "721"),
        StationNm(line: "1007", name:"사가정", code: "722"),
        StationNm(line: "1007", name:"용마산", code: "723"),
        StationNm(line: "1007", name:"중곡", code: "724"),
        StationNm(line: "1007", name:"군자", code: "725"),
        StationNm(line: "1007", name:"어린이대공원", code: "726"),
        StationNm(line: "1007", name:"건대입구", code: "727"),
        StationNm(line: "1007", name:"뚝섬유원지", code: "728"),
        StationNm(line: "1007", name:"청담", code: "729"),
        StationNm(line: "1007", name:"강남구청", code: "730"),
        StationNm(line: "1007", name:"학동", code: "731"),
        StationNm(line: "1007", name:"논현", code: "732"),
        StationNm(line: "1007", name:"반포", code: "733"),
        StationNm(line: "1007", name:"고속터미널", code: "734"),
        StationNm(line: "1007", name:"내방", code: "735"),
        StationNm(line: "1007", name:"총신대입구(이수)", code: "736"),
        StationNm(line: "1007", name:"남성", code: "737"),
        StationNm(line: "1007", name:"숭실대입구", code: "738"),
        StationNm(line: "1007", name:"상도", code: "739"),
        StationNm(line: "1007", name:"장승배기", code: "740"),
        StationNm(line: "1007", name:"신대방삼거리", code: "741"),
        StationNm(line: "1007", name:"보라매", code: "742"),
        StationNm(line: "1007", name:"신풍", code: "743"),
        StationNm(line: "1007", name:"대림", code: "744"),
        StationNm(line: "1007", name:"남구로", code: "745"),
        StationNm(line: "1007", name:"가산디지털단지", code: "746"),
        StationNm(line: "1007", name:"철산", code: "747"),
        StationNm(line: "1007", name:"광명사거리", code: "748"),
        StationNm(line: "1007", name:"천왕", code: "749"),
        StationNm(line: "1007", name:"온수", code: "750"),
        StationNm(line: "1007", name:"까치울", code: "751"),
        StationNm(line: "1007", name:"부천종합운동장", code: "752"),
        StationNm(line: "1007", name:"춘의", code: "753"),
        StationNm(line: "1007", name:"신중동", code: "754"),
        StationNm(line: "1007", name:"부천시청", code: "755"),
        StationNm(line: "1007", name:"상동", code: "756"),
        StationNm(line: "1007", name:"삼산체육관", code: "757"),
        StationNm(line: "1007", name:"굴포천", code: "758"),
        StationNm(line: "1007", name:"부평구청", code: "759"),//7호선
        StationNm(line: "1008", name: "암사", code: "810"),
        StationNm(line: "1008", name: "천호", code: "811"),
        StationNm(line: "1008", name:"강동구청", code: "812"),
        StationNm(line: "1008", name:"몽촌토성", code: "813"),
        StationNm(line: "1008", name:"잠실", code: "814"),
        StationNm(line: "1008", name:"석촌", code: "815"),
        StationNm(line: "1008", name:"송파", code: "816"),
        StationNm(line: "1008", name:"가락시장", code: "817"),
        StationNm(line: "1008", name:"문정", code: "818"),
        StationNm(line: "1008", name:"장지", code: "819"),
        StationNm(line: "1008", name:"복정", code: "820"),
        StationNm(line: "1008", name:"산성", code: "821"),
        StationNm(line: "1008", name:"남한산성입구", code: "822"),
        StationNm(line: "1008", name:"단대오거리", code: "823"),
        StationNm(line: "1008", name:"신흥", code: "824"),
        StationNm(line: "1008", name:"수진", code: "825"),
        StationNm(line: "1008", name:"모란", code: "826"),//8호선
        StationNm(line: "1009", name: "개화", code: "901"),
        StationNm(line: "1009", name: "김포공항", code: "902"),
        StationNm(line: "1009", name:"공항시장", code: "903"),
        StationNm(line: "1009", name:"신방화", code: "904"),
        StationNm(line: "1009", name:"마곡나루", code: "905"),
        StationNm(line: "1009", name:"양천향교", code: "906"),
        StationNm(line: "1009", name:"가양", code: "907"),
        StationNm(line: "1009", name:"증미", code: "908"),
        StationNm(line: "1009", name:"등촌", code: "909"),
        StationNm(line: "1009", name:"염창", code: "910"),
        StationNm(line: "1009", name:"신목동", code: "911"),
        StationNm(line: "1009", name:"선유도", code: "912"),
        StationNm(line: "1009", name:"당산", code: "913"),
        StationNm(line: "1009", name:"국회의사당", code: "914"),
        StationNm(line: "1009", name:"여의도", code: "915"),
        StationNm(line: "1009", name:"샛강", code: "916"),
        StationNm(line: "1009", name:"노량진", code: "917"),
        StationNm(line: "1009", name:"노들", code: "918"),
        StationNm(line: "1009", name:"흑석", code: "919"),
        StationNm(line: "1009", name:"동작", code: "920"),
        StationNm(line: "1009", name:"구반포", code: "921"),
        StationNm(line: "1009", name:"신반포", code: "922"),
        StationNm(line: "1009", name:"고속터미널", code: "923"),
        StationNm(line: "1009", name:"사평", code: "924"),
        StationNm(line: "1009", name:"신논현", code: "925"),
        StationNm(line: "1009", name:"언주", code: "926"),
        StationNm(line: "1009", name:"선정릉", code: "927"),
        StationNm(line: "1009", name:"삼성중앙", code: "928"),
        StationNm(line: "1009", name:"봉은사", code: "929"),
        StationNm(line: "1009", name:"종합운동장", code: "930"),//9호선
        StationNm(line: "1065", name: "서울", code: "A01"),
        StationNm(line: "1065", name: "공덕", code: "A02"),
        StationNm(line: "1065", name:"홍대입구", code: "A03"),
        StationNm(line: "1065", name:"디지털미디어시티", code: "A04"),
        StationNm(line: "1065", name:"김포공항", code: "A05"),
        StationNm(line: "1065", name:"계양", code: "A06"),
        StationNm(line: "1065", name:"검암", code: "A07"),
        StationNm(line: "1065", name:"청라국제도시", code: "A071"),
        StationNm(line: "1065", name:"운서", code: "A08"),
        StationNm(line: "1065", name:"공항화물청사", code: "A09"),
        StationNm(line: "1065", name:"인천국제공항", code: "A10"),//공항철도(A)
        StationNm(line: "1075", name: "왕십리", code: "K210"),
        StationNm(line: "1075", name: "서울숲", code: "K211"),
        StationNm(line: "1075", name:"압구정로데오", code: "K212"),
        StationNm(line: "1075", name:"강남구청", code: "K213"),
        StationNm(line: "1075", name:"선정릉", code: "K214"),
        StationNm(line: "1075", name:"선릉", code: "K215"),
        StationNm(line: "1075", name:"한티", code: "k216"),
        StationNm(line: "1075", name:"도곡", code: "K217"),
        StationNm(line: "1075", name:"구룡", code: "k218"),
        StationNm(line: "1075", name:"개포동", code: "k219"),
        StationNm(line: "1075", name:"대모산입구", code: "k220"),
        StationNm(line: "1075", name:"수서", code: "K221"),
        StationNm(line: "1075", name:"복정", code: "K222"),
        StationNm(line: "1075", name:"가천대", code: "K223"),
        StationNm(line: "1075", name:"태평", code: "K224"),
        StationNm(line: "1075", name:"모란", code: "K225"),
        StationNm(line: "1075", name:"야탑", code: "K226"),
        StationNm(line: "1075", name:"이매", code: "K227"),
        StationNm(line: "1075", name:"서현", code: "K228"),
        StationNm(line: "1075", name:"수내", code: "K229"),
        StationNm(line: "1075", name:"정자", code: "K230"),
        StationNm(line: "1075", name:"미금", code: "K231"),
        StationNm(line: "1075", name:"오리", code: "K232"),
        StationNm(line: "1075", name:"죽전", code: "K233"),
        StationNm(line: "1075", name:"보정", code: "K234"),
        StationNm(line: "1075", name:"구성", code: "K235"),
        StationNm(line: "1075", name:"신갈", code: "K236"),
        StationNm(line: "1075", name:"기흥", code: "K237"),
        StationNm(line: "1075", name:"상갈", code: "K238"),
        StationNm(line: "1075", name:"청명", code: "K239"),
        StationNm(line: "1075", name:"영통", code: "K240"),
        StationNm(line: "1075", name:"망포", code: "K241"),
        StationNm(line: "1075", name:"매탄권선", code: "K242"),
        StationNm(line: "1075", name:"수원시청", code: "K243"),
        StationNm(line: "1075", name:"매교", code: "K244"),
        StationNm(line: "1075", name:"수원", code: "K245"),//분당선(B)
        StationNm(line: "1067", name: "광운대", code: "P119"),
        StationNm(line: "1067", name: "상봉", code: "P120"),
        StationNm(line: "1067", name:"망우", code: "P121"),
        StationNm(line: "1067", name:"신내", code: "P122"),
        StationNm(line: "1067", name:"갈매", code: "P123"),
        StationNm(line: "1067", name:"별내", code: "P124"),
        StationNm(line: "1067", name:"퇴계원", code: "P125"),
        StationNm(line: "1067", name:"사릉", code: "P126"),
        StationNm(line: "1067", name:"금곡", code: "P127"),
        StationNm(line: "1067", name:"평내호평", code: "P128"),
        StationNm(line: "1067", name:"천마산", code: "P129"),
        StationNm(line: "1067", name:"마석", code: "P130"),
        StationNm(line: "1067", name:"대성리", code: "P131"),
        StationNm(line: "1067", name:"청평", code: "P132"),
        StationNm(line: "1067", name:"상천", code: "P133"),
        StationNm(line: "1067", name:"가평", code: "P134"),
        StationNm(line: "1067", name:"굴봉산", code: "P135"),
        StationNm(line: "1067", name:"백양리", code: "P136"),
        StationNm(line: "1067", name:"강촌", code: "P137"),
        StationNm(line: "1067", name:"김유정", code: "P138"),
        StationNm(line: "1067", name:"남춘천", code: "P139"),
        StationNm(line: "1067", name:"춘천", code: "P140"),//경춘선(G)
        StationNm(line: "1069", name: "계양", code: "I110"),
        StationNm(line: "1069", name: "귤현", code: "I111"),
        StationNm(line: "1069", name:"박촌", code: "I112"),
        StationNm(line: "1069", name:"임학", code: "I113"),
        StationNm(line: "1069", name:"계산", code: "I114"),
        StationNm(line: "1069", name:"경인교대입구", code: "I115"),
        StationNm(line: "1069", name:"작전", code: "I116"),
        StationNm(line: "1069", name:"갈산", code: "I117"),
        StationNm(line: "1069", name:"부평구청", code: "I118"),
        StationNm(line: "1069", name:"부평시장", code: "I119"),
        StationNm(line: "1069", name:"부평", code: "I120"),
        StationNm(line: "1069", name:"동수", code: "I121"),
        StationNm(line: "1069", name:"부평삼거리", code: "I122"),
        StationNm(line: "1069", name:"간석오거리", code: "I123"),
        StationNm(line: "1069", name:"인천시청", code: "I124"),
        StationNm(line: "1069", name:"예술회관", code: "I125"),
        StationNm(line: "1069", name:"인천터미널", code: "I126"),
        StationNm(line: "1069", name:"문학경기장", code: "I127"),
        StationNm(line: "1069", name:"선학", code: "I128"),
        StationNm(line: "1069", name:"신연수", code: "I129"),
        StationNm(line: "1069", name:"원인재", code: "I130"),
        StationNm(line: "1069", name:"동춘", code: "I131"),
        StationNm(line: "1069", name:"동막", code: "I132"),
        StationNm(line: "1069", name:"캠퍼스타운", code: "I133"),
        StationNm(line: "1069", name:"테크노파크", code: "I134"),
        StationNm(line: "1069", name:"지식정보단지", code: "I135"),
        StationNm(line: "1069", name:"인천대입구", code: "I136"),
        StationNm(line: "1069", name:"센트럴파크", code: "I137"),
        StationNm(line: "1069", name:"국제업무지구", code: "I138"),//인천1호선(I)
        StationNm(line: "1063", name: "문산", code: "K335"),
        StationNm(line: "1063", name: "파주", code: "K334"),
        StationNm(line: "1063", name:"월롱", code: "K333"),
        StationNm(line: "1063", name:"금촌", code: "K331"),
        StationNm(line: "1063", name:"금릉", code: "K330"),
        StationNm(line: "1063", name:"운정", code: "K329"),
        StationNm(line: "1063", name:"야당", code: "K328"),
        StationNm(line: "1063", name:"탄현", code: "K327"),
        StationNm(line: "1063", name:"일산", code: "K326"),
        StationNm(line: "1063", name:"풍산", code: "K325"),
        StationNm(line: "1063", name:"백마", code: "K324"),
        StationNm(line: "1063", name:"곡산", code: "K323"),
        StationNm(line: "1063", name:"대곡", code: "K322"),
        StationNm(line: "1063", name:"능곡", code: "K321"),
        StationNm(line: "1063", name:"행신", code: "K320"),
        StationNm(line: "1063", name:"강매", code: "K319"),
        StationNm(line: "1063", name:"화전", code: "K318"),
        StationNm(line: "1063", name:"수색", code: "K317"),
        StationNm(line: "1063", name:"디지털미디어시티", code: "K316"),
        StationNm(line: "1063", name:"가좌", code: "K315"),
        StationNm(line: "1063", name:"신촌(경의중앙선)", code: "P312"),
        StationNm(line: "1063", name:"서울", code: "P313"),
        StationNm(line: "1063", name:"홍대입구", code: "K314"),
        StationNm(line: "1063", name:"서강대", code: "K313"),
        StationNm(line: "1063", name:"공덕", code: "K312"),
        StationNm(line: "1063", name:"용산", code: "K110"),
        StationNm(line: "1063", name:"이촌", code: "K111"),
        StationNm(line: "1063", name:"서빙고", code: "K112"),
        StationNm(line: "1063", name:"한남", code: "K113"),
        StationNm(line: "1063", name:"옥수", code: "K114"),
        StationNm(line: "1063", name:"응봉", code: "K115"),
        StationNm(line: "1063", name:"왕십리", code: "K116"),
        StationNm(line: "1063", name:"청량리", code: "K117"),
        StationNm(line: "1063", name:"회기", code: "K118"),
        StationNm(line: "1063", name:"중랑", code: "K119"),
        StationNm(line: "1063", name:"상봉", code: "K120"),
        StationNm(line: "1063", name:"망우", code: "K121"),
        StationNm(line: "1063", name:"양원", code: "K122"),
        StationNm(line: "1063", name:"구리", code: "K123"),
        StationNm(line: "1063", name:"도농", code: "K124"),
        StationNm(line: "1063", name:"양정", code: "K125"),
        StationNm(line: "1063", name:"덕소", code: "K126"),
        StationNm(line: "1063", name:"도심", code: "K127"),
        StationNm(line: "1063", name:"팔당", code: "K128"),
        StationNm(line: "1063", name:"운길산", code: "K129"),
        StationNm(line: "1063", name:"양수", code: "K130"),
        StationNm(line: "1063", name:"신원", code: "K131"),
        StationNm(line: "1063", name:"국수", code: "K132"),
        StationNm(line: "1063", name:"아신", code: "K133"),
        StationNm(line: "1063", name:"오빈", code: "K134"),
        StationNm(line: "1063", name:"양평(경의중앙선)", code: "K135"),
        StationNm(line: "1063", name:"원덕", code: "K136"),
        StationNm(line: "1063", name:"용문", code: "K137"),//경의중앙선(K)
        StationNm(line: "1077", name: "강남", code: "D7"),
        StationNm(line: "1077", name: "양재", code: "D8"),
        StationNm(line: "1077", name:"양재시민의숲", code: "D9"),
        StationNm(line: "1077", name:"청계산입구", code: "D10"),
        StationNm(line: "1077", name:"판교", code: "D11"),
        StationNm(line: "1077", name:"정자", code: "D12"),
        StationNm(line: "1077", name:"동천", code: "D13"),
        StationNm(line: "1077", name:"수지구청", code: "D14"),
        StationNm(line: "1077", name:"성복", code: "D15"),
        StationNm(line: "1077", name:"상현", code: "D16"),
        StationNm(line: "1077", name:"광교중앙", code: "D17"),
        StationNm(line: "1077", name:"광교", code: "D18"),//신분당선(S)
        StationNm(line: "1071", name: "오이도", code: "K250"),
        StationNm(line: "1071", name: "달월", code: "K251"),
        StationNm(line: "1071", name:"월곶", code: "K252"),
        StationNm(line: "1071", name:"소래포구", code: "K253"),
        StationNm(line: "1071", name:"인천논현", code: "K254"),
        StationNm(line: "1071", name:"호구포", code: "K255"),
        StationNm(line: "1071", name:"남동인더스파크", code: "K256"),
        StationNm(line: "1071", name:"원인재", code: "K257"),
        StationNm(line: "1071", name:"연수", code: "K258"),
        StationNm(line: "1071", name:"송도", code: "K259")//수인선(SU)
    ]
    
    var list : Array<StationNm> = line
    
    if(subwayId == ""){
        
    }else{
        list = line.filter({$0.line == subwayId})
    }
    
    
    
    return list
}

struct Express{
    var line : String
    var name : String
    var StationId : String
    var code : String
}

func expressList() -> Array<Array<Express>>{
    let expressList : Array<Array<Express>>=[
        [
            Express(line: "1001", name: "소요산", StationId: "1001000100", code: "100"),
            Express(line: "1001", name: "동두천", StationId: "1001000101", code: "101"),
            Express(line: "1001", name: "동두천중앙", StationId: "1001000103", code: "103"),
            Express(line: "1001", name: "덕정", StationId: "1001000105", code: "105"),
            Express(line: "1001", name: "양주", StationId: "1001000107", code: "107"),
            Express(line: "1001", name: "의정부", StationId: "1001000110", code: "110"),
            Express(line: "1001", name: "회룡", StationId: "1001000111", code: "111"),
            Express(line: "1001", name: "도봉산", StationId: "1001000113", code: "113"),
            Express(line: "1001", name: "창동", StationId: "1001000116", code: "116"),
            Express(line: "1001", name: "광운대", StationId: "1001000119", code: "119")
        ],
        [
            Express(line: "1001", name: "서울", StationId: "1001000133", code: "133"),
            Express(line: "1001", name: "금천구청", StationId: "1001080144", code: "P144"),
            Express(line: "1001", name: "안양", StationId: "1001080147", code: "P147"),
            Express(line: "1001", name: "군포", StationId: "1001080150", code: "P150"),
            Express(line: "1001", name: "의왕", StationId: "1001080152", code: "P152"),
            Express(line: "1001", name: "성균관대", StationId: "1001080153", code: "P153"),
            Express(line: "1001", name: "수원", StationId: "1001080155", code: "P155"),
            Express(line: "1001", name: "병점", StationId: "1001080157", code: "P157"),
            Express(line: "1001", name: "오산", StationId: "1001080160", code: "P160"),
            Express(line: "1001", name: "서정리", StationId: "1001080163", code: "P163"),
            Express(line: "1001", name: "평택", StationId: "1001080165", code: "P165"),
            Express(line: "1001", name: "성환", StationId: "1001080166", code: "P166"),
            Express(line: "1001", name: "두정", StationId: "1001080168", code: "P168"),
            Express(line: "1001", name: "천안", StationId: "1001080169", code: "P169")
        ],
        [
            Express(line: "1001", name: "용산", StationId: "1001000135", code: "135"),
            Express(line: "1001", name: "노량진", StationId: "1001000136", code: "136"),
            Express(line: "1001", name: "대방", StationId: "1001000137", code: "137"),
            Express(line: "1001", name: "신길", StationId: "1001000138", code: "138"),
            Express(line: "1001", name: "영등포", StationId: "1001000139", code: "139"),
            Express(line: "1001", name: "신도림", StationId: "1001000140", code: "140"),
            Express(line: "1001", name: "구로", StationId: "1001000141", code: "141"),
            Express(line: "1001", name: "가산디지털단지", StationId: "1001080142", code: "P142"),
            Express(line: "1001", name: "안양", StationId: "1001080147", code: "P147"),
            Express(line: "1001", name: "수원", StationId: "1001080155", code: "P155"),
            Express(line: "1001", name: "병점", StationId: "1001080157", code: "P157"),
            Express(line: "1001", name: "오산", StationId: "1001080160", code: "P160"),
            Express(line: "1001", name: "서정리", StationId: "1001080163", code: "P163"),
            Express(line: "1001", name: "평택", StationId: "1001080165", code: "P165"),
            Express(line: "1001", name: "성환", StationId: "1001080166", code: "P166"),
            Express(line: "1001", name: "두정", StationId: "1001080168", code: "P168"),
            Express(line: "1001", name: "천안", StationId: "1001080169", code: "P169")
        ],
        [
            Express(line: "1001", name: "용산", StationId: "1001000135", code: "135"),
            Express(line: "1001", name: "노량진", StationId: "1001000136", code: "136"),
            Express(line: "1001", name: "대방", StationId: "1001000137", code: "137"),
            Express(line: "1001", name: "신길", StationId: "1001000138", code: "138"),
            Express(line: "1001", name: "영등포", StationId: "1001000139", code: "139"),
            Express(line: "1001", name: "신도림", StationId: "1001000140", code: "140"),
            Express(line: "1001", name: "구로", StationId: "1001000141", code: "141"),
            Express(line: "1001", name: "역곡", StationId: "1001000146", code: "146"),
            Express(line: "1001", name: "부천", StationId: "1001000148", code: "148"),
            Express(line: "1001", name: "송내", StationId: "1001000150", code: "150"),
            Express(line: "1001", name: "부평", StationId: "1001000152", code: "152"),
            Express(line: "1001", name: "동암", StationId: "1001000154", code: "154"),
            Express(line: "1001", name: "주안", StationId: "1001000156", code: "156"),
            Express(line: "1001", name: "동인천", StationId: "1001000160", code: "160")
        ],
        [
            Express(line: "1004", name: "당고개", StationId: "1004000409", code: "409"),
            Express(line: "1004", name: "상계", StationId: "1004000410", code: "410"),
            Express(line: "1004", name: "노원", StationId: "1004000411", code: "411"),
            Express(line: "1004", name: "창동", StationId: "1004000412", code: "412"),
            Express(line: "1004", name: "쌍문", StationId: "1004000413", code: "413"),
            Express(line: "1004", name: "수유", StationId: "1004000414", code: "414"),
            Express(line: "1004", name: "미아", StationId: "1004000415", code: "415"),
            Express(line: "1004", name: "미아사거리", StationId: "1004000416", code: "416"),
            Express(line: "1004", name: "길음", StationId: "1004000417", code: "417"),
            Express(line: "1004", name: "성신여대입구", StationId: "1004000418", code: "418"),
            Express(line: "1004", name: "한성대입구", StationId: "1004000419", code: "419"),
            Express(line: "1004", name: "혜화", StationId: "1004000420", code: "420"),
            Express(line: "1004", name: "동대문", StationId: "1004000421", code: "421"),
            Express(line: "1004", name: "동대문역사문화공원", StationId: "1004000422", code: "422"),
            Express(line: "1004", name: "충무로", StationId: "1004000423", code: "423"),
            Express(line: "1004", name: "명동", StationId: "1004000424", code: "424"),
            Express(line: "1004", name: "회현", StationId: "1004000425", code: "425"),
            Express(line: "1004", name: "서울", StationId: "1004000426", code: "426"),
            Express(line: "1004", name: "숙대입구", StationId: "1004000427", code: "427"),
            Express(line: "1004", name: "삼각지", StationId: "1004000428", code: "428"),
            Express(line: "1004", name: "신용산", StationId: "1004000429", code: "429"),
            Express(line: "1004", name: "이촌", StationId: "1004000430", code: "430"),
            Express(line: "1004", name: "동작", StationId: "1004000431", code: "431"),
            Express(line: "1004", name: "총신대입구(이수)", StationId: "1004000432", code: "432"),
            Express(line: "1004", name: "사당", StationId: "1004000433", code: "433"),
            Express(line: "1004", name: "남태령", StationId: "1004000434", code: "434"),
            Express(line: "1004", name: "선바위", StationId: "1004000435", code: "435"),
            Express(line: "1004", name: "경마공원", StationId: "1004000436", code: "436"),
            Express(line: "1004", name: "대공원", StationId: "1004000437", code: "437"),
            Express(line: "1004", name: "과천", StationId: "1004000438", code: "438"),
            Express(line: "1004", name: "정부과천청사", StationId: "1004000439", code: "439"),
            Express(line: "1004", name: "인덕원", StationId: "1004000440", code: "440"),
            Express(line: "1004", name: "평촌", StationId: "1004000441", code: "441"),
            Express(line: "1004", name: "범계", StationId: "1004000442", code: "442"),
            Express(line: "1004", name: "금정", StationId: "1004000443", code: "443"),
            Express(line: "1004", name: "산본", StationId: "1004000444", code: "444"),
            Express(line: "1004", name: "상록수", StationId: "1004000448", code: "448"),
            Express(line: "1004", name: "중앙", StationId: "1004000450", code: "450"),
            Express(line: "1004", name: "안산", StationId: "1004000453", code: "453")
        ],
        [
            Express(line: "1009", name: "김포공항", StationId: "1009000902", code: "902"),
            Express(line: "1009", name: "가양", StationId: "1009000907", code: "907"),
            Express(line: "1009", name: "염창", StationId: "1009000910", code: "910"),
            Express(line: "1009", name: "당산", StationId: "1009000913", code: "913"),
            Express(line: "1009", name: "여의도", StationId: "1009000915", code: "915"),
            Express(line: "1009", name: "노량진", StationId: "1009000917", code: "917"),
            Express(line: "1009", name: "동작", StationId: "1009000920", code: "920"),
            Express(line: "1009", name: "고속터미널", StationId: "1009000923", code: "923"),
            Express(line: "1009", name: "신논현", StationId: "1009000925", code: "925"),
            Express(line: "1009", name: "선정릉", StationId: "1009000927", code: "927"),
            Express(line: "1009", name: "봉은사", StationId: "1009000929", code: "929"),
            Express(line: "1009", name: "종합운동장", StationId: "1009000930", code: "930")
        ],
        [
            Express(line: "1075", name: "왕십리", StationId: "1075075210", code: "K210"),
            Express(line: "1075", name: "서울숲", StationId: "1075075211", code: "K211"),
            Express(line: "1075", name: "압구정로데오", StationId: "1075075212", code: "K212"),
            Express(line: "1075", name: "강남구청", StationId: "1075075213", code: "K213"),
            Express(line: "1075", name: "선정릉", StationId: "1075075214", code: "K214"),
            Express(line: "1075", name: "선릉", StationId: "1075075215", code: "K215"),
            Express(line: "1075", name: "한티", StationId: "1075075216", code: "k216"),
            Express(line: "1075", name: "도곡", StationId: "1075075217", code: "K217"),
            Express(line: "1075", name: "구룡", StationId: "1075075218", code: "k218"),
            Express(line: "1075", name: "개포동", StationId: "1075075219", code: "k219"),
            Express(line: "1075", name: "대모산입구", StationId: "1075075220", code: "k220"),
            Express(line: "1075", name: "수서", StationId: "1075075221", code: "K221"),
            Express(line: "1075", name: "복정", StationId: "1075075222", code: "K222"),
            Express(line: "1075", name: "가천대", StationId: "1075075223", code: "K223"),
            Express(line: "1075", name: "태평", StationId: "1075075224", code: "K224"),
            Express(line: "1075", name: "모란", StationId: "1075075225", code: "K225"),
            Express(line: "1075", name: "야탑", StationId: "1075075226", code: "K226"),
            Express(line: "1075", name: "이매", StationId: "1075075227", code: "K227"),
            Express(line: "1075", name: "서현", StationId: "1075075228", code: "K228"),
            Express(line: "1075", name: "수내", StationId: "1075075229", code: "K229"),
            Express(line: "1075", name: "정자", StationId: "1075075230", code: "K230"),
            Express(line: "1075", name: "미금", StationId: "1075075231", code: "K231"),
            Express(line: "1075", name: "오리", StationId: "1075075232", code: "K232"),
            Express(line: "1075", name: "죽전", StationId: "1075075233", code: "K233"),
            Express(line: "1075", name: "기흥", StationId: "1075075237", code: "K237"),
            Express(line: "1075", name: "망포", StationId: "1075075241", code: "K241"),
            Express(line: "1075", name: "수원시청", StationId: "1075075243", code: "K243"),
            Express(line: "1075", name: "수원", StationId: "1075075245", code: "K245")
        ],
        [
            Express(line: "1067", name: "퇴계원", StationId: "1067080125", code: "P125"),
            Express(line: "1067", name: "사릉", StationId: "1067080126", code: "P126"),
            Express(line: "1067", name: "평내호평", StationId: "1067080128", code: "P128"),
            Express(line: "1067", name: "마석", StationId: "1067080130", code: "P130"),
            Express(line: "1067", name: "청평", StationId: "1067080132", code: "P132"),
            Express(line: "1067", name: "가평", StationId: "1067080134", code: "P134"),
            Express(line: "1067", name: "강촌", StationId: "1067080137", code: "P137"),
            Express(line: "1067", name: "남춘천", StationId: "1067080139", code: "P139"),
            Express(line: "1067", name: "춘천", StationId: "1067080140", code: "P140")
        ],
        
    ]
    
    return expressList
}













