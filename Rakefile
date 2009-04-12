namespace :erlang do
  
  ERL_SRC = FileList["src/**/*.erl"]
  BEAM_OUT = ERL_SRC.collect { |fn| beam = fn.sub(/src/, 'ebin').sub(/\.erl$/, '.beam') }
  
  desc "compile erlang source files in /src into beam files in /ebin"
  task :compile => BEAM_OUT
  rule(/\.beam$/ => [proc {|beam| beam.sub(/ebin/, 'src').sub(/\.beam$/, '.erl')}]) do |beam|
    erlc = "erlc -W -I ./include  +debug_info -o ./ebin #{beam.source}"
    puts erlc
    sh erlc
  end
end