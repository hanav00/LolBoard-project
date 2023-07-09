<h1>:cherry_blossom:Creating a Bulletin Board Application with the Spring Framework</h1>

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
:raising_hand: Personal Project<br>


<hr>

Building a bulletin board application using the Spring Framework is an excellent choice for gaining a solid understanding of the framework's core concepts and functionalities. This project provides an opportunity to delve into fundamental aspects like Spring MVC, Dependency Injection, and Inversion of Control. Additionally, it offers insights into the foundational structure and functioning of web applications, covering essential elements like user authentication, authorization, and CRUD operations.

Therefore, I have decided to embark on this bulletin board project as my inaugural endeavor with the Spring Framework. The primary focus will be on developing key features related to post management and user administration. By undertaking this project, my goal is to cultivate practical experience in building basic web applications, integrating databases, and comprehending the intricacies of user authentication and authorization. This hands-on knowledge and expertise will serve as a strong foundation for future real-world projects.



<h2>Step 1: Defining the Purpose and Requirements of the Bulletin Board</h2>
As a fan of the game League of Legends, I wanted to incorporate images of League of Legends champions into the bulletin board. 
To guide the development process, I created a requirements specification document that outlines the necessary features and functionalities for the bulletin board.


<h2>Step 2: Project Initialization and Configuration</h2>
I initiated a Spring project and established the appropriate directory structure. I configured the project settings, including the database connection setup. For this particular project, I opted for MariaDB as the database management system.


<h2>Step 3: Designing and Integrating the Database Tables</h2>
I devised the database tables to effectively store and manage the post-related data. Leveraging JDBC, I seamlessly integrated the database functionality into the project, ensuring smooth communication between the application and the database.


|Table Name	|Column Name|Description|
|---|---|---|
|`tbl_board`|seqno|Post number, PK|
||writer|Name of the post author (username)|
||title|Post title|
||userid|ID of the post author|
||content|Post content|
||hitno|Number of post views|
||regdate|Date of post creation|
||likecnt|Number of post likes|
|`tbl_file`|fileseqno|File number, PK|
||org_filename|Original file name|
||stored_filename|Stored file name|
||filesize|File size|
||userid|	ID of the user who uploaded the file|
||seqno|Post number associated with the file|
||checkfile|Flag to indicate file deletion during post modification|
|`tbl_like`|seqno|Post number of the liked post, PK|
||userid|ID of the user who liked the post, PK|
||mylikecheck|Flag to indicate the status of the like|
||likedate|	Date and time when the like was registered|
|`tbl_reply`|replySeqno|Reply number, PK|
||replyWriter|Name of the reply author|
||replyContent|Reply content|
||userid|ID of the reply author|
||seqno|Post number to which the reply belongs|
||replyRegdate|Date and time when the reply was posted|
||avatar|Avatar of the user who posted the reply|
|`tbl_user`|userid|User ID, PK
||username|User name
||password|User password
||email|User email
||gender|User gender
||job|User job
||description|User self-introduction
||birthdate|User date of birth
||country|User nationality
||role|User role (for distinguishing the MASTER role)
||avatar|User avatar
||authkey|Auto login flag
||lastPasswordUpdate|Date of last password update


<h2>Step 4:  Writing Code in the Spring MVC Structure</h2>
In this step, I developed the code following the Spring MVC structure, ensuring proper organization and adherence to best practices.


|Spring MVC Structure||
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


<h2>Step 5: Enhancing Page UI with CSS</h2>
I focused on improving the visual appearance of the pages by applying CSS styles. This step involved modifying the layout, colors, and overall design to create a more appealing user interface.

<h2>Step 6: Testing Access Permissions and Notifications</h2>
To enhance security and user experience, I implemented access restrictions based on session IDs and user roles. Unauthorized users will be prevented from accessing restricted pages. Additionally, I incorporated notification alerts to inform users in various scenarios, such as leaving input pages, permanent data deletion, impacts on other functionalities, and incomplete required information.


<h2>Step 7: Deployment</h2>
I completed the deployment process by configuring and launching the application on a virtual domain, making it accessible to users.



<hr>
<div align="center">Thank you for showing interest in my project!💖</div>
