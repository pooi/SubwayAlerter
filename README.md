<h1 align=center>SubwayAlerter</h1><br>
><b>소개페이지(Introduce Page) : http://pooi.github.io/SubwayAlerter</b>

License : BSD-3-Clause

Contact & Help : ldayou@me.com

Swift 2.0 (Swift3.0+ not support yet)

<br>

## Overview
Subway Alerter provides station search through quick search, easy transfer by calculating transfer time and efficient time saving. It also increases convenience with smart notification.
<br><br>

## Features
<ul>
  <li>Quick directions</li>
  <li>Reminder before arrival</li>
  <li>Next timetable reminder at transfer station</li>
</ul>
<br><br>

## Usage
이 프로젝트를 사용하기 위해서는 반드시 <a href="https://github.com/pooi/SubwayAlerter/blob/master/SubwayAlerter/ApiKey.swift">이 파일</a>에 Api Key를 입력해주세요.<br>
If you want to use this project, please enter your api key in <a href="https://github.com/pooi/SubwayAlerter/blob/master/SubwayAlerter/ApiKey.swift">this file</a>.<p>
Api Key는 <a href="http://data.seoul.go.kr/">서울 열린 데이터 광장</a>에서 받을 수 있습니다.<br>
You can get api key in <a href="http://data.seoul.go.kr/">this page</a>.
```swift
let KEY = "" // please enter your api key!!
```
<br>
<p>

## Reference
<ul>
<li>네트워크 체크 (Network status check)<br>
http://stackoverflow.com/questions/25623272/how-to-use-scnetworkreachability-in-swift
<li>한글 초성 분류<br>
http://minsone.github.io/mac/ios/linear-hangul-in-objective-c-swift
<li>로컬 알림 설정 (Local notification settings)<br>
http://stackoverflow.com/questions/31794902/how-to-use-uilocalnotification-to-open-spesific-view-containing-coredata
</ul>

<p><br><br>

## 사용된 API
<ol start=1>
<lh><b>서울 열린 데이터 광장(Seoul Open Data Plaza) - http://data.seoul.go.kr</b><p>
<li>서울 노선별 지하철역 정보 (Subway station information of Seoul subway)<br>
http://data.seoul.go.kr/openinf/sheetview.jsp?infId=OA-119&tMenu=11<p></li>
<li>서울시 지하철 역사 정보 (Seoul subway station information)<br>
http://data.seoul.go.kr/openinf/openapiview.jsp?infId=OA-12753&tMenu=11<p></li>
<li>지하철 최단경로정보 (Subway shortest route information)<br>
http://data.seoul.go.kr/openinf/openapiview.jsp?infId=OA-12762<p></li>
<li>서울시 역외부코드로 서울시 지하철역별 열차 시간표 정보 검색 (Search train schedule information using station code)<br>
http://data.seoul.go.kr/openinf/openapiview.jsp?infId=OA-110&tMenu=11<p></li>
<li>서울시 열차 별 경유 지하철역 도착시간 정보 검색 (Information on arrival time at subway station)<br>
http://data.seoul.go.kr/openinf/openapiview.jsp?infId=OA-107&tMenu=11<p></li>
<li>서울시 좌표기반 근접 지하철역 정보 (Nearest subway station based on coordinates)<br>
http://data.seoul.go.kr/openinf/openapiview.jsp?infId=OA-12765&tMenu=11<p></li>
</ol>
<p>
<ol start=1>
<lh><b>Daum Developer(https://developers.daum.net)</b><p>
<li>좌표계 변환 (Coordinate system transformation)<br>
http://developers.daum.net/services/apis/local/geo/transcoord</li>
</ol>
