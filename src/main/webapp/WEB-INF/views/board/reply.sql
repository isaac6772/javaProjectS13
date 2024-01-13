show tables;

create table reply(
	idx			int auto_increment,			/* 댓글 테이블 기본키 */
	memberIdx	int not null,				/* 댓글 작성자 idx */
	nickName	varchar(7) not null,		/* 작성자 닉네임 */
	boardType	varchar(10) not null,		/* 게시판 종류 */
	boardIdx	int not null,				/* 게시판 idx */
	content		text not null,				/* 댓글 내용 */
	writeDate	datetime default now(),		/* 작성일자 */
	replyIdx	int,						/* 대댓글이 참조하는 댓글idx */
	
	primary key(idx)
);

desc reply;

insert into reply values (default,2,'지리산산신령','board',27,'환영합니다',default,16);
