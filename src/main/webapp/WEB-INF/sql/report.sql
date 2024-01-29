show tables;

create table report(
	idx				int auto_increment,			/* 신고테이블 기본키 */
	reportType		varchar(20) not null,		/* 신고대상의 유형(board, reply 등) */
	reportIdx		int not null,				/* 신고대상의 고유번호 */
	memberIdx		int not null,				/* 신고대상의 회원idx */
	part			varchar(20) not null,		/* 신고 내용 분류 */
	content			text not null,				/* 신고 상세 내용 */
	reportDate		datetime not null,			/* 신고 날짜 */
	reporter		int not null,				/* 신고한 사람 */
	checkField		varchar(50),				/* 처리 유무 */
	
	primary key(idx)
);

