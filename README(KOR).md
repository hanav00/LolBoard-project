<h1>:cherry_blossom:Spring Framework 기반의 게시판 구현하기</h1>

<hr>
<span>
  <img src="https://img.shields.io/badge/Spring-6DB33F?style=for-the-badge&logo=Spring&logoColor=white"/>
  <img src="https://img.shields.io/badge/apachetomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=white"/>
  <img src="https://img.shields.io/badge/mariadb-003545?style=for-the-badge&logo=mariadb&logoColor=white"/>
</span>
<br>
<span>
  <img src="https://img.shields.io/badge/Java-007396?style=for-the-badge&logo=OpenJDK&logoColor=white"/>
  <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=JavaScript&logoColor=black"/>
  <img src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=HTML5&logoColor=black"/>
  <img src="https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=CSS3&logoColor=black"/>
</span>

:calendar: 2023.04.25 ~ 05.26<br>
:raising_hand: 개인 프로젝트<br>


<hr>

스프링에서 게시판 프로젝트는 스프링 프레임워크의 기초적인 개념과 기능을 학습하는 데 가장 적합한 프로젝트로 간주
게시판 프로젝트를 통해 스프링 프레임워크의 기본 기능과 개념(스프링 MVC, 의존성 주입(Dependency Injection), 제어의 역전(Inversion of Control) 등)을 학습할 수 있다.
또한, 웹 애플리케이션의 기본적인 구조와 작동 방식을 이해하는 데 도움을 주며, 사용자 인증과 권한관리에 대해서도 다루면서 CRUD 작업도 구현하기 때문에 매우 기초적이면서도 필수적인 프로젝트이다.

따라서, 스프링에서의 첫 프로젝트로 게시판 프로젝트를 선택하였다. 
이 프로젝트에서는 게시글과 관련된 기능들과 회원 관리 기능을 중심으로 개발하는 것을 목표로 하고 있다. 
이를 통해 기본적인 웹 애플리케이션 개발과 데이터베이스 연동, 사용자 인증과 권한 관리에 대한 이해를 바탕으로 실제 프로젝트에 적용할 수 있는 기술과 경험을 쌓을 수 있다.



<h2>Step 1: 게시판의 목적 및 요구사항 정의서 작성하기</h2>
리그 오브 레전드라는 게임을 좋아하기 때문에 게시판도 리그 오브 레전드 챔프들의 이미지를 활용하고자 하였다. 또한, 요구사항 정의서를 작성하여 이를 기반으로 게시판을 제작하였다.


<h2>Step 2: 프로젝트 초기 설정</h2>
스프링 프로젝트를 생성하고, 프로젝트의 디렉터리 구조를 설정한다. 데이터베이스와 연결을 위한 기본 설정도 한다. 이 프로젝트에서는 MariaDB를 사용하였다.


<h2>Step 3: 데이터베이스 테이블 설계 및 연동</h2>
게시글과 관련된 데이터를 저장할 테이블을 설계하고, JDBC를 사용해서 연동한다.

|테이블 이름|칼럼 명|설명|
|---|---|---|
|`tbl_board`|seqno|글 번호, PK|
||writer|글 작성자 이름(username)|
||title|글 제목|
||userid|글 작성자 아이디|
||content|글 내용|
||hitno|글 조회수|
||regdate|글 작성일|
||likecnt|글의 좋아요 개수|
|`tbl_file`|fileseqno|파일 번호, PK|
||org_filename|원본 파일 명|
||stored_filename|저장된 파일 명|
||filesize|파일 사이즈|
||userid|파일 올린 글의 작성자|
||seqno|파일 올린 글의 번호|
||checkfile|글 수정에서 파일을 삭제할 경우 N으로 체크|
|`tbl_like`|seqno|좋아요 누른 글 번호, PK|
||userid|좋아요 누른 사람의 아이디, PK|
||mylikecheck|좋아요 누른 상태 체크|
||likedate|좋아요 누른 시간|
|`tbl_reply`|replySeqno|댓글 번호, PK|
||replyWriter|댓글 작성자 이름|
||replyContent|댓글 내용|
||userid|댓글 작성자 아이디|
||seqno|댓글 단 글 번호|
||replyRegdate|댓글 단 시간|
||avatar|댓글 단 사람의 아바타|
|`tbl_user`|userid|회원의 아이디, PK
||username|회원의 이름
||password|회원의 비밀번호
||email|회원의 이메일
||gender|회원의 성별
||job|회원의 직업
||description|회원의 자기소개
||birthdate|회원의 생년월일
||country|회원의 국적
||role|회원의 역할(MASTER 역할 구분을 위해)
||avatar|회원의 아바타|
||authkey|자동로그인 체크|
||lastPasswordUpdate|마지막 비밀번호 변경일


<h2>Step 4: 스프링 MVC 구조에 맞는 코드 작성</h2>

|MVC구조|구성|
|---|---|
|View|board(list, modify, view, write.jsp)|
||user(login, signUp, mypage, changeInfo, changePassword, findMyId, IDView, findMyPassword, tempPasswordView.jsp)|
||master(boardmanage, filemanage, membermanage, sysinfo, sysmanage|
|Controller|Board, User, Master Controller.java|
|DAO|Board, User, Master DAO/DAOImpl.java|
|Mapper|Board, User, Master Mapper.xml|
|DTO|Board, File, Like, Reply, User VO.java|
|Service|Board, User, Master Service/ServiceImpl.java|
|util|Page.java|


<h2>Step 5: 페이지 UI 수정(CSS)</h2>


<h2>Step 6: 접근 권한/알람 설정 테스트</h2>
현재 session ID와 role을 확인하여 링크를 직접 치고 들어가도 해당 사용자가 아니면 페이지가 제한되도록 설정하였다. 
알람은 입력 페이지를 벗어날 때, 데이터가 영구 삭제될 때, 다른 기능에도 영향을 끼칠 때, 필수 정보를 미기입했을 때 알람이 떠서 사용자에게 알려주도록 설정하였다.


<h2>Step 7: 배포</h2>
가상 도메인을 설정해서 배포하였다.
