<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/thml4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" 
		content="text/html; charset=UTF-8" >
		<title>Insert title here</title>
	</head>
		<body>
			<h1>Upload with Ajax</h1>
			
			<div class="uploadDiv">
				<input type='file' name='uploadFile' multiple>
			</div>
			
			<button id='uploadBtn'>Upload</button>
			
			<script src="https://code.jquery.com/jquery-3.3.1.js"
  			integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
  			crossorigin="anonymous"></script>
  			
  			<script>
  				$(document).ready(function(){
  					
  					$("#uploadBtn").on("click", function(e){
  						
  						var formData = new FormData();
  						
  						var inputFile = $("input[name='uploadFile']");
  						
  						var files = inputFile[0].files;
  						
  						console.log(files);
  						
  						//add File Data to formData
  						for(var i = 0; i < files.length; i++){
  							formData.append("uploadFile", files[i]);
  						}
  						
  						$.ajax({
  							url: '/uploadAjaxAction',
  							processData: false,
  							contentType: false,
  							data: formData,
  							type: 'POST',
  							success: function(result){
  								alert("Uploaded");
  							}
  						});	//$.ajax
  					});
  				});
  			</script>
			
		</body>
</html>