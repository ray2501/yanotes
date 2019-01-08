#!/usr/bin/env escript
%% Create a table (require epgsql)

main(_) ->
    {ok, C} = epgsql:connect("localhost", "danilo", "danilo", #{
        database => "danilo",
        timeout => 1000
    }),
    {ok, _, _} = epgsql:squery(C, "create table if not exists Notes 
                  (id uuid DEFAULT md5(random()::text || clock_timestamp()::text)::uuid, 
                  title varchar(255), body text, created timestamp, 
                  PRIMARY KEY (id))"),
    ok = epgsql:close(C).
