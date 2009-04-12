-module(rack).

-export ([handle_request/1]).

handle_request(Request) ->
  Cmd = "rackup ebin/lobster.ru",
  Port = open_port({spawn, Cmd}, [{packet, 4}, use_stdio, exit_status, binary]), 
  Payload = term_to_binary({env, build_env(Request)}),
  port_command(Port, Payload),
  receive
    {Port, {data, Data}} ->
      {response, Text} = binary_to_term(Data),
      io:format("~p~n", [Text]),
      {
        {status, _Status},
        {headers, _Headers},
        {body, Body}
      } = Text,
      Body
  end.
  
build_env(Request) ->
  % io:format("~p~n", [Request:get(headers)]),
  {Path, Query, _Fragment} = mochiweb_util:urlsplit_path(Request:get(raw_path)),
  [Host, Port] = string:tokens(Request:get_header_value("host"), ":"),
  {
    {<<"REQUEST_METHOD">>, Request:get(method)},
    {<<"SCRIPT_NAME">>, <<"">>},
    {<<"PATH_INFO">>, list_to_binary(Path)},
    {<<"QUERY_STRING">>, list_to_binary(Query)},
    {<<"SERVER_NAME">>, list_to_binary(Host)},
    {<<"SERVER_PORT">>, list_to_binary(Port)}
  }.