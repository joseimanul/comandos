SELECT 'ALTER SYSTEM DISCONNECT SESSION '||chr(39)||SID||','||serial#||',@'||inst_id||chr(39)||' IMMEDIATE;--'||username||' '||program from
(
    SELECT s.username, s.SID, s.serial#, s.inst_id,s.program
    FROM gv$session s, gv$process p
    WHERE s.paddr = p.addr
    AND s.inst_id = p.inst_id
    AND s.username IS not null
    AND s.audsid <> sys_context('USERENV', 'SESSIONID')
    AND s.program <> 'FlexManager.exe'
    AND s.schemaname  in ('OPEN')
	AND lower(s.program) not like 'rman@%'         --RMAN
	AND lower(s.program) not like 'exp@%'          --export
	AND lower(s.program) not like 'ude@%'          --Data Pump
	AND lower(s.program) not like 'oracle@%(dm%)%' --Data Pump Master
	AND lower(s.program) not like 'oracle@%(dw%)%' --Data pump Worker
	AND lower(s.program) not like 'emagent@%'      --Enterprise Management Agent
	AND lower(s.program) not like 'oms'            --Oracle Management Server (OMS)
	AND lower(s.program) not like 'oraagent%@%'    --Agente Clusterware
	AND lower(s.program) not like 'demonio@%'      --Demonio
   -- AND UPPER (S.USERNAME) NOT IN (SELECT USERNAME FROM GE_USER_SESSION_EXCLUD  )
	--AND lower (s.module) like '%PROCESS%'
    --and lower(s.program)  like 'oracle@ip-172-10-6-5 (P%'
    --AND UPPER(S.USERNAME) = 'OPENPRUE'
    --AND UPPER(s.Module) = 'EXECUTOR_PROCESS'
    --and UPPER(s.osuser) = 'SQL'
    --AND s.sid in (857,856,1703,2275,2274)
    --and s.sid= 60
)


