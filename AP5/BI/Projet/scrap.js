const puppeteer = require("puppeteer");

(async () => {
  // Lancement du navigateur Puppeteer
  const browser = await puppeteer.launch();

  // Ouverture d'une nouvelle page
  const page = await browser.newPage();

  // Accès à l'URL du site web
  await page.goto("http://localhost/bi/test.html");

  // await page.waitForSelector('tr[data-native="1"]');
  // const rows = await page.$$('tr[data-native="1"]');

  joueurs = "";

  list = ['tr[data-native="1"]', 'tr[data-foreigner="1"]'];

  for (l of list) {
    console.log(l);

    await page.waitForSelector(l);
    const rows = await page.$$(l);

    // Parcours de chaque élément <tr>
    let number = 0;
    for (const row of rows) {
      //console.log("Nouveau joueur :");
      // Extraction des éléments <td> à l'intérieur de chaque ligne
      const cells = await row.$$("td");

      // Parcours de chaque élément <td>
      let i = 0;
      for (const cell of cells) {
        let content = await page.evaluate((el) => el.textContent.trim(), cell);
        content = content.replace(/\n/g, ""); // Supprimer les retours à la ligne
        if (content !== "") {
          content = content.replace(/\t/g, ""); // Supprimer les tabulations
          //supprimer les espaces
          content = content.replace(/  /g, "");

          if (i == 1) {
            //extraire les nombres
            age = content.replace(/\D/g, "");
            //console.log(" mon age  | " + age);
            nom = content.replace(age + " ans", "");
            //console.log("  mon nom | " + nom);

            joueurs += nom + ";" + age + ";";
            flag = false;
          } else {
            joueurs += content + ";";
            //console.log("   | " + content);
          }
        }
        i++;
      }
      joueurs += "\n";
      number++;
    }
  }
  console.log(joueurs);

  // Fermeture du navigateur Puppeteer
  await browser.close();
})();
