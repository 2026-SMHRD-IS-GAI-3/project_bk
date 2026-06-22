# ⚔️ AI 검술 학습 지원 서비스

YOLOv11 Pose 기반 자세 인식 기술을 활용하여 사용자의 검술 자세를 분석하고, 맞춤형 교정 피드백을 제공하는 웹 기반 검술 학습 플랫폼입니다.

사용자는 웹캠을 통해 자신의 자세를 촬영하고 AI 분석 결과를 확인할 수 있으며, 경험치·업적·칭호 시스템을 통해 지속적인 수련 동기를 부여받을 수 있습니다.

---

## 📌 프로젝트 개요

### 프로젝트 기간

2026.04 ~ 2026.06

### 프로젝트 목표

* AI 자세 분석을 통한 검술 학습 지원
* 비대면 환경에서도 효율적인 자세 교정 제공
* 게임화(Gamification)를 활용한 지속적인 수련 유도
* 사용자 맞춤형 학습 환경 구축


---


## 🎯 제안 배경

검술과 같은 무술은 전문 지도자의 피드백이 중요하지만 시간과 장소의 제약으로 인해 지속적인 학습이 어렵습니다.

또한 개인 연습 시 자신의 자세를 객관적으로 확인하기 어려워 잘못된 자세가 반복될 가능성이 존재합니다.

본 프로젝트는 AI 기반 자세 분석 기술을 활용하여 사용자가 언제 어디서나 검술을 학습하고 교정받을 수 있는 서비스를 제공하고자 기획되었습니다.


---


## ✨ 주요 기능

### AI 자세 분석

* YOLOv11 Pose 기반 관절 좌표 추출
* 검술 자세 분류
* 자세 정확도 분석
* 자세 점수 제공

### AI 자세 교정

* 기준 자세와 사용자 자세 비교
* 부위별 교정 메시지 제공
* 자세 개선 가이드 제공

### 수련 시스템

* 단계별 검술 학습
* 난이도별 자세 훈련
* 수련 결과 저장

### 성장 시스템

* 경험치 획득
* 레벨 시스템
* 업적 달성
* 칭호 획득

### 회원 관리

* 회원가입 및 로그인
* 마이페이지
* 수련 기록 조회
* 다크모드 설정


---


## 🛠 Tech Stack

### Front-End

* HTML5
* CSS3
* JavaScript
* JSP

### Back-End

* Java
* Servlet
* Apache Tomcat
* Maven

### AI Server

* Python
* Flask
* YOLOv11 Pose
* OpenCV
* NumPy

### Database

* Oracle Database
* SQL

### Collaboration

* Git
* GitHub


---


## 🏗 System Architecture

Client (JSP)

↓

Java Servlet (Tomcat)

↓

REST API

↓

Flask Server

↓

YOLOv11 Pose Model

↓

Oracle Database


---


## 📊 Database Design

주요 관리 데이터

* 회원 정보
* 수련 기록
* 자세 정보
* 경험치 및 레벨
* 업적
* 칭호
* 상점 상품


---


## 🚀 Expected Effects

* AI 기반 자세 분석을 통한 객관적인 피드백 제공
* 시간과 장소의 제약 없는 검술 학습 환경 제공
* 사용자 맞춤형 학습 경험 제공
* 게임화를 통한 학습 지속성 향상


---


## 📷 Screenshots

### 메인 화면

<img width="397" height="783" alt="Image" src="https://github.com/user-attachments/assets/a6b0da5f-fd18-43e5-8439-024e63e333df" />

### AI 자세 분석 화면

<img width="403" height="782" alt="Image" src="https://github.com/user-attachments/assets/954bc9c2-3cff-4cd4-aca9-21d1b35faf0c" />
<img width="403" height="907" alt="Image" src="https://github.com/user-attachments/assets/c225b02e-7243-41fb-810c-9341f5e4eb3a" />

### 마이페이지

<img width="404" height="785" alt="Image" src="https://github.com/user-attachments/assets/0d092365-08e5-4b10-bb08-327a0f1b915c" />

### 업적 및 칭호 시스템

<img width="404" height="783" alt="Image" src="https://github.com/user-attachments/assets/9556b8bc-98a1-4fc8-990b-bc3cd9b13ad5" />
<img width="401" height="787" alt="Image" src="https://github.com/user-attachments/assets/b583810a-4183-4065-b966-bf6de1d769e8" />


---


## 📜 License

This project was developed for educational purposes.
