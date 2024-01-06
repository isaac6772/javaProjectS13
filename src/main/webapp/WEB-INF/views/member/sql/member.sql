show tables;

create table member (
	idx 		int not null auto_increment,		/* 회원 고유 번호 */
	mid			varchar(15) not null,				/* 회원 아이디 */
	pwd			varchar(100) not null,				/* 회원 비밀번호 */
	nickName	varchar(7) not null,				/* 회원 닉네임 */
	name		varchar(20) not null,				/* 회원 성명 */
	email		varchar(100) not null,				/* 회원 이메일 */
	gender		varchar(3) not null,				/* 회원 성별 */
	level		int default 1,						/* 회원 등급 */
	visitCnt	int default 1,						/* 방문횟수 */
	keyword		varchar(100),						/* 검색 키워드 */
	point 		int default 0,						/* 보유 포인트 */
	exp			int default 0,						/* 경험치 */
	joinDate	datetime default now(),				/* 가입날짜 */
	lastDate	datetime default now(),				/* 마지막방문일자 */
	profile		varchar(150) default 'noImage.jpg',	/* 프로필사진 */
	userInfo	varchar(5) default 'y',				/* 정보공개여부 */
	introduce	text,								/* 회원소개글 */
	
	primary key(idx),								/* 기본키 고유 번호 */
	unique(mid),									/* 유니크키 아이디 */
	unique(nickName),
	unique(email)
);

drop table member;

insert into member values(default,'test7',1234,'마포구보안관','테스트7','abc7@naver.com','남자',1,1,null,0,0,default,default,default,default,null);

-- 멤버idx가 1인 회원의 친구 데이터
select member.nickName from member where idx in (select member2idx from relation where member1idx = 1);

-- 멤버idx가 1인 회원의 로그인 정보가 포함된 데이터
select nickName,(select count(*) from login where memberIdx = member.idx) as login from member where idx in (select member2idx from relation where member1idx = 1) order by login desc, nickname;
