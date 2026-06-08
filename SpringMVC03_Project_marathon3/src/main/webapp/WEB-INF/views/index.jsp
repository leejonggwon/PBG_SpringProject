<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- context path 값을 내장객체 변수로 저장한다: contextPath라는 변수를 만들고, 현재 애플리케이션의 context path 값을 저장한다-->
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
<title>2026 SEOUL MARATHON</title>
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

/*검정색 띠같은 ouline속성제거*/
.nav-tabs > li > a:focus, 
.nav-tabs > li > a:active {
	outline: none !important;
}
</style>
<body>
	<div class="container">
		<!-- 공통 메뉴바:
		     JSP에서 다른 JSP 파일을 현재 페이지에 포함시키는 기능 -->
		<jsp:include page="common/header.jsp"></jsp:include> 	
		<div class="panel panel-default">
			<br>
			<div style="text-align: center;">
				<img style="width:80%;" src="${contextPath}/resources/images/main001.png"> <!--views 폴더 아래 있으면 resouces 위치와 똑같다고 보면 된다-->
			</div>
			<br>
			<div class="panel-body">
			
				<ul class="nav nav-tabs">
					<li class="active"><a data-toggle="tab" href="#home">대회소개</a></li>
					<li><a data-toggle="tab" href="#menu1">대회개요</a></li>
					<li><a data-toggle="tab" href="#menu2">자주묻는질문</a></li>
				    <li><a data-toggle="tab" href="#menu3">코스안내</a></li>
				</ul>
		
			    <div class="tab-content">
				    <div id="home" class="tab-pane fade in active">
				      <h3 style="margin-bottom: 30px;">대회소개</h3>			     
				      <h3>역사와 현대가 공존하는 서울을 달리다!  한국 국제 마라톤</h3> 	
				      <br>		   
				      <p>1931년에 시작되어 아시아에서 가장 오랜 역사를 자랑하는 한국 국제 마라톤은 세계육상연맹(WA)의 최고 등급인 '플래티넘 레이블'을 보유한 세계적인 마라톤 축제입니다.</p> 	
				      <p>활기찬 광화문 광장에서 출발해 서울의 심장부와 아름다운 한강을 가로지르는 코스를 달리며, 참가자들은 서울의 역동적인 매력을 온몸으로 만끽할 수 있습니다.</p>	
				      <p>자신의 기록에 도전하는 엘리트 러너부터 달리기를 즐기는 시민 러너까지, 모두가 하나 되어 달리는 감동의 순간—한국 국제 마라톤에서 여러분의 특별한 발걸음을 시작해 보세요.</p>			   				      
				      <div style="text-align:center; margin-top: 15px;">
				      	<img style="width:80%;" src="${contextPath}/resources/images/main002.png"> 
				      	<br>
					  </div>
				    
				    
				    </div>
				    <div id="menu1" class="tab-pane fade">
				   
				      
				      <div class="container">
						  <h3>대회개요</h3>
						  <p>* 대회 운영 방침에 따라 일부 내용이 변경될 수 있습니다.</p>            
						  <table class="table">
							  <tbody>
							    <tr>
							      <th>대회명</th>
							      <td>2026 한국 국제 마라톤</td>
							    </tr>
							    <tr>
							      <th>대회일정</th>
							      <td>2026년 6월 21일 (일) 오전 7시 30분</td>
							    </tr>
							    <tr>
							      <th>대회장소</th>
							      <td>한강공원 (*상기 장소는 주최 측 사정에 의해 변경될 수 있습니다)</td>
							    </tr>
							    <tr>
							      <th>모집 인원</th>
							      <td>총 1만명</td>
							    </tr>
							    <tr>
							      <th>참가 자격</th>
							      <td>대회 당일 기준 만 18세 이상의 신체 건강한 남녀</td>
							    </tr>
							    <tr>
							      <th>접수 방법</th>
							      <td>앱 또는 웹페이지에서 접수</td>
							    </tr>
							    <tr>
							      <th>주최</th>
							      <td>한국 국제 마라톤연맹</td>
							    </tr>
							    <tr>
							      <th>후원</th>
							      <td>서울특별시, 문화체육관광부</td>
							    </tr>
							  </tbody>
						  </table>
						</div>
				    
				    
				    </div>
				    
				    
				    
				    <div id="menu2" class="tab-pane fade">
					  <h3>자주묻는질문</h3>
					
					  <table style="width:90%; margin:20px auto; border-collapse:collapse; background:#fff; border-radius:10px; overflow:hidden;">
					    <tbody>
					      <tr class="accordion-title" style="border-bottom:1px solid #ddd;">
					        <td style="padding:12px 15px;">1</td>				        
					        <td style="padding:12px 15px;">물품 보관소 와 탈의실 운영하나요?</td>
					        <td style="padding:12px 15px;">+</td>
					      </tr>
					      <tr class="accordion-content" style="display:none; background:#fafafa;">
					        <td colspan="3" style="padding:15px; color:#555;">
						        <p>물품보관소 와 탈의실 운영합니다</p>
						        <p>자유복장으로 오셔서 탈의실에서 마라톤 복장으로 환복 하시고 물품은 물품보관소에 맡기시고 안전하게 달리기를 즐기시면 됩니다</p>
						        <p>물품보관시 귀중품은 보관 불가하며 파손이나 분실시 책임지지않습니다</p>
					        </td>
					      </tr>
					
					      <tr class="accordion-title" style="border-bottom:1px solid #ddd;">
					        <td style="padding:12px 15px;">2</td>
					        <td style="padding:12px 15px;">유모차를 가지고 아이와 함께 참가 가능할까요?</td>
					        <td style="padding:12px 15px;">+</td>
					      </tr>
					      <tr class="accordion-content" style="display:none; background:#fafafa;">
					        <td colspan="3" style="padding:15px; color:#555;">
					        	<p>유모차를 가지고 아이와 함께 참여할수 있습니다.</p>
						        <p>달리기 코스가 자전거 도로라서 통제할 수 없으니 안전에 유의해주시기 바랍니다.</p>					   
					        </td>
					      </tr>
					
					      <tr class="accordion-title" style="border-bottom:1px solid #ddd;">
					        <td style="padding:12px 15px;">3</td>
					        <td style="padding:12px 15px;">메달 참가자 전원에게 지급하나요?</td>
					        <td style="padding:12px 15px;">+</td>
					      </tr>
					      <tr class="accordion-content" style="display:none; background:#fafafa;">
					        <td colspan="3" style="padding:15px; color:#555;">
					        	<p>메달 참가자 전원에게 지급합니다.</p>
					        	<p>완주 후에 각 코스별 메달과 간식(빵,음료)을 드립니다.</p>
					        </td>
					      </tr>
					      
					      <tr class="accordion-title" style="border-bottom:1px solid #ddd;">
					        <td style="padding:12px 15px;">4</td>
					        <td style="padding:12px 15px;">기록증은 언제 어떻게 받을 수 있나요?</td>
					        <td style="padding:12px 15px;">+</td>
					      </tr>
					      <tr class="accordion-content" style="display:none; background:#fafafa;">
					        <td colspan="3" style="padding:15px; color:#555;">
					        	<p>기록증은 전종목 발급되며, 완주 후 당일 모바일로 기록증을 전송하여 드립니다.</p>
					        </td>
					      </tr>
					      
					      <tr class="accordion-title" style="border-bottom:1px solid #ddd;">
					        <td style="padding:12px 15px;">5</td>
					        <td style="padding:12px 15px;">배번호와 기념티셔츠는 어떻게 수령하나요?</td>
					        <td style="padding:12px 15px;">+</td>
					      </tr>
					      <tr class="accordion-content" style="display:none; background:#fafafa;">
					        <td colspan="3" style="padding:15px; color:#555;">
					        	<p>배번호와 기념티셔츠는 ~5/17 (일) 까지 참가신청(입금)시 택배로 발송하여 드리고, </p>
					        	<p>5/18 (월) ~ 5/28 (목) 까지 참가신청(입금)시 대회 당일 현장에서 지급하여 드립니다.</p>

					        </td>
					      </tr>
					      
					      <tr class="accordion-title" style="border-bottom:1px solid #ddd;">
					        <td style="padding:12px 15px;">6</td>
					        <td style="padding:12px 15px;">행사 당일 몇 시까지 어디로 가면 될까요?</td>
					        <td style="padding:12px 15px;">+</td>
					      </tr>
					      <tr class="accordion-content" style="display:none; background:#fafafa;">
					        <td colspan="3" style="padding:15px; color:#555;">
					        	<p><strong>집결 장소:</strong> 여의도한강공원 물빛 무대 앞 광장</p>
					        	<p><strong>주소:</strong> 서울 영등포구 여의도동 84-9</p>
					        	<p><strong>집결 일시:</strong> 6월 21일 (일) 오전 7시</p>
					        	<p><strong>행사 시작:</strong> 오전 7시 30분</p>
					        	<p><strong>마라톤 출발 시간:</strong> 오전 8시 (그룹별 순차 출발)</p>
					        	<p><strong>*원활한 진행을 위해 정해진 시간까지 도착해 주시길 바랍니다.</strong></p>				       
					        </td>
					      </tr>

					    </tbody>
					  </table>
					</div>


				    <div id="menu3" class="tab-pane fade">
				      <h3>코스 안내</h3>
				      <p>2026 한국국제마라톤 42.195km 코스 안내</p>
				      <div style="text-align:center;">
				      	<img style="width:70%;" src="${contextPath}/resources/images/course001.png"> 
					  </div>
					  <br>
					  <ul>
						  <li><strong>출발점: 여의도 한강공원</strong>
						    <ul>
						      <li>출발 시각, 주의사항 안내</li>
						      <li>출발 직후 교차로, 안전요원 배치</li>
						    </ul>
						  </li>
						  <br>
						  <li><strong>5km 지점: 양화대교 일대</strong>
						    <ul>
						      <li>급수대, 응급 의료시설 위치</li>
						      <li>관람 포인트</li>
						    </ul>
						  </li>
						  <br>
						  <li><strong>10km 지점: 마포대교</strong>
						    <ul>
						      <li>자원봉사자 안내, 간단한 응급처치 가능</li>
						    </ul>
						  </li>
						  <br>
						  <li><strong>15km 지점: 여의도공원 주변</strong>
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
						  <li><strong>25km 지점: 광나루 천호대교 일대</strong>
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
						  <li><strong>35km 지점: 잠실대교</strong>
						    <ul>
						      <li>마지막 고비 구간, 페이스 관리</li>
						    </ul>
						  </li>
						  <br>
						  <li><strong>40km 지점: 수서IC 부근</strong>
						    <ul>
						      <li>마무리 페이스 조절, 기록 관리</li>
						    </ul>
						  </li>
						  <br>
						  <li><strong>결승점: 올림픽 공원</strong>
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
				Copyright &copy; 2026 HANKUK MARATHON - All rights reserved
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
				$("#messageType").attr("class", "modal-content panel-primary");
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
















