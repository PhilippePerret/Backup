module Backup


  ##
  # Méthode principale procédant au backup en cas de modification
  def self.do_backup
    src = watched_path
    ext = File.extname(src)
    dst = File.join(BACKUP_FOLDER,"#{File.basename(watched_compactpath, ext)}-#{Time.now.to_i}#{ext}")
    FileUtils.cp(src, dst)
  end


end #/module Backup
