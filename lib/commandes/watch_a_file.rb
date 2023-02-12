module Backup

  def self.watch_a_file(args)
    path = nil
    if args && args.key?(:path)
      path = args[:path]
    end
    clear
    puts "Surveillance d'un fichier/dossier…".bleu
    #
    # S'il existe un fichier CURRENT_WATCHED, il faut demander si 
    # c'est ce fichier/dossier qui doit être surveillé
    # 
    if path.nil? && current?
      if Q.yes?("Est-ce le fichier #{watched_relpath} qu'il faut suivre ?".jaune)
        path = watched_path
      end
    end
    path ||= Q.ask("Fichier à surveiller : ".jaune) || begin
      puts "OK, je m'arrête là…".bleu
      return
    end
    puts "OK, je suis cet élément…".bleu
    path = find_path_with_path(path)
    unless path.nil?
      if File.exist?(path)
        memo_watched_path(path)
        watch_path(path)
      else
        puts "Le chemin #{path.inspect} est introuvable.".rouge
      end
    end    
  end


  def self.watch_path(path)
    begin
      `fswatch -ox "#{path}" | xargs -n1 -I{} ~/Programmes/Backup/on_change.rb`
    rescue Exception => e
      puts e.inspect
      # File.delete(memo_path) if File.exist?(memo_path)
    end
  end

end #/module Backup
