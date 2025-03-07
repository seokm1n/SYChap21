CREATE TABLE MEMBER (
	MEMBERID VARCHAR(10) NOT NULL PRIMARY KEY,
	PASSWORD VARCHAR(20) NOT NULL,
	NAME VARCHAR(20) NOT NULL,
	EMAIL VARCHAR(80)
)

INSERT INTO MEMBER(MEMBERID, PASSWORD, NAME, EMAIL) VALUES ('eral3', '5678', '최범균', 'madvirus@madvirus.net')

INSERT INTO MEMBER(MEMBERID, PASSWORD, NAME) VALUES ('madvirus', '1234', '최범균')

SELECT * FROM MEMBER

CREATE TABLE MEMBER_HISTORY (
MEMBERID VARCHAR2(10) PRIMARY KEY,
HISTORY VARCHAR2(250)
)

INSERT INTO MEMBER_HISTORY
VALUES ('madvirus', '2015스프링4프로그래밍입문<br>' || '2013 Spring4.0프로그래밍<br>'
|| '2012 객체지향과 디자인 패턴<br>' || '2012 JSP 2.2웹프로그래밍');


CREATE TABLE member (
    memberid VARCHAR2(50) PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    password VARCHAR2(10) NOT NULL,
    regdate DATE DEFAULT SYSDATE NOT NULL
);

-- article 테이블용 시퀀스 생성
CREATE SEQUENCE article_seq START WITH 1 INCREMENT BY 1;

-- article_content 테이블용 시퀀스 생성
CREATE SEQUENCE article_content_seq START WITH 1 INCREMENT BY 1;

-- article_content 테이블 생성
CREATE TABLE article_content (
    article_no INT PRIMARY KEY,
    content CLOB
);

-- article 테이블 생성
CREATE TABLE article (
    article_no INT PRIMARY KEY,
    writer_id VARCHAR2(50) NOT NULL,
    writer_name VARCHAR2(50) NOT NULL,
    title VARCHAR2(255) NOT NULL,
    regdate DATE NOT NULL,
    moddate DATE NOT NULL,
    read_cnt INT DEFAULT 0
);

-- article_content.article_no가 article.article_no를 참조하도록 외래 키 추가
ALTER TABLE article_content
ADD CONSTRAINT fk_article_content FOREIGN KEY (article_no)
REFERENCES article (article_no);

-- 데이터 삽입 시 article_no 자동 증가 처리 예시
INSERT INTO article (
    article_no, writer_id, writer_name, title, regdate, moddate, read_cnt
) VALUES (
    article_seq.NEXTVAL, 'user123', '홍길동', '오라클 테이블 생성', SYSDATE, SYSDATE, 0
);

INSERT INTO article_content (article_no, content)
VALUES (article_seq.CURRVAL, '이것은 게시글의 내용입니다.');

-- 시퀀스 생성 (이미 생성했다면 실행할 필요 없음)
CREATE SEQUENCE article_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 트리거 추가: article_no 값 자동 할당
CREATE OR REPLACE TRIGGER trg_article_no
BEFORE INSERT ON article
FOR EACH ROW
WHEN (NEW.article_no IS NULL)
BEGIN
    SELECT article_seq.NEXTVAL INTO :NEW.article_no FROM dual;
END;

DROP SEQUENCE article_seq; -- 기존 시퀀스 삭제

CREATE SEQUENCE article_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE; -- 다시 생성

