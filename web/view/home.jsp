<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    String firstName = (String) session.getAttribute("firstName");
    String lastName = (String) session.getAttribute("lastName");
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link href="../css/home.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <!-- Admin Page -->
        <%-- if (role.equals("A")){ --%>
        <div class="start">
            <section class="hero-container">
                <nav class="header">
                    <div class="left">
                        <img src="https://activelearning.ph/wp-content/uploads/2021/03/logo-white.png" alt="Logo" class="img">
                    </div>
                    <div class="right">
                        <div>
                            <h1>Welcome <%= firstName %> <%= lastName %></h1>
                        </div>
                        <form action="logout.jsp" method="post">
                            <button class="logout-button" type="submit">Logout</button>
                        </form>
                    </div>
                </nav>
            </section>
        </div>
        <section class="hero-container">
            <div class="main-container main">
                <div class="top-container">
                        <form class="button-form" action="<%= request.getContextPath() %>/view/home.jsp">
                            <button class="buttons" type="submit">Manage Courses</button>
                        </form>
                        <form class="button-form" action="<%= request.getContextPath() %>/view/reports.jsp">
                            <button class="buttons" type="submit">Print Reports</button>
                        </form>
                        <form class="button-form" action="<%= request.getContextPath() %>/view/editAccount.jsp">
                            <button class="buttons" type="submit"">Edit Account</button>
                        </form>
                    
                </div>
                <div class="bottom-container">
                    <div class="course-container">
                        <div class="course-grid">
                            <div class="course-card">
                                <div class="course-info">
                                    <h2>Introduction to Java</h2>
                                    <div class="cont">
                                        <div class="left-cont">
                                            <p class="course-description">BLAH BLAH BLAH BLAH BLAH
                                                BLAH BLAH BLAH BLAH BLAH
                                                BLAH BLAH BLAH
                                                BLAH
                                            </p>
                                        </div>
                                        <div class="right-cont">
                                            <h3><b>Course ID:</b> </h3>
                                            <h3><b>Creator:</b> </h3>
                                            <h3><b>Price:</b> </h3>
                                            <h3><b>Class Hours:</b> </h3>
                                        </div>
                                    </div>
                                </div>
                                
                                
                                <div class="button-container">
                                    <form class="button-form" action="/2609_FAP/EditCourseServlet" method="get">
                                        <input type="hidden" name="courseId" value="1" />
                                        <button  style="background-color: rgba(32,155,222,255)"type="submit">Edit Course</button>
                                    </form>
                                    <form class="button-form" action="/2609_FAP/DeleteCourseServlet" method="get">
                                        <input type="hidden" name="courseId" value="1" />
                                        <button  style="background-color: red" type="submit">Delete Course</button>
                                    </form>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                </div>
                
            </div>
        </section>
        <%--} else { %>
        <section>
            <nav>
                <div>
                    <h1>Welcome <%= firstName %> <%= lastName %></h1>
                </div>
                <form action="logout.jsp" method="post">
                    <button type="submit">Logout</button>
                </form>
            </nav>
        </section>
        <section>
            <div>
                <div class="left-container">
                    <div class="course-container">
                        
                    </div>
                </div>
                <div class="right-container">
                    <div class="action-buttons">
                        <form action="<%= request.getContextPath() %>/view/home.jsp"">
                            <button type="submit">Manage Courses</button>
                        </form>
                        <form action="<%= request.getContextPath() %>/view/myCourses.jsp">>
                            <button type="submit">My Courses</button>
                        </form>
                        <form action="<%= request.getContextPath() %>/view/editAccount.jsp">
                            <button type="submit"">Edit Account</button>
                        </form>
                    </div>
                    
                </div>
            </div>
        </section>
        <%}%> --%>
    </body>
</html>
