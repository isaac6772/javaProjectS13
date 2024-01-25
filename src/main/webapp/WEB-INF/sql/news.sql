show tables;

create table news(
	idx			int auto_increment,			/* 뉴스 테이블 기본키 */
	title		varchar(100),				/* 기사 제목 */
	postDate	datetime,					/* 뉴스 게시일 */
	reporter	varchar(20),				/* 기자 이름 */
	content		text,						/* 기사 내용 */
	link		varchar(200),				/* 원본 기사 링크 */
	fileName	varchar(500),				/* 기사에 들어간 사진 파일이름 */
	
	primary key(idx)
);