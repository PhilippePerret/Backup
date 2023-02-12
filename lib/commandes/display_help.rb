module Backup

  def self.display_help
    clear
    less TEXT_HELP
  end


TEXT_HELP = <<-HELP

#{'AIDE DE L’APPLICATION Backup'.bleu}

La commande #{'backup'.jaune} permet de suivre un fichier en train
d'être travaillé pour faire des copies de sauvegarde.

HELP

end #/module Backup
