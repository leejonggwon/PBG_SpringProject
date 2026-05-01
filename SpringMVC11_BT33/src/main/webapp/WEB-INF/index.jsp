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
  
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
  <meta name="generator" content="Hugo 0.101.0">
  <title>Album example · Bootstrap v4.6</title>
  
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
  
  
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="${cpath}/resources/css/btnStyle.css">
  <link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${cpath}/resources/css/album.css">
  
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
 <style>
  .bd-placeholder-img {
    font-size: 1.125rem;
    text-anchor: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
  }

  @media (min-width: 768px) {
    .bd-placeholder-img-lg {
      font-size: 3.5rem;
    }
  }
  .bold-text {
	font-weight: bold;
  }
    </style>
    <link href="album.css" rel="stylesheet">
</head>
<body>
    
<header>
  <div class="collapse bg-dark" id="navbarHeader">
    <div class="container">
      <div class="row">
        <div class="col-sm-8 col-md-7 py-4">
          <h4 class="text-white">Code Academy School</h4>
          <p class="text-muted">AI 학습·평가·콘텐츠 솔루션 'Code Academy'의 솔루션 브랜드인 
				'Code Academy School'은 AI 콘텐츠 생성, 학생 진단, 자동 평가, 안전 챗봇, 수업 데이터 분석까지 
				학교에서 바로 사용할 수 있는 AI 서비스를 제공합니다.</p>
        </div>
        <div class="col-sm-4 offset-md-1 py-4">
          <h4 class="text-white">Contact</h4>
          <ul class="list-unstyled">
            <li><a href="#" class="text-white">Follow on Twitter</a></li>
            <li><a href="#" class="text-white">Like on Facebook</a></li>
            <li><a href="#" class="text-white">Email me</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <div class="navbar navbar-dark bg-dark shadow-sm">
    <div class="container d-flex justify-content-between">
      <a href="#" class="navbar-brand d-flex align-items-center">     
        <i class="fab fa-codepen" style="color: rgb(255, 255, 255);"></i>&nbsp;Code Academy                                                                                                                                                                                                                                                                                                                                             
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" onclick="openHeader()" data-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
    </div>
  </div>
</header>

