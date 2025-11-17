<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><!-- 줄바꿈, 날짜일정문자 잘라내는 기능들이 있다 --> 

<!-- fmt 태그는 주로 날짜/시간, 숫자, 메시지 포맷 처리에 사용 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="cpath" value="${pageContext.request.contextPath}"/>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인 페이지</title>
<style>
* { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
body, html { height: 100%; }

/* 전체 컨테이너 */
.container {
  display: flex;
  height: 100vh;
  flex-wrap: wrap;
}
/* 좌측 슬라이더 영역 */
.left {
  flex: 1;
  min-width: 300px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  background-color: #f0f0f0;
  padding: 40px;
}

.Slidesbackground {
    margin: 0;
    padding: 0;

}
.slideshow-image{
    border-radius:3%;
    width: 100%;
    height: 100%;
    overflow: hidden;
}
.mySlides {
    border-radius:3%;
    width: 700px;
    height: 450px;
    display: flex;
    justify-content: center;
    align-items: center;
    box-shadow: 0px 15px 15px rgba(0, 0, 0, 0.5);
}

.slideshow-container {
    display: flex;
    justify-content: center;
    position: relative;
    margin: auto;
}

.fade {
    animation-name: fade;
    animation-duration: 1.5s;
}

@keyframes fade {
    from {
        opacity: .4
    }
    to {
        opacity: 1
    }
}
/* 우측 로그인 폼 */
.right {
  flex: 1;
  min-width: 300px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 40px;
  background-color: #fff;
}

.logo {
  font-size: 32px;
  font-weight: bold;
  margin-bottom: 40px;
  color: #007bff;
   margin-left: -20px; /* 조금 왼쪽으로 이동 */
}

.login-form {
  width: 100%;
  max-width: 300px;
  display: flex;
  flex-direction: column;
  gap: 15px;
  margin-left: -20px; /* 조금 왼쪽으로 이동 */
}

.login-form input[type="text"],
.login-form input[type="password"] {
  padding: 10px;
  font-size: 16px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.login-form button {
  padding: 10px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.3s;
}

.login-form button:hover {
  background-color: #0056b3;
}

.checkbox-container {
  display: flex;
  align-items: center;
  gap: 5px;
  font-size: 14px;
}

/* 반응형 */
@media (max-width: 768px) {
  .container { flex-direction: column; }
  .left, .right { width: 100%; height: auto; padding: 20px; }
  .slide-container, .slides img { height: 200px; }
}
</style>
</head>
<body>

<div class="container">
  <!-- 좌측 슬라이더 -->
  <div class="left">
  	
    <span class="slideshow-container">
                 <div class="Slidesbackground"> 
                                       
                    <div class="mySlides fade">
				      <img src="https://images.unsplash.com/photo-1521791136064-7986c2920216?ixlib=rb-1.2.1&auto=format&fit=crop&w=2370&q=80" class="slideshow-image" alt="Team Meeting">
				    </div>
				    <div class="mySlides fade">
				      <img src="https://images.unsplash.com/photo-1551434678-e076c223a692?ixlib=rb-1.2.1&auto=format&fit=crop&w=2370&q=80" class="slideshow-image" alt="Technology">
				    </div>
				    <div class="mySlides fade">
				      <img src="https://images.unsplash.com/photo-1504384308090-c894fdcc538d?ixlib=rb-1.2.1&auto=format&fit=crop&w=2370&q=80" class="slideshow-image" alt="Business Team">
				    </div>
				    <div class="mySlides fade">
				      <img src="https://images.unsplash.com/photo-1556761175-129418cb2dfe?ixlib=rb-1.2.1&auto=format&fit=crop&w=2370&q=80" class="slideshow-image" alt="Creative Work">
				    </div>
				    <div class="mySlides fade">
				      <img src="https://images.unsplash.com/photo-1600880292203-757bb62b4baf?ixlib=rb-1.2.1&auto=format&fit=crop&w=2370&q=80" class="slideshow-image" alt="Team Discussion">
				    </div>
				    
                </div>
             </span>
  </div>

  <!-- 우측 로그인 폼 -->
  <div class="right">
    <div class="logo">Spring Company Community</div>
    <form class="login-form">
      <input type="text" placeholder="ID">
      <input type="password" placeholder="PW">
      <div class="checkbox-container">
        <input type="checkbox" id="save-id">
        <label for="save-id">ID 저장</label>
      </div>
      <button type="submit">로그인</button>
    </form>
  </div>
</div>

<script>
var slideIndex = 0;
showSlides();

function showSlides() {
    var i;
    var slides = document.getElementsByClassName("mySlides");
   
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    slideIndex++;
    if (slideIndex > slides.length) {
        slideIndex = 1
    }
    slides[slideIndex - 1].style.display = "block";

    setTimeout(showSlides, 5000); // 2초마다 이미지가 체인지됩니다
}
</script>

</body>
</html>
