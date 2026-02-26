<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalTime" %>

<%
    String name = "Farouk";
    String demo = request.getParameter("demo"); // demo=morning or demo=afternoon
    String greet;

    if ("morning".equalsIgnoreCase(demo)) {
        greet = "Good morning";
    } else if ("afternoon".equalsIgnoreCase(demo)) {
        greet = "Good afternoon";
    } else {
        int hour = LocalTime.now().getHour();
        greet = (hour < 12) ? "Good morning" : "Good afternoon";
    }
%>

<html>
<head><title>COMP367</title></head>
<body>
<h1><%= greet %>, <%= name %>, Welcome to COMP367</h1>
</body>
</html>