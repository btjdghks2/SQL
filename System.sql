-- C## 없이 기존 방식대로 사용자 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = true;
DROP USER hr;
-- 연습용 데이터베이스 생성
@?\demo\schema\human_resources\hr_main.sql