show tables;

create table service (
	idx			int auto_increment,			/* service 테이블 기본키 */
	refIdx		int,						/* 답글 게시물일 경우 참조하는 게시물의 idx */
	memberIdx	int not null,				/* 글 작성자idx */
	nickName	varchar(7) not null,		/* 작성자 닉네임 */
	title		varchar(50) not null,		/* 게시물 제목 */
	part		varchar(20) not null,		/* 게시물 타입(일반문의, 광고) */
	content		text not null,				/* 게시물 내용 */
	fileName	varchar(250),				/* 첨부된 파일의 이름 */
	writeDate	datetime default now(),		/* 게시일자 */
	open		varchar(10) default '비공개',	/* 정보공개 유무 */
	
	primary key(idx)
);

desc service;
drop table service;

insert into service values (default,20,1,'관리맨','답변드립니다','답변','안녕하세요',null,default,default);

-- 답글게시물이 있는 게시물을 표시하는 전체테이블
select *,(select bs.idx from service bs where s.idx = bs.refIdx) from service s;
