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

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ss" uri="http://www.cs.umd.edu/marmoset/ss"%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>


<c:if test="${empty sourceFiles}">
<jsp:forward page="submitProject.jsp">
<jsp:param name="projectPK" value="${project.projectPK}"/>
</jsp:forward>
</c:if>

<!DOCTYPE HTML>
<html>
<head>
   <ss:headContent title="Edit source code "/>
     <c:url var="codemirror" value="/codemirror" />
   <link rel="stylesheet" href="${codemirror}/lib/codemirror.css">
   </head>
	<body>

	<ss:header />
	<c:choose>
	<c:when test="${instructorCapability == 'true'}">
		<ss:instructorBreadCrumb />
	</c:when>
	<c:otherwise>
		<ss:breadCrumb />
	</c:otherwise>
	</c:choose>

    <ss:projectTitle />
	<c:if test="${instructorCapability == 'true'}">
		<ss:studentPicture/>
	</c:if>
    
    <ss:editSourceCode/>
    
    <ss:footer />
	</body>
</html>
