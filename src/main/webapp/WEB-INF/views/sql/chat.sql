show tables;

create table chat (
	idx 			int auto_increment,			/* 채팅방 기본키 */
	memberIdx		int not null,				/* 보낸사람idx */
	receiver		int,						/* 받는사람idx */
	chatType		varchar(20),				/* 채팅타입(1:1채팅, 토론채팅) */
	discussionIdx	int,						/* 채팅이 이루어진 토론방 번호 */
	message			text,						/* 채팅 내용 */
	msgDate			datetime,					/* 채팅 시간 */
	
	primary key(idx)
);

drop table chat;