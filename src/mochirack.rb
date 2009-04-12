require 'rubygems'
require 'erlectricity'
require 'stringio'

receive do |f|
  f.when(:env, Object) do |env|
    f.send!(:response, env.inspect)
    # f.receive_loop
  end
end