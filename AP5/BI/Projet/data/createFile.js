const fs = require("fs");

// Définir l'année de début et de fin
const anneeDebut = 2003;
const anneeFin = 2022;

// Parcourir chaque année
for (let annee = anneeDebut; annee <= anneeFin; annee++) {
  // Générer le nom du fichier .txt
  const nomFichier = `${annee}${annee + 1}.txt`;

  // Contenu du fichier (facultatif)
  const contenuFichier = ``;

  // Créer le fichier .txt
  fs.writeFileSync(nomFichier, contenuFichier);

  console.log(`Fichier ${nomFichier} créé.`);
}
