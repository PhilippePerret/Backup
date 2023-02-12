module Backup

  ##
  # Entrée du programme
  # 
  def self.run
    path = nil
    clear
    if help?
      require_and_run('display_help')
    elsif ARGV[0]
      path = find_path_with_path(ARGV[0]) || return
      watch_file(path)
    else
      choix = choisir_operation || return
      case choix
      when :surveiller
        watch_file(nil)
      when :recuperer
        require_and_run('retrieve_backups')
      when :help
        require_and_run('display_help')
      when :force_cleanup
        require_and_run('cleanup_backups')
      end
    end
  end

  def self.watch_file(path)
    require_and_run('watch_a_file', **{path: path})
  end

  def self.require_and_run(commande, **args)
    require "#{APP_FOLDER}/lib/commandes/#{commande}"
    case method(commande.to_sym).arity
    when 0
      send(commande.to_sym)
    when 1
      send(commande.to_sym, args)
    end
  end

  def self.memo_watched_path(path)
    File.open(memo_path, 'wb'){|f| f.write path}
  end

  # @return true s'il y a un fichier courant
  # @note
  #   Il y en a pratiquement toujours, puisque pour le moment le
  #   fichier n'est pas détruit.
  # 
  def self.current?
    File.exist?(memo_path) && File.exist?(watched_path)
  end

  def self.watched_path
    File.read(memo_path).strip
  end

  # @return [String] Chemin relatif utilisé pour les backups
  # pour éviter les collisions
  def self.watched_compactpath
    watched_relpath.gsub(/\//,'_').gsub(/[ \-]/,'_')
  end

  # @return [String] Chemin relatif (juste pour indication)
  def self.watched_relpath
    relpath = watched_path.split("/")[-3..-1].join("/")
  end

  def self.find_path_with_path(path)
    return File.expand_path(path) if File.exist?(path)
    cfolder = File.expand_path('.')
    Dir["#{cfolder}/*.*"].each do |pth|
      puts "Path testé contre #{path.inspect} : #{File.basename(pth).inspect}"
      if File.basename(pth).match?(/#{path}/i)
        return pth
      end
    end
    return path
  end


  def self.memo_path
    @@memo_path ||= File.join(APP_FOLDER,'CURRENT_WATCHED')
  end

  private

    def self.choisir_operation
      Q.select("Exécuter l'opération…".jaune, OPERATIONS, **{per_page:OPERATIONS.count, show_help: false})
    end

OPERATIONS = [
  {name:"Suivre un fichier/dossier" , value: :surveiller},
  {name:"Récupérer un backup"       , value: :retrieve},
  {name:"Aide"                      , value: :help},
  {name:"Nettoyer le dossier"       , value: :force_cleanup},
  {name:"Renoncer".orange           , value: nil}
]
end #/module Backup
