show tables;

create table recommend(
	idx			int auto_increment,
	boardType	varchar(10) not null,	/* 게시판 종류 */
	boardIdx	int not null,			/* 게시판 idx */
	memberIdx	int not null,			/* 추천 회원의 idx */
	flag		int not null,			/* 1:추천 2:비추천 */
	
	primary key(idx)
);

insert into recommend values (default,'board',43,1,1);