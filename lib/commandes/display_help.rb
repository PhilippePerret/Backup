module Backup

  def self.display_help
    clear
    less TEXT_HELP
  end


TEXT_HELP = <<-HELP

#{'AIDE DE L’APPLICATION Backup'.bleu}

La commande #{'backup'.jaune} permet de suivre un fichier en train
d'être travaillé pour faire des copies de sauvegarde.

SURVEILLANCE D'UN FICHIER

On veut par exemple suivre le fichier 'MonFichier.ext', c'est-à-dire
en faire un backup chaque fois qu'on l'enregistre en le modifiant.

* Ouvrir un Terminal au dossier du fichier à surveiller,
* taper #{'backup Mon[TAB]'.jaune}
* taper Enter

Le fichier est mis en surveillance.


HELP

end #/module Backup
