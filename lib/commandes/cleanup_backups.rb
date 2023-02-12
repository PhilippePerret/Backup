module Backup

  ##
  # Méthode de nettoyage des backups
  # 
  # Il y deux pistes principales pour les candidats à la destruction
  #   1) Quand un fichier est trop vieux (il faut déterminer ce que
  #      signifie "vieux")
  #   2) Quand les backups sont nombreux pour le même fichier lui-même
  # 
  def self.cleanup_backups
    Object.const_set('CEST_DEJA_VIEUX', Time.now.to_i - 90.jours)

    table_backups = {}

    Dir["#{BACKUP_FOLDER}/*.*"].each do |path|
      extname = File.extname(path)
      affixe, time = File.basename(path,extname).split('-')
      keyaffixe = "#{affixe}-#{extname}"
      unless table_backups.key?(keyaffixe)
        table_backups.merge!(keyaffixe => {affixe:affixe, extname:extname, times:[] })
      end
      table_backups[keyaffixe][:times] << time.to_i
    end

    nombre_watched = table_backups.count
    nombre_deleted = 0

    table_backups.each do |kaffixe, dbackup|
      dbackup.merge!(count: dbackup[:times].count)
      #
      # Classement par 
      # 
      dbackup[:times].sort!
      # 
      # Premier et dernier temps
      # 
      dbackup.merge!(first_time: dbackup[:times].first)
      dbackup.merge!(last_time: dbackup[:times].last)
    end.reject do |kaffixe, dbackup|
      # 
      # On ne traite que les backups quand il y en a plus de
      # 30
      # OU ceux qui sont vieux
      # 
      dbackup[:count] < 30 || dbackup[:last_time] < CEST_DEJA_VIEUX
    end.each do |kaffixe, dbackup|
      if dbackup[:count] > 30
        diff = dbackup[:count] - 30
        (0...diff).to_a.each do |i|
          time = dbackup[:times][i]
          bkup_path = File.join(BACKUP_FOLDER,"#{dbackup[:affixe]}-#{time}#{dbackup[:extname]}")
          File.delete(bkup_path)
        end
      end
      nombre_deleted += 1
    end

    # 
    # TODO : logguer les résultats
    # 

    return [nombre_watched, nombre_deleted]
  end

  # (surtout pour tester le nettoyage)
  # 
  def self.force_cleanup
    clear
    puts "Nettoyage forcé (pour essai principalement)".bleu
    nombre_watched, nombre_deleted = cleanup_backups
    puts "\nNombre d'éléments backupés : #{nombre_watched}".vert
    puts "Nombre de backups détruits : #{nombre_deleted}".vert
    puts "\n"
  end

end #/module Backup
