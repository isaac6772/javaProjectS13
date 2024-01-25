show tables;

create table ad(
	idx			int auto_increment,		/* 광고테이블 기본키 */
	serviceIdx	int not null,			/* 참조중인 서비스테이블의 기본키 */
	fileName	varchar(250) not null,	/* 광고할 이미지 파일 */
	adDate		datetime default now(),	/* 광고게시날짜 */
	
	primary key(idx),
	foreign key(serviceIdx) references service(idx) on delete cascade
);

drop table ad;

insert into ad values (default,1,'ad3.jpg',now());