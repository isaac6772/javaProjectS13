show tables;

create table relation(
	idx			int auto_increment,		/* 관계테이블 기본키 */
	member1Idx	int not null,			/* 회원1의 idx */
	member2Idx	int not null,			/* 회원2의 idx */
	state		int not null,			/* 회원간의 관계 코드(0차단, 1요청, 2친구) */
	
	primary key(idx),
	foreign key(member1Idx) references member(idx) on delete cascade,
	foreign key(member2Idx) references member(idx) on delete cascade
);

desc relation;

insert into relation values (default,10,1,2);