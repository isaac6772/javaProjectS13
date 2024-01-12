show tables;

create table board(
	idx			int auto_increment,		/* 게시판 테이블 기본키 */
	memberIdx	int not null,			/* 게시글 작성자 idx */
	nickName	varchar(7),
	title		varchar(100) not null,	/* 게시글 제목 */
	content		text not null,			/* 게시글 내용 */
	contentText	text,					/* 게시글 텍스트 */
	part		varchar(20) not null,	/* 분류(일반, 정치, 연예) */
	viewNum		int default 0,			/* 조회수 */
	good		int default 0,			/* 추천 */
	bad			int default 0,			/* 비추천 */
	writeDate	datetime default now(),	/* 작성일자 */
	
	primary key(idx)
);
drop table board;

insert into board values (default,1,'관리맨','첫번째~','안녕하세요~','일반',0,0,0,default);

select REGEXP_REPLACE(content,'<[^>]+>', '') from board;

-- 이미지 파일을 포함하는지 여부를 추가해 제공
select *,case when content like '%<img src=%' then 1 else 0 end as result from board b;