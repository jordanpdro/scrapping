** README concernant le scrapping **

Le code proposé ici répond à des exercices de base sur le scrapping

** dark_trader.rb **

but de l'exercice: récupérer les noms des crypto monnaies listées dans un tableau HTML, puis leurs valeurs, et les associer dans un array de hashes

Les méthodes:

__methode list_names:__ va rechercher les valeur de la colonne nom depuis le fichier html scrappé, pui retourne en array les contenant

__methode list_prices:__ va rechercher les valeur de la colonne prix depuis le fichier html scrappé, pui retourne en array les contenant

__methode currency_value:__ associe chaque nom à une valeur dans des hashes, qui seront envoyés dans un array_urls
(affichage limité à 10 valeurs pour ne pas faire chauffer ton ordi)

** mairie_christmas.rb **

but de l'exercice: récupérer les adresses mails de chaque commune d'un département

Les méthodes:

__méthode endget_townhall_email:__ localise et scrappe une adresse mail dans le fichier html

__méthode get_townhall_urls:__ fournit un array des URL des mairies du département ciblé

__méthode city_mail_association:__ associe les 2 méthodes précédentes, scrappe chaque URLs ciblé pour en ressortir une adresse mail, puis créer des hashes {nom de ville => adresse mail} qui s'ajouteront dans un tableau

** cher_depute.rb **

but de l'exercice: récupérer les prénoms, noms, et adresses mails des députés, et les classer dans un array de hashes {prénoms, noms, email}

__méthode get_depute_name:__ insère dans un array le nom complet de chaque député

__méthode get_firstname:__ à partir du array précédemment créer, recrée un array avec seulement le prénoms

__méthode get_lastname:__ récupère seulement le nom de famille depuis le premier array créé

__méhode get_email:__ créer les adresses mails à partir des prénoms, noms et extension

__méthode full full_identity:__ créer un array de hashes {nom, prénom, mail} pour chaque député
