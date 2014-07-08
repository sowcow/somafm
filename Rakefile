require './lib/soma'


SOMA_FILE = 'soma.yaml'
UPDATE_IMAGES = FALSE
IMAGES_DIR = 'public'

task default: :update


task :update do
  soma = Soma::Serializable.new
  soma.channels.each { |x|
    img_name = x.img.split(?/).last
    if UPDATE_IMAGES
      img = open(x.img).read
      File.write File.join(IMAGES_DIR, img_name), img
    end
    x.send :define_singleton_method, :img do img_name end
  }

  File.write SOMA_FILE, soma.to_yaml
end
