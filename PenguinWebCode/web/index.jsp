<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>PenguinWeb</title>
  </head>
  <body>
  <center>
    <p>
      <span id="successMessage"><b>${messages.signUp}</b></span>
    </p>
  <h1>PenguinWeb</h1><br/>
  <div><a href="usercreate">SIGN UP</a></div>
  <div><a href="userlogin">LOG IN</a></div>

  <h1>Post</h1>
    <div><a href="allpost">Post</a></div><br/>
    <table border="1">
      <tr>
        <th>PostId</th>
        <th>Title</th>
        <th>Content</th>
        <th>Published</th>
        <th>Created</th>
      </tr>
      <c:forEach items="${allPosts}" var="post" >
        <div>
          <div><c:out value="${post.getTitle()}" /></div>
          <div><c:out value="${post.getContent()}" /></div>
          <div><c:out value="${post.getPicture()}" /></div>
          <div><img src="image/1.jpg" width="100px"></div>
          <div><fmt:formatDate value="${post.getCreated()}" pattern="MM-dd-yyyy hh:mm:sa"/></div>
        </div>
      </c:forEach>
    </table>
  </center>
  </body>
</html>
