/* Formatted on 2020/09/23 16:45 (Formatter Plus v4.8.8) */
DECLARE
   req_context   UTL_HTTP.request_context_key;
   http_req      UTL_HTTP.req;
   http_resp     UTL_HTTP.resp;
   url_text      VARCHAR2 (32767);
   resp_data     VARCHAR2 (1024);
BEGIN
   DBMS_OUTPUT.ENABLE (1000000);
   url_text := 'https://smtp.office365.com/';
   /*
       nginx: https://opencloud.openintl.com/status
       OCKS: https://opencloud.openintl.com/OSFWebSuite/UI/OCKSoap.svc
       OHS: https://opencloud.openintl.com/CEDENAR/OHS/
       Conexión a BD desde OHS: https://opencloud.openintl.com/CEDENAR/OHS/pls/SFAA0708A_OPEN/TESTCALLFROMWEB
       Conexión a DB desde IIS: Pendiente por desarrollar
       https://smtp.office365.com/
       https://smtp.gmail.com/
   */

   -- Crear un contexto para la solicitud con un Wallet y cookies
   req_context :=
      UTL_HTTP.create_request_context
           (wallet_path               => 'file:/u01/app/oracle/admin/A3B80I0C/xdb_wallet/',
            wallet_password           => 'P4ssDB#2020_',        --P4ssDB#2020_
            enable_cookies            => TRUE,
            max_cookies               => 300,
            max_cookies_per_site      => 20
           );
   -- Hacer una solicitud HTTP usando un contexto que incluye wallet y cookies
   http_req :=
      UTL_HTTP.begin_request (url                  => url_text,
                              request_context      => req_context);
   -- Si se necesita autenticación básica
   --UTL_HTTP.SET_AUTHENTICATION(HTTP_REQ, username, password);

   -- Obtener respuesta de la solicitud con contexto
   http_resp := UTL_HTTP.get_response (http_req);
   -- Obtener el codigo de respuesta de la solicitud
   DBMS_OUTPUT.put_line ('Response Code HTTP : ' || http_resp.status_code);

   -- Visualizar el codigo HTML de la respuesta a la solicitud HTTP
   BEGIN
      LOOP
         UTL_HTTP.read_text (http_resp, resp_data);
         DBMS_OUTPUT.put (resp_data);
      END LOOP;
   EXCEPTION
      WHEN UTL_HTTP.end_of_body
      THEN
         UTL_HTTP.end_response (http_resp);
   END;

   -- Destruir el contexto de la solicitud
   UTL_HTTP.destroy_request_context (req_context);
END;
/