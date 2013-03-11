<%--

 Marmoset: a student project snapshot, submission, testing and code review
 system developed by the Univ. of Maryland, College Park
 
 Developed as part of Jaime Spacco's Ph.D. thesis work, continuing effort led
 by William Pugh. See http://marmoset.cs.umd.edu/
 
 Copyright 2005 - 2011, Univ. of Maryland
 
 Licensed under the Apache License, Version 2.0 (the "License"); you may not
 use this file except in compliance with the License. You may obtain a copy of
 the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 License for the specific language governing permissions and limitations under
 the License.

--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ss" uri="http://www.cs.umd.edu/marmoset/ss"%>

<!DOCTYPE HTML>
<html>

<c:choose>
<c:when test="${ empty project}">
<c:set var="title">
All code reviews for <c:out value="${course.courseName}"/>
</c:set>
<c:set var="fullTitle">
All code reviews for <c:out value="${course.fullDescription}"/>
</c:set>
</c:when>
<c:otherwise>
<c:set var="title">
All code reviews for project 
<c:out value="${project.projectNumber}"/>
in <c:out value="${course.courseName}"/>
</c:set>
<c:set var="fullTitle">
All code reviews for project 
<c:out value="${project.projectNumber}"/>
in <c:out value="${course.fullDescription}"/>
</c:set>
</c:otherwise>
</c:choose>

<ss:head title="${title}" />

<body>
<ss:header />
<ss:breadCrumb />

<div class="sectionTitle">
	<h1>${fullTitle}</h1>

	<ss:hello/>
</div>

<ss:codeReviews title=""/>

<ss:footer/>
</body>
</html>
