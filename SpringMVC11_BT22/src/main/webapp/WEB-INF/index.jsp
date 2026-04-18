<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
    
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="${cpath}/resources/css/btnStyle.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
 <style>
  .fakeimg {
    height: 200px;
    background: #aaa;
  }
  .bold-text {
    font-weight: bold;
  }
  </style>
</head>
<body>

<div class="jumbotron text-center" style="margin-bottom:0">
  <h1>My First Bootstrap 4 Page</h1>
  <p>Resize this responsive page to see the effect!</p> 
</div>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <a class="navbar-brand" href="${cpath}/member/login">로그인</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="#">1:1 취업지원</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">수강생후기</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">이벤트</a>
      </li>    
    </ul>
  </div>  
</nav>

<div class="container" style="margin-top:30px">
  <div class="row">
    <div class="col-sm-4">
      <h4>(빅데이터전문가) 빅데이터 분석 플랫폼 개발자 양성과정</h4>
      <p><span class="bold-text">훈련기간</span> 2026-04-21 ~ 26-10-07</p>
      <div class="fakeimg">Fake Image1</div>
      <br>
      <p> <span class="bold-text">훈련목표</span>
      &nbsp; 빅데이터를 수집·저장·처리·분석하고, 플랫폼을 개발하여 의미 있는 결과를 도출하는 역량을 기르며, 프로그래밍 기술을 활용한 분석 프로세스의 자동화 및 결과 시각화 능력을 함양하는 것을 목표로 합니다.</p>
      <br>
      <h3>스프링부트 코드 아카데미</h3>
      <p>수강에서 취업까지 모든과정에서 최고의 만족을 경험해보세요.</p>
      <ul class="nav nav-pills flex-column">
        <li class="nav-item">
          <a class="nav-link active" href="#">과정조회</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">개강일정</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">수강생후기</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">이벤트</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#">온라인상담신청</a>
        </li>
      </ul>
      <hr class="d-sm-none">
    </div>
    <div class="col-sm-4">
      <h2>프론</h2>
      <h5>2026-05-30 ~ 26-12-30</h5>
      <div class="fakeimg">Fake Image</div>
      <br>
      <p>다양한 스마트기기 플랫폼에 적용 가능한 웹기반의 콘텐츠서비스를 기획, 분석, 설계, 구현, 테스트, 배포 및 유지보수하는 능력을 함양한다.</p>
      <p>React기반의 프론트엔드 개발 역량 및 JAVA, Spring- 기반의 백엔드 개발 역량을 동시에 향상시켜 스마트기기에 적용 가능한 서비스를 구축 및 전환하고, API와 연동하여 AWS클라우드를 활용한 웹앱 테스트 및 배포할수 있는 통합적 수행 인재 양성을 목표로하여 응용소프트웨어 개발 분야 기업에 응용소프트웨어 개발자로 취업하는 것을 목표로 하는 과정입니다.</p>
      <br>
      <h2>풀스택 엔지니어</h2>
      <h5>2026-05-30 ~ 26-12-30</h5>
      <div class="fakeimg">Fake Image</div>
      <br>
      <p>정보보호 정책을 수립하여 이를 시행 및 유지관리 할 수 있도록 정보보호조직을 구성하여 조직의 인적보안을 관리할 수 있는 능력을 함양한다</p>
      <p>시스템, 네트워크 등 정보통신과 관련된 기반 지식을 가지고 조직의 정보자산을 관리적, 물리적 , 기술적 보안 관점에서 효율적으로 보호하는 능력을 함양한다.</p>
    </div>
    <div class="col-sm-4">
      <h2>풀스택 엔지니어</h2>
      <h5>2026-05-30 ~ 26-12-30</h5>
      <div class="fakeimg">Fake Image</div>
      <br>
      <p>응용SW개발 구직 희망자 중 "JAVA기초 프로그래밍 이수자"를 대상으로, 전공자, 관련경력자 등 선발 우선 기준을 선정하여 훈련생을 선발한다</p>
      <p>본 훈련과정은 디지털 기술을 기반으로, 음성· 영상· 공간· 공공 및 민간 데이터를 융합하고, 생성형 AI를 활용하여 플랫폼 상에서 새로운 형태의 지능형 융합서비스를 창출할 수 있도록, 다양한 유형의 데이터를 분석· 기획· 설계· 제작· 운영· 시험하는 전 주기적 콘텐츠 활용 능력을 배양하는 것을 목표로 합니다.</p>
      <br>
      <h2>데이터 분석가</h2>
      <h5>2026-05-30 ~ 26-12-30</h5>
      <div class="fakeimg">Fake Image</div>
      <br>
      <p>보안에 관련한 시스템과 응용 서버, 네트워크 장비 및 보안장비에 대한 전문지식과 운용기술을 갖추고 시스템, 네트워크, 애플리케이션 분야별 기초 보안업무를 실행 할 수 있는 인력 양성을 목표로 한다.</p>
      <p>정해진 보안 기준에 따라 데이터베이스, 인터넷 연결, 컴퓨터 시스템, 프로그램, 앱 등을 안전하게 만들고 운영하는 방법을 배우며, 새롭게 생기는 해킹이나 위험에도 잘 대응할 수 있는 능력을 기릅니다.
또한 해킹 징후를 찾아내고 분석해서 문제를 막는 방법, 위험한 부분을 줄이기 위한 대책 세우기 등 전반적인 보안 관리 능력을 키우며, 정보보안산업기사 자격증 취득을 준비할 수 있습니다.</p>
    </div>
  </div>
</div>

<div class="jumbotron text-center" style="margin-bottom:0">
  <%@ include file="/WEB-INF/common/bottom_common.jsp" %>
</div>

</body>
</html>

</html>