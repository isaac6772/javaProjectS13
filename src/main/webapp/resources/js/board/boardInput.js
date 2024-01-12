$(function() {
	CKEDITOR.replace("content",{
		height : 480,
		filebrowserUploadUrl: contextPath + "/imageUpload",	/* 파일(이미지) 업로드 시에 매핑경로 */
		uploadUrl : contextPath + "/imageUpload"			/* 여러개의 그림파일을 드래그&드롭해서 올릴 수 있다. */
	});
});

function inputFormSubmit() {
	inputForm.submit();
}