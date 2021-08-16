/*Wait Problem    Potential Fix
Free buffer    Increase the DB_CACHE_SIZE; shorten the checkpoint; tune the code.
Buffer busy    Segment header: Add freelists or freelist groups or use ASSM.
Buffer busy    Data block: separate hot data; use reverse key indexes; small block sizes.
Buffer busy    Data block: increase initrans and/or maxtrans.
Buffer busy    UNDO header: use automatic undo management.
Buffer busy    UNDO block: commit more; use automatic undo management.
Latch free    Investigate the detail.
Log buffer space    Increase the log buffer; use faster disks for the redo logs.
Scattered read    Indicates many full table scans: tune the code; cache small tables.
Sequential read    Indicates many index reads: tune the code (especially joins).
Write complete waits    Adds database writers; checkpoint more often; buffer cache too small.
Some latch problems have often been bug related in the past, so make sure you check Metalink for issues related to latches. 
Any of the latches that have a hit ratio less than 99 percent should be investigated.
----------------------------------------
Latch Problem    Potential Fix
-----------------------------------------
Library cache:              Use bind variables; adjust the SHARED_POOL_SIZE.
Shared pool:                Use bind variables; adjust the SHARED_POOL_SIZE.
Row cache objects:          Increase the shared pool. This is not a common problem.
Cache buffers chain:        Shouldn’t be a problem in 11g. If you get this latch wait,
it means you need to reduce logical I/O rates by tuning and minimizing the I/O requirements of the SQL involved. 
High I/O rates could be a sign of a hot block (meaning a block highly accessed). 
Cache buffer lru chain latch contention can be resolved by increasing the size of the buffer cache 
and thereby reducing the rate at which new blocks are introduced into the buffer cache.
 Multiple buffer pools, if it’s found they are needed, 
can help reduce contention. You can also create additional cache buffer lru chain latches by adjusting the configuration parameter 
DB_BLOCK_LRU_LATCHES. You may be able to reduce the load on the cache buffer chain latches by increasing the configuration parameter.
 _DB_BLOCK_HASH_BUCKETS may need to be increased or set to a prime number, but this should not be needed in 11g.
  Keep in mind there are now in memory updates (IMU) to consider as well.
*/
--11g
SELECT /*+RULE */ 
            SYSDATE fecha
            ,s.inst_id inst
            ,s.sid
            ,s.serial#
            ,s.schemaname
            ,s.username
            ,s.module
            ,s.client_info 
            ,w.event
            ,w.seconds_in_wait
            ,s.sql_id
            ,S.PREV_SQL_ID
           ,(SELECT sql_text FROM gv$sql u WHERE s.inst_id = u.inst_id and u.sql_id = s.sql_id and rownum = 1) AS QUERY
            ,s.program
            ,s.osuser
            ,s.machine
            ,s.terminal
            ,s.type
            ,s.lockwait
            ,s.status  
            ,s.action
            --,(SELECT object_name  FROM dba_objects  WHERE object_id = s.row_wait_obj#)  object_name
            ,s.row_wait_obj#,s.row_wait_file#, s.row_wait_block#, s.row_wait_row#, s.logon_time, s.last_call_et
            ,s.blocking_session_status
            ,s.blocking_instance
            ,s.blocking_session
            ,w.seq#
            ,w.p1text, w.p1, w.p2text, w.p2, w.p3text, w.p3
            ,w.wait_time
            ,w.state
            ,p.spid 
            ,p.pga_used_mem, p.pga_alloc_mem, p.pga_max_mem
        from gv$session s, gv$process p, gv$session_wait w
        where s.paddr = p.addr 
            and s.sid = w.sid
            --AND s.sid = 3044
            and s.inst_id=p.inst_id
            and s.inst_id=w.inst_id
          and s.event not like 'Streams%'
           and type !=  'BACKGROUND'
           --AND BLOCKING_SESSION IS NOT NULL
           --AND s.USERNAME = 'CHERNANM'
           --AND s.username  = 'ACASTRL'
           --AND ACTION LIKE 'Proceso HSTSS%'
            and w.event not in ('jobq slave wait','pipe get','SQL*Net message from client','SQL*Net message to client','Streams AQ: waiting for messages in the queue')
            --and w.event not in ('SQL*Net message to client','SQL*Net message from client')
            order by w.seconds_in_wait DESC,P1;
            