show tables;

create table login(
	idx 		int auto_increment,
	memberIdx 	int not null,
	
	primary key(idx),
	foreign key(memberIdx) references member(idx) on delete cascade
);

desc login;