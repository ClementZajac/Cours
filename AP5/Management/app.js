const fs = require("fs");

function diviserEtSauvegarderTexte(inputFile, longueurMax) {
  const texte = fs.readFileSync(inputFile, "utf-8");
  const morceaux = [];
  let debut = 0;
  let compteur = 1;

  while (debut < texte.length) {
    const morceau = texte.substr(debut, longueurMax);
    const nomFichier = `partie${compteur}.txt`;

    fs.writeFileSync(nomFichier, morceau, "utf-8");
    morceaux.push(nomFichier);

    debut += longueurMax;
    compteur++;
  }

  return morceaux;
}

// Exemple d'utilisation :
const inputFile = "texte.txt";
const longueurMax = 16384;
const fichiersMorceaux = diviserEtSauvegarderTexte(inputFile, longueurMax);

console.log("Fichiers créés :", fichiersMorceaux);
