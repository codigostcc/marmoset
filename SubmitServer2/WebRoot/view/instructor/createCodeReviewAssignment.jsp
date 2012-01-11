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


<!DOCTYPE HTML>
<html>
<head>
<c:url var="jsBase" value="/js" />

<link
	href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.7/themes/base/jquery-ui.css"
	rel="stylesheet" type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"
	type="text/javascript"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.7/jquery-ui.min.js"
	type="text/javascript"></script>
 <link href="${jsBase}/timePicker.css"  rel="stylesheet" type="text/css" />
<script src="${jsBase}/jquery.timePicker.js" type="text/javascript"></script>

<script type="text/javascript">
	$(function() {
		$('#deadline-date').datepicker({
			minDate : -1,
			defaultDate : +7,
			 dateFormat: "yy-mm-dd",
				  onSelect: function( selectedDate ) {
		               
		               $( "#deadline-time").focus();
				  }
		});
		
		  $("#deadline-time").timePicker({
              show24Hours: false,
              step: 60,
              defaultTime: "06:00 PM"});
	});
	 
</script>

<ss:headContent
	title="Create code review for Project ${project.projectNumber} : ${project.title}" />


</head>

<body>
	<ss:header />
	<ss:instructorBreadCrumb />

	<div class="sectionTitle">
		<h1>New Code Review for project ${project.projectNumber}</h1>

		<p class="sectionDescription">Fill out the following form to
			create a new code review for project ${project.projectNumber} :
			${project.title}</p>
	</div>

	<p></p>
	<form class="form"
		action='<c:url value="/action/instructor/CreateCodeReviewAssignment"/>'
		method="POST" name="createCodeReviewForm">

		<input type="hidden" name="coursePK" value="${course.coursePK}">
		<input type="hidden" name="projectPK" value="${project.projectPK}" />


		<table class="form">
			<colgroup>
				<COL class="label" />
				<COL class="input" />
			</colgroup>
			         <tfoot>
            <tr class="submit">
                    <td colspan="2">Add rubrics: 
                     <button id="add-numeric-button">Add Numeric</button>
        <button id="add-dropdown-button">Add Dropdown</button>
        <button id="add-checkbox-button">Add Checkbox</button>
                    
                    </td>
                    </tr>

                <tr class="submit">
                    <td colspan="2"><input type="submit"
                        value="Create Code Review">
                    </td>
                </tr>
            </tfoot>
			<tbody>
				<tr>
					<td class="label">description</td>
					<td class="input"><INPUT TYPE="text" NAME="description"
						size="60" required>
					</td>

				</tr>
				<tr>
					<td class="label">deadline</td>
					<td><INPUT TYPE="text" id="deadline-date" NAME="deadline-date" PLACEHOLDER="yyyy-mm-dd" size="12" required>
        <INPUT TYPE="text" id="deadline-time" NAME="deadline-time" PLACEHOLDER="hh:mm aa" size="12" title="leave time blank for one second before midnight" />
					
					</td>

				</tr>
				<tr>
					<td class="label">review of</td>
					<td class="input"><select name="of">
					<c:if test="${! empty justStudentSubmissions}">
							<option value="all" selected>all student submissions</option>
							</c:if>
							<c:forEach var="studentRegistration"
								items="${staffStudentSubmissions}">
									<option
									value="${lastSubmission[studentRegistration.studentRegistrationPK].submissionPK}">${studentRegistration.fullname}</option>

							</c:forEach>
					</select>
					</td>
				</tr>
				<tr>
					<td class="label"># reviews per student submission</td>
					<td class="input"><select name="numReviewers">
							<option>1</option>
							<option>2</option>
							<option>3</option>
					</select>
					</td>
				</tr>
				<tr>
					<td class="label">Anonymous</td>
					<td class="input"><input type="checkbox" name="anonymous"
						value="true" /></td>
				</tr>
				<tr>
					<td class="label">Can see comments from other reviewers</td>
					<td class="input"><input type="checkbox" name="canSeeOthers"
						value="true" /></td>
				</tr>

				<tr>
					<td class="label">Reviewers<br></td>
					<td><INPUT TYPE="CHECKBOX" NAME="studentReviewers" CHECKED>students
						<c:forEach var="studentRegistration" items="${courseInstructors}">
							<br>
							<INPUT TYPE="CHECKBOX"
								NAME="reviewer-${studentRegistration.studentPK}">${studentRegistration.fullname}
			</c:forEach></td>
				</tr>


            </tbody>


		</table>

		<h1>Rubrics</h1>
			<input type="hidden" name="rubric-count" id="rubric-count" value="0" />
		<div id="rubricTable" style="display: none">
		<table>
			<thead>
				<tr>
					<th>Kind</th>
					<th>Name</th>
					<th>Point values</th>
					<th>description</th>
				</tr>
			</thead>
			<tbody  id="rubric-table">
			</tbody>
		</table>
		</div>
	</form>
	<ss:script file="jsrender.js" />
	<script id="rubricTemplate" type="text/x-jquery-tmpl">
            <tr id="rubric-{{=count}}">
                <th>{{=header}}</th>
                <td>
                    <input type="hidden" name="{{=prefix}}-presentation" value="{{=presentation}}" />
                    <input type="text" name="{{=prefix}}-name" size="20" placeholder="Name of rubric item"/>
                </td>
                <td>
                    {{=editWidgets!}}
                </td>
                <td>
                    <input type="text" name="{{=prefix}}-description" size="50" placeholder="a longer description of this rubric item"/>
                </td>
            </tr>
        </script>

	<script id="dropdownTemplate" type="text/x-jquery-tmpl">
            <input type="hidden" name="{{=prefix}}-value" id="{{=prefix}}-hidden"/>
            <select id="{{=prefix}}-select"></select>
            <button id="{{=prefix}}-edit-button">edit dropdown</button>
        </script>
	<script id="numericTemplate" type="text/x-jquery-tmpl">
            <label for="{{=prefix}}-min-input">min:</label>
            <input type="text" name="{{=prefix}}-min" id="{{=prefix}}-min-input" placeholder="min"  size="4">

            <label for="{{=prefix}}-max-input">max:</label>
            <input type="text" name="{{=prefix}}-max" id="{{=prefix}}-max-input" placeholder="max"  size="4">

            <label for="{{=prefix}}-default-input">default:</label>
            <input type="text" name="{{=prefix}}-default" id="{{=prefix}}-default-input" placeholder="default"  size="4">
        </script>
	<script id="checkboxTemplate" type="text/x-jquery-tmpl">
            <input type="checkbox" value="ignore" onclick="return false;"  >
            <input type="text" name="{{=prefix}}-false" title="value if not checked" size="4" value="0" required="required">
            &nbsp;
            <input type="checkbox" value="ignore"   onclick="return false;"  CHECKED >
            <input type="text" name="{{=prefix}}-true" title="value if checked"  size="4" required="required">
        </script>

	<div id="edit-dialog" style="display: none">
		<select id="edit-dialog-dropdown-select"></select>
		<div>
			<input type="text" id="edit-dialog-value-input" />
			<input type="number" id="edit-dialog-score-input" min="-1000" max="1000" />
		</div>
		<div>
			<span id="edit-dialog-controls">
				<button id="edit-dialog-add">add</button>
				<button id="edit-dialog-delete">delete</button>
				<button id="edit-dialog-clear-all">clear all</button>
			</span>
		</div>
	</div>

	<ss:script file="rubrics.js" />
	<script type="text/javascript">
		var dropdownEditor = new marmoset.DropdownEditor("#edit-dialog");
		var manager = new marmoset.RubricManager("#rubric-table",
				dropdownEditor);
		manager.setAddDropdownButton("#add-dropdown-button");
		manager.setAddNumericButton("#add-numeric-button");
		manager.setAddCheckboxButton("#add-checkbox-button");
		$(manager).one('change', function(event) {
			$("#rubricTable").show();
		});
		$(manager).change(function(event) {
			$("#rubric-count").val(manager.rubricCount);
		});
	</script>

	<ss:footer />
</body>
</html>
