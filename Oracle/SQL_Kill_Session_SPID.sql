SELECT s.inst_id,
       s.sid,
       s.serial#,
       p.spid,
       s.username,
       s.program
FROM   gv$session s
       JOIN gv$process p ON p.addr = s.paddr AND p.inst_id = s.inst_id
WHERE  s.type != 'BACKGROUND';
/
SELECT 'kill -9 '||p.spid||chr(13)
FROM   gv$session s
       JOIN gv$process p ON p.addr = s.paddr AND p.inst_id = s.inst_id
WHERE  s.type != 'BACKGROUND' ;
/
SELECT * FROM GE_PARAMETER WHERE PARAMETER_ID='PATH_PROCESS_SERVER';
/
SELECT * FROM GE_HOST;
/
SELECT * FROM DBA_USERS WHERE USERNAME LIKE '%CSE%';
/
SELECT value FROM V$PARAMETER WHERE NAME LIKE '%instance_name%';
/
ALTER USER MONITORDBA ACCOUNT LOCK;
/