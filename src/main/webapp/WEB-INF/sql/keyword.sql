show tables;

create table keyword (
	idx			int auto_increment,		/* 키워드 테이블 기본키 */
	keyword		varchar(20) not null,	/* 키워드 */
	searchDate	datetime not null, 		/* 검색된 시간 */
	
	primary key(idx)
);

-- 현재날짜 이전으로 7일까지의 키워드 데이터
select keyword as text,count(*) as count from keyword where searchDate >= date_sub(curdate(),interval 7 day) group by keyword;
