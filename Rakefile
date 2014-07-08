require './lib/soma'


task default: :update

SOMA_FILE = 'soma.yaml'

task :update do
  soma = Soma::Serializable.new.to_yaml
  File.write SOMA_FILE, soma
end
