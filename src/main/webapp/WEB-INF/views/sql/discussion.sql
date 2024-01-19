show tables;

create table discussion(
	idx				int auto_increment,				/* 토론 테이블 기본키 */
	memberIdx		int not null,					/* 토론 게시자 idx */
	subject			varchar(100) not null,			/* 토론 제목 */
	part			varchar(20) not null,			/* 토론 종류(뉴스,자유) */
	createdDate		datetime not null,				/* 토론 게시 날짜 */
	discussionDate	datetime not null,				/* 토론 예정일 */
	participant     varchar(200) not null,			/* 토론 참가자 */
	content			text,							/* 토론 내용 */
	state			varchar(20) not null,			/* 토론 상태(신청중,토론중,종료) */
	fileName		varchar(200),					/* 사진 파일 이름 */
	
	primary key(idx)
);

drop table discussion;

insert into discussion values (default,1,'윤대통령은 특검법을 수용해야하나?','뉴스',now(),'2024-01-20 12:00','1/2/5/',null,'신청중','noImage.jpg');