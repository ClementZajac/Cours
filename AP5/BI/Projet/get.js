const fs = require("fs");
const path = require("path");
const cheerio = require("cheerio");
const { constrainedMemory } = require("process");

const dossier = "data";

function startsWithNumber(str) {
  return /^\d/.test(str);
}

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

      const nomFichier = fichier.replace(".txt", "");
      const $ = cheerio.load(contenu);

      let poste = "";
      // Sélectionner les balises <tr data-native="1"> et <tr data-foreigner="1">
      $('tr[data-native="1"], tr[data-foreigner="1"]').each(
        (index, element) => {
          // Récupérer le texte de la balise
          const texte = $(element).text().trim();
          content = texte.replace(/\n/g, ""); // Supprimer les retours à la ligne
          content = content.replace(/\t/g, ""); // Supprimer les tabulations
          //supprimer les espaces
          content = content.replace(/  /g, ";");
          content = content.replace(/;+/g, ";");

          //console.log("moncontent:" + content);
          if (content.startsWith("#")) {
            const words = content.split(";");
            poste = words[1];
          }

          let myPointvirgule = "";
          if (!startsWithNumber(content)) {
            myPointvirgule = ";";
          }

          let display = true;
          if (content.includes("#")) {
            display = false;
          }

          // Vérifier si la ligne n'est pas vide après la suppression des espaces
          if (content.length > 0 && display) {
            console.log(
              myPointvirgule + content + ";" + nomFichier + ";" + poste + ";"
            );
          }
        }
      );
    });
  });
});
