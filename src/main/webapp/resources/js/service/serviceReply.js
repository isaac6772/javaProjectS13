'use strict';

function fileValid() {
	let file = document.getElementById("file");
	let fName = file.value;
	let ext = fName.substring(fName.lastIndexOf('.')+1);
	let maxSize = 1024 * 1024 * 10;
	
	if(ext!='jpg' && ext!='png' && ext!='gif') {
		alert("jpg, png, gif 형식의 사진파일만 업로드 가능합니다.")
		document.getElementById("file").value = "";
	}
	else if(file.size > maxSize) {
		alert("10MB 이하의 파일만 업로드 가능합니다.");
		document.getElementById("file").value = "";
	}
}

function formSubmit() {
	if($('#title').val().trim()=='') {
		alert("제목을 입력해주세요");
		$('#title').focus();
		return false;
	}
	else if($('#content').val().trim()=='') {
		alert("내용을 입력해주세요");
		$('#content').focus();
		return false;
	}
	myForm.submit();
}