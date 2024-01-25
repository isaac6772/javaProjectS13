show tables;

create table alarm (
	idx					int auto_increment,			/* 알람 기본 테이블 */
	memberIdx			int not null,				/* 알람 대상자 */
	alarmType			varchar(20) not null,		/* 알람 타입(채팅, 댓글, 토론, 문의답글) */
	alarmTypeIdx		varchar(20) not null,				/* 각 타입에 해당하는 idx(채팅은 chat테이블의 idx, 댓글은 boardIdx, 답글은 serviceIdx) */
	alarmDate			datetime,					/* 알람 생성 날짜 */
	readCheck			varchar(10) default '안읽음',	/* 알람 읽은 여부 */
	
	primary key(idx),
	foreign key(memberIdx) references member(idx) on delete cascade
);

drop table alarm

select nickName from member ;