show tables;

create table discussion(
	idx				int auto_increment,				/* 토론 테이블 기본키 */
	memberIdx		int not null,					/* 토론 게시자 idx */
	subject			varchar(100) not null,			/* 토론 제목 */
	part			varchar(20) not null,			/* 토론 종류(뉴스,자유) */
	createdDate		datetime not null,				/* 토론 게시 날짜 */
	discussionDate	datetime not null,				/* 토론 예정일 */
	participant     varchar(200) not null,			/* 토론 참가자 */
	content			text not null,					/* 토론 내용 */
	primary key(idx)
);