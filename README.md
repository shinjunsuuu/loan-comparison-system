# 💸 대출 금리 비교 시스템 (Loan Comparison System)

> JSP + Servlet + JPA를 활용한 대출 상품 비교 시스템
> 
> 
> 다양한 은행의 대출 상품을 등록/수정/조회/삭제할 수 있으며,
> 
> 조건별 검색 기능을 통해 사용자가 원하는 상품을 쉽게 찾을 수 있도록 지원합니다.
> 

---

## 👥팀원
<table>
  <tr>
    <td align="center">
      <a href="https://github.com/Hyunsoo1998">
        <img src="https://github.com/Hyunsoo1998.png" width="100px;" alt="menzzi"/>
      </a><br />
      <sub><b>김현수</b></sub>
    </td>
    <td align="center">
      <a href="https://github.com/shinjunsuuu">
        <img src="https://avatars.githubusercontent.com/u/137847336?v=4" width="100px;" alt="shin-kibeom"/>
      </a><br />
      <sub><b>신준수</b></sub>
    </td>
    <td align="center">
      <a href="https://github.com/bbo9866">
        <img src="https://avatars.githubusercontent.com/u/45265805?v=4" width="100px;" alt="shinjunsuuu"/>
      </a><br />
      <sub><b>박지원</b></sub>
    </td>
  </tr>
</table>

## 🧾 프로젝트 개요

- **개발 환경**: Java 17+, Maven, Tomcat, MySQL
- **실행 방식**: 웹 브라우저 기반 (JSP/Servlet)
- **사용 기술**: Java, JSP, Servlet, JPA, Lambda, Stream API, MVC 아키텍처
- **기획 목적**: 웹 개발 및 자바 핵심 문법 학습을 통합하여, 실용적인 금리 비교 시스템 구축

---



## 🛠️ 기술 선택 이유

### ✅ JPA

- SQL문 없이 객체 기반으로 DB 조작 가능
- 가독성 및 유지보수성 향상

### ✅ Lambda & Stream

- 상품 리스트 필터링 및 정렬 구현에 유리
- 선언형 프로그래밍 방식으로 간결한 코드 작성

### ✅ JSP & Servlet

- 전통적인 Java 웹 구조에 대한 실습 목적
- JSP에서 `forward` 방식으로 사용자와 데이터 상호작용 구현

---

## 🖥️ UI

### 👓 대출상품 검색을 위한 화면 <br>
<img width="1918" height="905" alt="대출 상품 검색을 위한 화면" src="https://github.com/user-attachments/assets/3b5cb760-20eb-4865-94aa-7fd535559406" />

---

### 💻 대출상품 조회 결과 화면 <br>
<img width="1911" height="894" alt="대출 상품 검색 결과 화면" src="https://github.com/user-attachments/assets/0fa6bcd5-9dd9-44ce-a89c-8417443ac06a" />

---

### 🔒 관리페이지 화면 <br>

<img width="1902" height="901" alt="대출 상품 관리페이지 화면" src="https://github.com/user-attachments/assets/f690fdec-24b3-4ec4-89c4-390e05d03afa" />

---

## ✏️ 기능

### 1️⃣ 대출 상품 등록

- 사용자로부터 상품명, 은행명, 금리 등을 입력 받아 DB에 저장
- 필수 항목 유효성 검사
- 동일 이름의 상품 중복 방지

### 2️⃣ 대출 상품 수정

- 기존 상품 리스트에서 상품 선택 → 정보 수정 가능
- 수정 시 변경되지 않은 항목은 기존 값 유지
- 음수 입력 등 예외 상황 처리

### 3️⃣대출 상품 삭제

- 사용자가 선택한 상품을 DB에서 삭제
- 삭제 전 확인 메시지 출력 예정
- 존재하지 않는 상품 선택 시 예외 처리

### 4️⃣대출 상품 조회 (전체 및 조건별)

- 전체 상품 목록 출력
- 조건 검색 (예: 은행명, 대출유형, 최대금리 등 필터링)

---



## ⚙️ 주요 기능 요약

| 기능 | 설명 |
| --- | --- |
| ➕ 상품 등록 | 상품명, 금리 등을 입력 받아 DB에 저장 |
| 🛠️ 상품 수정 | 기존 상품을 선택 후 정보 수정 |
| 🗑️ 상품 삭제 | 사용자가 선택한 상품을 삭제 |
| 🔍 상품 검색 | 은행명, 금리 조건 등으로 필터링 조회 |
| 📋 전체 목록 | DB에 등록된 모든 상품 출력 |

---

## 🧱 프로젝트 구조 (MVC 기반)

---

```
📁 java/
├── 📁 controller
│   └── LoanController.java
│
├── 📁 META-INF
│   └── persistence.xml
│
├── 📁 model
│   └── entity/
│       └── Loan.java
│
├── 📁 repository
│   └── LoanRepository.java
│
├── 📁 service
│   └── LoanService.java
│
└── 📁 util
    └── DBUtil.java

📁 js/
└── main.js

📁 webapp/
└── index.html
```

---

## 🚀 실행 방법

1. MySQL에서 아래 테이블 생성
2. `persistence.xml` 또는 설정 파일에서 DB 연동 정보 입력
3. Tomcat 서버 실행 후 `http://localhost:8080/loan-Project/index` 접속

---

## 🗄️ 데이터베이스 스키마

### 🏦 Loan 테이블

| 컬럼명 | 타입 | 설명 |
| --- | --- | --- |
| `id` | Int(PK) | 대출 상품 ID (PK, auto increment) |
| `product_name` | String | 대출 상품명 |
| `bank_name` | String | 취급 은행명 |
| `loan_type` | String | 대출 종류 (예: 신용대출, 전세자금대출 등) |
| `interest_rate` | Float | 적용 금리 (예: 3.2%) |
| `max_limit` | Integer | 최대 한도 (만원 단위) |
| `loan_term_month` | Integer | 대출 기간 (개월 단위) |

```sql
CREATE TABLE loan (
  id INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(255) NOT NULL,
  bank_name VARCHAR(255) NOT NULL,
  loan_type VARCHAR(100) NOT NULL,
  interest_rate FLOAT NOT NULL,
  max_limit INT NOT NULL,
  loan_term_month INT NOT NULL
);

```


---

## 🛠️ Troubleshooting

### 1. `No Persistence Provider` 오류

- `META-INF/persistence.xml` 누락 또는 이름 오류
- `hibernate-core` 의존성 누락 확인

### 2. `ClassNotFoundException: javax.servlet.*`

- Maven에 `javax.servlet-api` 추가 필요

```xml
<dependency>
  <groupId>javax.servlet</groupId>
  <artifactId>javax.servlet-api</artifactId>
  <version>4.0.1</version>
  <scope>provided</scope>
</dependency>

```

 ### 3. `Tomcat 문제 해결`
 - Build Path → Configure Build Path → Libraries → Classpath → Add Library → Server Runtime → Tomcat 선택
 - Project Facets → Dynamic Web Module / Java / JavaScript / JPA 선택
 - Maven -> Update Project 선택

### 4. 'Mysql JDBC 연동 오류 해결'

- Mysql 연동을 위한 persistence.xml 내에 JDBC Propertie 추가.

```xml
<property name="javax.persistence.jdbc.driver"
  value="com.mysql.cj.jdbc.Driver" />
<property name="javax.persistence.jdbc.url"
  value="jdbc:mysql://localhost:3306/fisa?serverTimezone=Asia/Seoul" />
```

---
