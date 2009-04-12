%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc TEMPLATE.

-module(mochirack).
-author('author <author@example.com>').
-export([start/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.
        
%% @spec start() -> ok
%% @doc Start the mochirack server.
start() ->
    mochirack_deps:ensure(),
    ensure_started(crypto),
    application:start(mochirack).

%% @spec stop() -> ok
%% @doc Stop the mochirack server.
stop() ->
    Res = application:stop(mochirack),
    application:stop(crypto),
    Res.