<main role="main">

  <section class="jumbotron text-center">
    <div class="container">
      <h1><i class="fab fa-codepen" style="color: rgb(63, 32, 32);"></i>&nbsp;Code Academy<h1> 
      <p class="lead text-muted">압도적 만족도의 IT 취업 부트캠프 코드아케데미 수강에서 취업까지, <br> 
      모든 과정에서 최고의 만족을 경험해 보세요</p>

      <p>
        <a href="${cpath}/member/login" class="btn btn-custom my-2">로그인</a>
        <a href="#" class="btn btn-secondary my-2">문의하기</a>
      </p>
    </div>
  </section>

  <div class="album py-5 bg-light">
    <div class="container">

      <div class="row">
        <div class="col-md-4">
          <div class="card mb-4 shadow-sm">
            <img src="${cpath}/resources/images/thumbnail/back.png" class="rounded" alt="Cinque Terre" width="100%" height="225">
																																																																										
            <div class="card-body">
              <p class="card-text"><span class="bold-text">Java로 시작하는 Spring 백엔드</span> <br><br>Java 언어의 객체 지향 원리를 깊이 이해하고, Spring Boot 프레임워크를 활용하여 확장성 있는 백엔드 시스템을 구축하는 것을 목표로 합니다.</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">커리큐럼</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">수강생후기</button>
                </div>
                <small class="text-muted">더보기</small>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card mb-4 shadow-sm">
            <img src="${cpath}/resources/images/thumbnail/front.png" class="rounded" alt="Cinque Terre" width="100%" height="225">
																																																																										
            <div class="card-body">
              <p class="card-text"><span class="bold-text">프론트엔드 엔지니어</span> <br><br> HTML5와 CSS3를 활용하여 웹 표준과 웹 접근성을 준수하는 화면을 설계하며, 반응형 웹 디자인 기술을 습득하여 다양한 디바이스(모바일, 태블릿, PC)에 최적화된 레이아웃을 구현하는 것을 목표로 합니다.</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">커리큐럼</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">수강생후기</button>
                </div>
                <small class="text-muted">더보기</small>      
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card mb-4 shadow-sm">
            <img src="${cpath}/resources/images/thumbnail/startup.png" class="rounded" alt="Cinque Terre" width="100%" height="225">
																																																																										
            <div class="card-body">
              <p class="card-text"><span class="bold-text">IT 서버스 창업</span> <br><br> 시장 조사를 통해 고객의 페인 포인트(Pain Point)를 발굴하고, 이를 해결할 수 있는 "IT 기반 비즈니스 모델(BM)"을 설계하는 것을 목표로 합니다.</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">커리큐럼</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">수강생후기</button>
                </div>
                <small class="text-muted">더보기</small>
              </div>
            </div>
          </div>
        </div>

        <div class="col-md-4">
          <div class="card mb-4 shadow-sm">
            <img src="${cpath}/resources/images/thumbnail/full.png" class="rounded" alt="Cinque Terre" width="100%" height="225">
																																																																										
            <div class="card-body">
              <p class="card-text"><span class="bold-text">풀스택 엔지니어</span> <br><br> 사용자 인터페이스(UI) 설계부터 서버 구축, 데이터베이스 모델링에 이르기까지 웹 서비스의 전체 생명주기를 독자적으로 수행하는 것을 목표로 합니다.</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">커리큐럼</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">수강생후기</button>
                </div>
                <small class="text-muted">더보기</small>
              </div>
            </div>
          </div>
        </div>
        
        <div class="col-md-4">
          <div class="card mb-4 shadow-sm">
            <img src="${cpath}/resources/images/thumbnail/ai.png" class="rounded" alt="Cinque Terre" width="100%" height="225">
																																																																										
            <div class="card-body">
              <p class="card-text"><span class="bold-text">AI 엔지니어</span> <br><br> 파이썬(Python) 기반의 머신러닝 및 딥러닝 프레임워크(TensorFlow, PyTorch 등)를 활용하여 데이터를 학습시키고 예측 모델을 구축하는 능력을 목표로 합니다.</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">커리큐럼</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">수강생후기</button>
                </div>
                <small class="text-muted">더보기</small>
              </div>
            </div>
          </div>
        </div>
        
        <div class="col-md-4">
          <div class="card mb-4 shadow-sm">
            <img src="${cpath}/resources/images/thumbnail/data.png" class="rounded" alt="Cinque Terre" width="100%" height="225">
																																																																										
            <div class="card-body">
              <p class="card-text"><span class="bold-text">데이터 분석가</span> <br><br> 데이터 속에 숨겨진 패턴을 발견하여 비즈니스 의사결정에 기여하는 인사이트 도출 역량을 목표로 합니다. 가설을 설정하고 통계적 분석 기법(검정, 회귀분석 등)을 통해 이를 검증하며, 복잡한 데이터를 논리적인 결과로 요약하여 비즈니스 문제를 해결하는 능력을 함양합니다.</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">커리큐럼</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">수강생후기</button>
                </div>
                <small class="text-muted">더보기</small>
              </div>
            </div>
          </div>
        </div>

        <div class="col-md-4">
          <div class="card mb-4 shadow-sm">
            <img src="${cpath}/resources/images/thumbnail/uxui.png" class="rounded" alt="Cinque Terre" width="100%" height="225">
																																																																										
            <div class="card-body">
              <p class="card-text"><span class="bold-text">UXUI 디자이너</span> <br><br> 사용자의 행동 패턴과 요구사항을 심층적으로 분석하여 최적의 사용자 시나리오를 설계하는 것을 목표로 합니다. 페르소나 설정, 여정 지도(Journey Map) 작성을 통해 서비스의 문제점을 발견하고, 이를 해결할 수 있는 논리적인 정보 구조(IA)와 와이어프레임을 설계하는 역량을 함양합니다.</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">커리큐럼</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">수강생후기</button>
                </div>
                <small class="text-muted">더보기</small>
              </div>
            </div>
          </div>
        </div>
        
        <div class="col-md-4">
          <div class="card mb-4 shadow-sm">
            <img src="${cpath}/resources/images/thumbnail/cloud.png" class="rounded" alt="Cinque Terre" width="100%" height="225">
																																																																										
            <div class="card-body">
              <p class="card-text"><span class="bold-text">클라우드 및 DevOps</span> <br><br> AWS나 Azure 같은 클라우드 환경에서 서비스를 배포하고, Docker와 Kubernetes를 활용해 컨테이너 기반의 운영 환경을 구축하는 것을 목표로 합니다. CI/CD 파이프라인(Jenkins, GitHub Actions)을 통해 코드 수정부터 배포까지의 과정을 자동화하는 시스템 엔지니어링 역량을 함양합니다.</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">커리큐럼</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">수강생후기</button>
                </div>
                <small class="text-muted">더보기</small>
              </div>
            </div>
          </div>
        </div>
        
        <div class="col-md-4">
          <div class="card mb-4 shadow-sm">
            <img src="${cpath}/resources/images/thumbnail/aiot.png" class="rounded" alt="Cinque Terre" width="100%" height="225">
																																																																										
            <div class="card-body">
              <p class="card-text"><span class="bold-text">사물지능</span> <br><br> 다양한 센서로부터 수집된 환경 데이터를 딥러닝 모델로 분석하여, 상황별 최적의 기기 제어를 수행하는 AIoT 기반 스마트홈 시스템을 설계하고 구현하는 것을 목표로 합니다.</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary">커리큐럼</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary">수강생후기</button>
                </div>
                <small class="text-muted">더보기</small>
              </div>
            </div>
          </div>
        </div>
        
        
        
      </div>
    </div>
  </div>

</main>

<footer class="text-muted">
  <div class="container">
    <p class="float-right">
      <a href="#">Back to top</a>
    </p>
    <p>Copyright © 2026 Code Academy. All rights reserved.</p>
  </div>
</footer>

	<script type="text/javascript">
		//header 열기
		function openHeader(){	
			$("#navbarHeader").toggle();
		}
	
	</script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
   

    
    

      <script>window.jQuery || document.write('<script src="../assets/js/vendor/jquery.slim.min.js"><\/script>')</script><script src="../assets/dist/js/bootstrap.bundle.min.js"></script>

      
  </body>
</html>

</html>