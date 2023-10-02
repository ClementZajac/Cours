const puppeteer = require("puppeteer");

(async () => {
  // Lancement du navigateur Puppeteer
  const browser = await puppeteer.launch();

  // Ouverture d'une nouvelle page
  const page = await browser.newPage();

  // Accès à l'URL du site web
  await page.goto("https://www.footmercato.net/club/real-madrid/effectif/");

  // Attendez que les données que vous souhaitez extraire soient chargées, cela peut nécessiter des ajustements en fonction du site web
  await page.waitForSelector('tr[data-native="1"]');

  // Extraction des éléments <tr data-native="1">
  const rows = await page.$$('tr[data-native="1"]');

  // Parcours de chaque élément <tr>
  for (const row of rows) {
    console.log("Nouveau joueur :");
    // Extraction des éléments <td> à l'intérieur de chaque ligne
    const cells = await row.$$("td");

    // Parcours de chaque élément <td>
    for (const cell of cells) {
      let content = await page.evaluate((el) => el.textContent.trim(), cell);
      content = content.replace(/\n/g, ""); // Supprimer les retours à la ligne
      if (content !== "") {
        content = content.replace(/\t/g, ""); // Supprimer les tabulations
        //supprimer les espaces
        content = content.replace(/  /g, "");

        console.log("   | " + content);
      }
    }
  }

  // Fermeture du navigateur Puppeteer
  await browser.close();
})();
