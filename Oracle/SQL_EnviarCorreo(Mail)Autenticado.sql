/* Formatted on 2020/09/23 16:45 (Formatter Plus v4.8.8) */
SELECT *
  FROM ge_parameter
 WHERE UPPER (parameter_id) IN ('HOST_MAIL', 'HOST_MAIL_PORT', 'WALLET_PATH');

--SMTP365RLY.open.com.co Puerto 25
--smtp.office365.com Puerto 587

-- mail.subace.com.mx 26 envíos 110 recibir
-- Usuario: info@subace.com.mx Contraseña: SubasE-19r13*

--SET serveroutput on

DECLARE
   --Office365 SMTP Server
   k_host          CONSTANT VARCHAR2 (100)      := 'smtp.office365.com';
   --Hotmail y Outlook SMTP Servers
   --k_host            CONSTANT VARCHAR2(100) := 'smtp-mail.outlook.com';
   k_port          CONSTANT INTEGER             := 587;
   k_wallet_path   CONSTANT VARCHAR2 (100)
                          := 'file:/u01/app/oracle/admin/A3A80I0C/xdb_wallet';
   k_wallet_pass   CONSTANT VARCHAR2 (100)      := 'P4ssDB#2020_';
                                                   --P4ssDB#2020_  0p3n#2020_
   k_domain        CONSTANT VARCHAR2 (100)      := 'localhost';
   k_username      CONSTANT VARCHAR2 (100)      := 'jose.david@openintl.com';
   k_password      CONSTANT VARCHAR2 (100)      := 'Open.2020';
   -- Clave del correo
   k_sender        CONSTANT VARCHAR2 (100)      := 'jose.david@openintl.com';
   k_recipient     CONSTANT VARCHAR2 (100)      := 'jose.david@openintl.com';
   k_subject       CONSTANT VARCHAR2 (100)      := 'Prueba';
   k_body          CONSTANT VARCHAR2 (100)      := 'Esto es una prueba';
   l_conn                   UTL_SMTP.connection;
   l_reply                  UTL_SMTP.reply;
   l_replies                UTL_SMTP.replies;
BEGIN
   DBMS_OUTPUT.put_line ('utl_smtp.open_connection');
   l_reply :=
      UTL_SMTP.open_connection (HOST                               => k_host,
                                port                               => k_port,
                                c                                  => l_conn,
                                wallet_path                        => k_wallet_path,
                                wallet_password                    => k_wallet_pass,
                                secure_connection_before_smtp      => FALSE
                               );

   IF l_reply.code != 220
   THEN
      raise_application_error (-20000,
                                  'utl_smtp.open_connection: '
                               || l_reply.code
                               || ' - '
                               || l_reply.text
                              );
   END IF;

   DBMS_OUTPUT.put_line ('utl_smtp.ehlo');
   l_replies := UTL_SMTP.ehlo (l_conn, k_domain);

   FOR ri IN 1 .. l_replies.COUNT
   LOOP
      DBMS_OUTPUT.put_line (l_replies (ri).code || ' - '
                            || l_replies (ri).text
                           );
   END LOOP;

   DBMS_OUTPUT.put_line ('utl_smtp.starttls');
   l_reply := UTL_SMTP.starttls (l_conn);

   IF l_reply.code != 220
   THEN
      raise_application_error (-20000,
                                  'utl_smtp.starttls: '
                               || l_reply.code
                               || ' - '
                               || l_reply.text
                              );
   END IF;

   DBMS_OUTPUT.put_line ('utl_smtp.ehlo');
   l_replies := UTL_SMTP.ehlo (l_conn, k_domain);

   FOR ri IN 1 .. l_replies.COUNT
   LOOP
      DBMS_OUTPUT.put_line (l_replies (ri).code || ' - '
                            || l_replies (ri).text
                           );
   END LOOP;

   DBMS_OUTPUT.put_line ('utl_smtp.auth');
   l_reply :=
          UTL_SMTP.auth (l_conn, k_username, k_password, UTL_SMTP.all_schemes);

   IF l_reply.code != 235
   THEN
      raise_application_error (-20000,
                                  'utl_smtp.auth: '
                               || l_reply.code
                               || ' - '
                               || l_reply.text
                              );
   END IF;

   DBMS_OUTPUT.put_line ('utl_smtp.mail');
   l_reply := UTL_SMTP.mail (l_conn, k_sender);

   IF l_reply.code != 250
   THEN
      raise_application_error (-20000,
                                  'utl_smtp.mail: '
                               || l_reply.code
                               || ' - '
                               || l_reply.text
                              );
   END IF;

   DBMS_OUTPUT.put_line ('utl_smtp.rcpt');
   l_reply := UTL_SMTP.rcpt (l_conn, k_recipient);

   IF l_reply.code NOT IN (250, 251)
   THEN
      raise_application_error (-20000,
                                  'utl_smtp.rcpt: '
                               || l_reply.code
                               || ' - '
                               || l_reply.text
                              );
   END IF;

   DBMS_OUTPUT.put_line ('utl_smtp.open_data');
   l_reply := UTL_SMTP.open_data (l_conn);

   IF l_reply.code != 354
   THEN
      raise_application_error (-20000,
                                  'utl_smtp.open_data: '
                               || l_reply.code
                               || ' - '
                               || l_reply.text
                              );
   END IF;

   DBMS_OUTPUT.put_line ('utl_smtp.write_data');
   UTL_SMTP.write_data (l_conn, 'From: ' || k_sender || UTL_TCP.crlf);
   UTL_SMTP.write_data (l_conn, 'To: ' || k_recipient || UTL_TCP.crlf);
   UTL_SMTP.write_data (l_conn, 'Subject: ' || k_subject || UTL_TCP.crlf);
   UTL_SMTP.write_data (l_conn, UTL_TCP.crlf || k_body);
   DBMS_OUTPUT.put_line ('utl_smtp.close_data');
   l_reply := UTL_SMTP.close_data (l_conn);

   IF l_reply.code != 250
   THEN
      raise_application_error (-20000,
                                  'utl_smtp.close_data: '
                               || l_reply.code
                               || ' - '
                               || l_reply.text
                              );
   END IF;

   DBMS_OUTPUT.put_line ('utl_smtp.quit');
   l_reply := UTL_SMTP.quit (l_conn);

   IF l_reply.code != 221
   THEN
      raise_application_error (-20000,
                                  'utl_smtp.quit: '
                               || l_reply.code
                               || ' - '
                               || l_reply.text
                              );
   END IF;
END;
/