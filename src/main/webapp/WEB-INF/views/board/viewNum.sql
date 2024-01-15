show tables;

create table viewNum (
	idx			int auto_increment,		/* 조회수 테이블 기본키 */
	boardType	varchar(10) not null,	/* 게시판 종류 */
	boardIdx	int not null,			/* 게시판 idx */
	memberIdx	int not null,			/* 조회한 회원의 idx */
	viewDate	datetime not null,		/* 조회날짜 */
	
	primary key(idx)
);