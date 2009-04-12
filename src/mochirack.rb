require 'rubygems'
require 'erlectricity'
require 'stringio'

module Rack
  module Handler
    class Mochirack
      def self.run(app, options={})
        receive do |f|
          f.when(:env, Object) do |env|
            env = env.inject({}){|env_hash, kv| env_hash[kv[0]] = kv[1].to_s; env_hash } 
            status, headers, body = app.call(env)
            # f.send!(:response, env.inspect)
            f.send!(:response, [
              [:status, status], 
              [:headers, headers.to_a], 
              [:body, build_body(body)]
            ])
            exit
            # f.receive_loop
          end
        end
      end
      
      private
      def self.build_body(body)
        body_str = ""
        body.each{|str| body_str << str}
        body_str
      end
    end
  end
end