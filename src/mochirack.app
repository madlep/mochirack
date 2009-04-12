{application, mochirack,
 [{description, "mochirack"},
  {vsn, "0.01"},
  {modules, [
    mochirack,
    mochirack_app,
    mochirack_sup,
    mochirack_web,
    mochirack_deps
  ]},
  {registered, []},
  {mod, {mochirack_app, []}},
  {env, []},
  {applications, [kernel, stdlib, crypto]}]}.
