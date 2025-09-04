<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- context path 값을 내장객체 변수로 저장한다: contextPath라는 변수를 만들고, 현재 애플리케이션의 context path 값을 저장한다-->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
<title>2025 SEOUL MARATHON</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<style>
 .table {
  width: 94%;   
  margin: 25px 10px 30px 5px;
}
</style>
<body>
	<div class="container">
		<!-- 공통 메뉴바:
		     JSP에서 다른 JSP 파일을 현재 페이지에 포함시키는 기능 -->
		<jsp:include page="common/header.jsp"></jsp:include> 
		<h3>2025 SEOUL MARATHON</h3>	
		<div class="panel panel-default">
			<div>
				<img style="width:100%; height:400px;" src="${contextPath}/resources/images/main2.png"> <!--views 폴더 아래 있으면 resouces 위치와 똑같다고 보면 된다-->
			</div>
			<div class="panel-body">
			
				<ul class="nav nav-tabs">
					<li class="active"><a data-toggle="tab" href="#home">대회소개</a></li>
					<li><a data-toggle="tab" href="#menu1">대회개요</a></li>
					<li><a data-toggle="tab" href="#menu2">공지사항</a></li>
				    <li><a data-toggle="tab" href="#menu3">코스안내</a></li>
				</ul>
		
			    <div class="tab-content">
				    <div id="home" class="tab-pane fade in active">
				      <h3>대회소개</h3>
				      <br>
				      <p>서울마라톤은 1931년 시작된 아시아 최고(最古)의 국제 마라톤 대회로, 세계육상연맹 플래티넘 레이블을 보유한 세계적인 마라톤 축제입니다.</p> 			   
				      <p>광화문에서 출발해 서울 도심과 한강을 가로지르는 코스를 따라 달리며, 참가자들은 역사와 현대가 공존하는 서울의 매력을 온몸으로 느낄 수 있습니다.</p> 	
				      <p>기록에 도전하는 엘리트 러너부터 달리기를 즐기는 시민 러너까지, 모두가 하나 되는 순간—서울마라톤에서 특별한 발걸음을 내디뎌 보세요.</p>
				      <br>
				      
				      <div style="text-align:center;">
				      	<p>2025 서울마라톤 로고</p>
				      	<img style="width:60%; height:400px;" src="${contextPath}/resources/images/logo.jpg"> 
					  </div>
				    
				    
				    </div>
				    <div id="menu1" class="tab-pane fade">
				   
				      
				      <div class="container">
						  <h2>대회개요</h2>
						  <p>* 대회 운영 방침에 따라 일부 내용이 변경될 수 있습니다.</p>            
						  <table class="table">
							  <tbody>
							    <tr>
							      <th>대회명</th>
							      <td>2025 서울마라톤</td>
							    </tr>
							    <tr>
							      <th>대회일정</th>
							      <td>2025년 11월 11일 (일)</td>
							    </tr>
							    <tr>
							      <th>대회장소</th>
							      <td>잠실 (*상기 장소는 주최 측 사정에 의해 변경될 수 있습니다)</td>
							    </tr>
							    <tr>
							      <th>부분 및 인원</th>
							      <td>1.7만명</td>
							    </tr>
							    <tr>
							      <th>참가 자격</th>
							      <td>만 18세 이상 5시간 이내 완주 가능한 자 (2007년 11월 11일 이전 출생자)</td>
							    </tr>
							    <tr>
							      <th>접수 방법</th>
							      <td>앱 또는 웹페이지에서 접수</td>
							    </tr>
							    <tr>
							      <th>주최</th>
							      <td>대한육상연맹</td>
							    </tr>
							    <tr>
							      <th>후원</th>
							      <td>서울특별시</td>
							    </tr>
							  </tbody>
						  </table>
						</div>
				    
				    
				    </div>
				    
				    
				    
				    <div id="menu2" class="tab-pane fade">
					  <h3>공지사항</h3>
					
					  <table style="width:90%; margin:20px auto; border-collapse:collapse; background:#fff; border-radius:10px; overflow:hidden;">
					    <tbody>
					      <tr class="accordion-title" style="border-bottom:1px solid #ddd;">
					        <td style="padding:12px 15px;">1</td>
					        <td style="padding:12px 15px;">공지사항</td>
					        <td style="padding:12px 15px;">대회 참가권 양도 가능 여부</td>
					        <td style="padding:12px 15px;">+</td>
					      </tr>
					      <tr class="accordion-content" style="display:none; background:#fafafa;">
					        <td colspan="3" style="padding:15px; color:#555;">
						        <p>참가권 양도 및 대리 참가는 불가능합니다. </p>
						        <p>또한, 사전 접수 드로우 당첨자를 대상으로 발송해드린 할인 쿠폰은 개인 사유로 참가가 불가능할 경우 사용하지 않으셔도 무방합니다.</p>
					        </td>
					      </tr>
					
					      <tr class="accordion-title" style="border-bottom:1px solid #ddd;">
					        <td style="padding:12px 15px;">2</td>
					        <td style="padding:12px 15px;">공지사항</td>
					        <td style="padding:12px 15px;">2025 서울마라톤 얼리버드 접수 주의사항</td>
					        <td style="padding:12px 15px;">+</td>
					      </tr>
					      <tr class="accordion-content" style="display:none; background:#fafafa;">
					        <td colspan="3" style="padding:15px; color:#555;">
					        	<p>- 사전접수는 2025년 10월 11일 오전 10시 부터 진행됩니다. </p>
						        <p>- 사전 접수 신청 시 회원 가입과 본인인증이 필요합니다.</p>
						        <p>- 중복 계정으로 참여해도 1개 계정만 추첨 대상이 됩니다.</p>
						        <p>- 당첨자와 등록자가 다른 경우 당첨 여부와 관계없이 취소됩니다.</p>
						        <p>- 2025년 11월 1일 오후 6시 까지 신청 내용 변경이 가능합니다.</p>
						        <p>- 최종 신청내역은 앱 마이페이지에서 확인할 수 있습니다.</p>
					        </td>
					      </tr>
					
					      <tr class="accordion-title" style="border-bottom:1px solid #ddd;">
					        <td style="padding:12px 15px;">3</td>
					        <td style="padding:12px 15px;">공지사항</td>
					        <td style="padding:12px 15px;">환불 접수 안내</td>
					        <td style="padding:12px 15px;">+</td>
					      </tr>
					      <tr class="accordion-content" style="display:none; background:#fafafa;">
					        <td colspan="3" style="padding:15px; color:#555;">결제일로부터 7일 이내 고객센터에 문의하시면 환불 절차가 진행됩니다.</td>
					      </tr>
					    </tbody>
					  </table>
					</div>


				    <div id="menu3" class="tab-pane fade">
				      <h3>코스 안내</h3>
				      <p>2025 서울마라톤 42.195km 코스 안내</p>
				      <div style="text-align:center;">
				      	<img style="width:50%; height:400px;" src="${contextPath}/resources/images/map.png"> 
					  </div>
					  <br>
					  <ul>
						  <li><strong>출발점: 잠실종합운동장</strong>
						    <ul>
						      <li>출발 시각, 주의사항 안내</li>
						      <li>출발 직후 교차로, 안전요원 배치</li>
						    </ul>
						  </li>
						  <br>
						  <li><strong>5km 지점: 잠실교 일대</strong>
						    <ul>
						      <li>급수대, 응급 의료시설 위치</li>
						      <li>관람 포인트</li>
						    </ul>
						  </li>
						  <br>
						  <li><strong>10km 지점: 한강공원 잠실지구</strong>
						    <ul>
						      <li>자원봉사자 안내, 간단한 응급처치 가능</li>
						    </ul>
						  </li>
						  <br>
						  <li><strong>15km 지점: 동호대교 주변</strong>
						    <ul>
						      <li>구간별 경사, 주행 난이도 표시</li>
						    </ul>
						  </li>
						  <br>
						  <li><strong>20km 지점: 반포 한강공원</strong>
						    <ul>
						      <li>중간 급수대 및 화장실 위치</li>
						    </ul>
						  </li>
						  <br>
						  <li><strong>25km 지점: 여의도 일대</strong>
						    <ul>
						      <li>관람객 밀집 구간, 안전 주의</li>
						    </ul>
						  </li>
						  <br>
						  <li><strong>30km 지점: 광화문·시청 일대</strong>
						    <ul>
						      <li>후반 체력 관리, 에너지 보충 권장</li>
						    </ul>
						  </li>
						  <br>
						  <li><strong>35km 지점: 잠실 방향 복귀</strong>
						    <ul>
						      <li>마지막 고비 구간, 페이스 관리</li>
						    </ul>
						  </li>
						  <br>
						  <li><strong>40km 지점: 잠실로 돌아오는 구간</strong>
						    <ul>
						      <li>마무리 페이스 조절, 기록 관리</li>
						    </ul>
						  </li>
						  <br>
						  <li><strong>결승점: 잠실종합운동장</strong>
						    <ul>
						      <li>완주 메달, 음료 제공</li>
						      <li>회복 구간 및 의료지원</li>
						    </ul>
						  </li>
						  <br>
						</ul>
					  
				    </div>
			    </div>
			    
			</div>
			<div class="panel-footer">
				2025 SEOUL MARATHON - All rights reserved
			</div>
		</div>	
	</div>
	
	
	<!-- 회원가입 성공시 띄워줄 모달창 -->
   <div class="modal fade" id="myMessage" role="dialog">
     <div class="modal-dialog">
     
       <!-- 모달내용-->
       <div id="messageType" class="modal-content">
         <div class="modal-header panel-heading"> <!-- panel-heading을 넣어야 헤더 스타일이 적용된다 -->
           <button type="button" class="close" data-dismiss="modal">&times;</button>
           <h4 class="modal-title">${msgType}</h4> <!--MemberController에서 실패하면 joinForm에서 다시 이동할때 값을 보내준다 -->
         </div>
         <div class="modal-body">
           <p>${msg}</p> 
         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
         </div>
       </div>
   
     </div>
   </div>
   
   <script type="text/javascript">
   	$(document).ready(function(){
   		if(${not empty msgType}){ //EL식
			if(${msgType eq "성공메세지"}){ //EL식
				$("#messageType").attr("class", "modal-content panel-success");
			}
		$("#myMessage").modal("show"); //모달창 실행
		}
   		
   	});
   	
   	//토글 아코디언
    $(document).ready(function(){
        $(".accordion-title").on("click", function(){
          $(this).next(".accordion-content").toggle();
        });
      });
   
   </script>
  
</body>
</html>
















