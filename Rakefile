task :default => :build

desc "build files required to run app"
task :build => ["erlang:compile", "erlang:app", "erlang:ruby"]

namespace :erlang do
  
  ERL_SRC = FileList["src/**/*.erl"]
  BEAM_OUT = ERL_SRC.sub(/src/, 'ebin').sub(/\.erl$/, '.beam')
  desc "compile erlang source files in /src into beam files in /ebin"
  task :compile => BEAM_OUT
  rule(/\.beam$/ => [proc {|beam| beam.sub(/ebin/, 'src').sub(/\.beam$/, '.erl')}]) do |beam|
    erlc = "erlc -W -I ./include  +debug_info -o ./ebin #{beam.source}"
    puts erlc
    sh erlc
  end
  
  APP_SRC = FileList["src/**/*.app"]
  APP_OUT = APP_SRC.sub(/src/, 'ebin')
  desc "copy app files from src to ebin"
  task :app => APP_OUT
  rule(/ebin\/.+\.app/ => [proc{|app| app.sub(/ebin/, 'src')}]) do |app|
    copy app.source, app.name
  end
  
  RUBY_SRC = FileList["src/**/*.rb"]
  RUBY_OUT = RUBY_SRC.sub(/src/, 'ebin')
  desc "copy ruby files from src to ebin"
  task :ruby => RUBY_OUT
  rule(/ebin\/.+\.rb/ => [proc{|rb| rb.sub(/ebin/, 'src')}]) do |rb|
    copy rb.source, rb.name
  end
  
end