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
			
			
			<style>
				.uploadResult{
					width: 100%;
					background-color: gray; 
				}
				
				.uploadResult ul{
					display: flex;
					flex-flow: row;
					justify-content: center;
					align-items: center;
				}
				
				.uploadResult ul li{
					list-style: none;
					padding: 10px;
				}
				
				.uploadResult ul li img{
					width: 100px;
				}
			</style>
			
			
			<div class="uploadDiv">
				<input type='file' name='uploadFile' multiple>
			</div>
			
			<div class='uploadResult'>
				<ul>
				
				</ul>
			</div>
			
			<button id='uploadBtn'>Upload</button>
			
			<script src="https://code.jquery.com/jquery-3.3.1.js"
  			integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
  			crossorigin="anonymous"></script>
  			
  			<script>
  				$(document).ready(function(){
  					
  					var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
  					var maxSize = 5242880; //5MB

  					function checkExtension(fileName, fileSize){
  					    
  					    if(fileSize >= maxSize){
  					        alert("파일 사이즈 초과");
  					        return false;
  					    }

  					    if(regex.test(fileName)){
  					        alert("해당 종류의 파일은 업로드할 수 없습니다");
  					        return false;
  					        }
  					    return true;
  					}
  					
  					var cloneObj = $(".uploadDiv").clone();
  					
  					$("#uploadBtn").on("click", function(e){
  						
  						var formData = new FormData();
  						
  						var inputFile = $("input[name='uploadFile']");
  						
  						var files = inputFile[0].files;
  						
  						console.log(files);
  						
  						//add File Data to formData
  						for (var i = 0; i < files.length; i++) {

  							if (!checkExtension(files[i].name, files[i].size)) {
  								return false;
  							}
	                formData.append("uploadFile", files[i]);
	            }
  						
  						$.ajax({
  							url: '/uploadAjaxAction',
  							processData: false,
  							contentType: false,
  							data: formData,
  							type: 'POST',
  							dataType: 'json',
  							success: function(result){
  								console.log(result);
  								
  								showUploadedFile(result);
  								
  								$(".uploadDiv").html(cloneObj.html());
  							}
  						});	//$.ajax
  					});
  					
  					var uploadResult = $(".uploadResult ul");
  					function showUploadedFile(uploadResultArr) {
  				  	var str = "";

  				  $(uploadResultArr).each(function(i, obj){
  				      
  				      if(!obj.image){
  				        str += "<li><img src='/resources/img/attach.png'>"+obj.fileName+"</li>";
  				      }else{
  				        //str += "<li>"+ obj.fileName+"</li>";
  				        
  				        var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid+"_"+obj.fileName);
  				        
  				        str += "<li><img src='/display?fileName="+fileCallPath+"'><li>";
  				      }
  				    });

  				    uploadResult.append(str);
  				    }
  				});
  			</script>
			
		</body>
</html>