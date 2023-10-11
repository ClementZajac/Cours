const fs = require("fs");
const path = require("path");
const cheerio = require("cheerio");

const dossier = "data";

// Lire le contenu des fichiers HTML
fs.readdir(dossier, (err, fichiers) => {
  if (err) {
    console.error(`Erreur de lecture du dossier ${dossier}: ${err}`);
    return;
  }

  // Filtrer les fichiers HTML
  const fichiersHtml = fichiers.filter((fichier) => fichier.endsWith(".txt"));

  // Parcourir tous les fichiers HTML
  fichiersHtml.forEach((fichier) => {
    const cheminFichier = path.join(dossier, fichier);

    // Lire le contenu du fichier
    fs.readFile(cheminFichier, "utf8", (err, contenu) => {
      if (err) {
        console.error(`Erreur de lecture du fichier ${fichier}: ${err}`);
        return;
      }

      // Utiliser Cheerio pour charger le contenu HTML
      const $ = cheerio.load(contenu);

      // Sélectionner les balises <tr data-native="1"> et <tr data-foreigner="1">
      $('tr[data-native="1"], tr[data-foreigner="1"]').each(
        (index, element) => {
          // Récupérer le texte de la balise
          const texte = $(element).text().trim();

          // Supprimer les espaces en blanc (y compris espaces, tabulations et retours à la ligne)
          //const texteSansEspaces = texte.replace(/ \s+/g, ";");

          content = texte.replace(/\n/g, ""); // Supprimer les retours à la ligne

          content = content.replace(/\t/g, ""); // Supprimer les tabulations
          //supprimer les espaces
          content = content.replace(/  /g, ";");
          content = content.replace(/;+/g, ";");

          // Vérifier si la ligne n'est pas vide après la suppression des espaces
          if (content.length > 0) {
            console.log("*" + content + "\n");
          }
        }
      );
    });
  });
});
