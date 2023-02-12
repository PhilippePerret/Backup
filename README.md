# Backup

Marre de perdre des heures de travail…

Cette application en ligne de commande permet de suivre un fichier en train d'être travaillé en en faisant des backups dès qu'il est modifié.

## Surveillance d'un fichier

> Si [la commande `backup` a été créée](#creer-commande-backup)

* On ouvre un dossier au fichier à surveiller (ça n'est pas obligé, mais c'est le plus simple),
* on tape `backup ` suivi des premières lettres du fichier,
* => l'application propose de surveiller le fichier (en donnant le nom complet),
* on confirme que c'est bien le fichier à surveiller

## Récupération d'un fichier

En cas de problème de fichier corrompu, on peut simplement récupérer une version récente en tapant `backup` et en choisissant "Récupérer un backup" (ou équivalent).

<a name="creer-commande-backup"></a>

## Créer la commande `backup`

On fait simplement un alias qui pointe vers le script.

~~~bash

> ln -s /path/to/folder/Backup/backup.rb /usr/local/bin/backup

~~~
