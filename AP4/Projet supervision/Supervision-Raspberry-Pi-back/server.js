require('dotenv').config();
const pingService = require('ping');
const bodyParser = require('body-parser');
const express = require('express');
const crypto = require('crypto');
const bcrypt = require('bcryptjs');
const mysql = require('mysql');
const snmp = require('net-snmp');
const cors = require('cors');
const jwt = require('jsonwebtoken');
const { map } = require('mssql');
const app = express();


app.use(express.json());
app.use(cors({ origin: '*' }));

const port = process.env.PORT || 5000;

let table = 'raspberry';

// configuration de la base de données MySQL
const connection = mysql.createConnection({
	host: process.env.DB_HOST,
	user: process.env.DB_USER,
	password: process.env.DB_PASSWORD,
	database: 'raspberry'
});

connection.connect();

app.use((err, req, res, next) => {
	console.error(err.stack);
	res.status(500).send('Une erreur est survenue');
});


app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Configuration de la clé secrète JWT
const secretKey = process.env.SECRET_KEY;

app.post('/api/setMode', (req, res) => {
  	const { mode } = req.body;
	if(mode==='Production'){
		console.log("Mode set to production");
		table = 'raspberry';
	}else{
		console.log("Mode set to simulation");
		table = 'raspberrysimulation';
	}
	res.status(200).json({ message: 'Mode changé' });
});

app.get('/api/getMode', (req, res) => {

	let monMode = 'Production';
	if(table==='raspberrysimulation'){
		monMode = 'Simulé';
	}
	res.json({ mode: monMode });
});

// // Fonction pour hacher le mot de passe
//const saltRounds = 10;
// async function hashPassword(password) {
//   const salt = await bcrypt.genSalt(saltRounds);
//   const hash = await bcrypt.hash(password, salt);
//   console.log("-------------------");
//   console.log(hash);
//   return hash;
// }
// hashPassword("admin");

//API pour l'authentification
app.post('/api/auth', (req, res) => {
  const { username, password } = req.body;

  	const sql = `SELECT * FROM raspberry.users WHERE username="`+ username +'";';
	connection.query(sql, (err, results) => {
		if (err) throw err;
		if(results.length == 0){ 
			return res.status(401).json({ message: 'Utilisateur introuvable' });
		}else{

			bcrypt.compare(password, results[0].password, (err, isMatch) => {
				if (err) {
					console.error(err);
					return;
				}
				if (isMatch) {
					console.log("Connexion réussie pour l'utilisateur : "+username);
					const token = jwt.sign({ username }, secretKey, { expiresIn: '1h' });
					return res.status(200).json({ token });
				} else {
					return res.status(401).json({ message: 'Mot de passe incorect' });
				}
			});
		}
	});
});

//API pour recupérer les données de l'utilisation du CPU
app.get('/api/usagecpu', (req, res) => {
	const sql = `SELECT timestamp,usagecpu FROM raspberry.${table} WHERE timestamp BETWEEN DATE_SUB(NOW(), INTERVAL 1 HOUR) AND NOW() ORDER BY id ASC`;

	connection.query(sql, (err, results) => {
		if (err) throw err;
		if(results.length == 0){ 
			results = [0,0];	
		}else{
			const usagecpu = results.map(x => x.usagecpu);
			const time = results.map(x => x.timestamp.getHours()+":"+(x.timestamp.getMinutes()<10?'0':'')+x.timestamp.getMinutes());
			results = [usagecpu,time];
		}
		res.json(results);
	});
});

//API pour recupérer les données de l'utilisation de la RAM
app.get('/api/usageram', (req, res) => {
	//Rq SQL : revoie tout les enregistrement qui datent d'il y a moins d'une heure, pour le champ 'usageram'
	const sql = `SELECT timestamp,usageram FROM raspberry.${table} WHERE timestamp BETWEEN DATE_SUB(NOW(), INTERVAL 1 HOUR) AND NOW() ORDER BY id ASC`;
	connection.query(sql, (err, results) => {
		if (err) throw err;
		if(results.length == 0){ 
			results = [0,0];	
		}else{
			//Stockage de l'ensemble des valeurs dans un tableau pour les afficher dans le graphique
			const usageram = results.map(x => x.usageram);
			//Stockage de l'ensemble des valeurs temporelles dans un tableau pour les afficher dans le LABEL du graphique
			const time = results.map(x => x.timestamp.getHours()+":"+(x.timestamp.getMinutes()<10?'0':'')+x.timestamp.getMinutes());
			results = [usageram,time];
		}
		res.json(results);
	});
});

//API pour recupérer les données de l'utilisation de la RAM
app.get('/api/temperature', (req, res) => {
	//Rq SQL : revoie tout les enregistrement qui datent d'il y a moins d'une heure, pour le champ 'temperature'
	const sql = `SELECT timestamp,temperature FROM raspberry.${table} WHERE timestamp BETWEEN DATE_SUB(NOW(), INTERVAL 1 HOUR) AND NOW() ORDER BY id ASC`;
	connection.query(sql, (err, results) => {
		if (err) throw err;
		if(results.length == 0){ 
			results = [0,0];	
		}else{
			//Stockage de l'ensemble des valeurs dans un tableau pour les afficher dans le graphique
			const temperature = results.map(x => x.temperature);
			//Stockage de l'ensemble des valeurs temporelles dans un tableau pour les afficher dans le LABEL du graphique
			const time = results.map(x => x.timestamp.getHours()+":"+(x.timestamp.getMinutes()<10?'0':'')+x.timestamp.getMinutes());
			results = [temperature,time];
		}
		res.json(results);
	});
});

//API pour recupérer les données de l'utilisation de la RAM
app.get('/api/usagestorage', (req, res) => {
	const sql = `SELECT usagestorage FROM raspberry.${table} WHERE usagestorage IS NOT NULL ORDER BY id DESC LIMIT 1`;
	connection.query(sql, (err, results) => {
		if (err) throw err;
		if(results.length == 0){
			results = [0,0];
		}
		res.json(results);
	});
});

//API pour récuperer le statut de la BDD
app.get('/api/accessbdd', (req, res) => {
	const sql = 'SELECT id FROM raspberry.raspberry LIMIT 1';
	connection.query(sql, (err, results) => {
		if (err) throw err;
		if(results.length == 0){
			res.json(0);
		}
		if(results[0]["id"]=="1"){
			res.json("Oui");
		}else{
			res.json("Non");
		}
	});
});

//API pour récuperer les logs d'erreur du projet SIMEC
app.get('/api/log', (req, res) => {
	// const sql = 'SELECT COUNT(*) FROM performance_schema.error_log;';
	// connection.query(sql, (err, results) => {
	// 	if (err) throw err;
	// 	if(results.length == 0){
	// 		results = [0,0];
	// 	}
	// 	res.json(results[0]["COUNT(*)"]);
    // });
	res.json(0);
});

//API pour récuperer le statut du site du projet SIMEC
app.get('/api/site', (req, res) => {
	//fetch("10.224.0.224:4200").then(function(response) {
	// 	if(response.ok) {
	// 		res.json("Oui");
	// 	} else {
	// 		res.json("Non");
	// 	}
	//   })
	//   .catch(function(error) {
	// 	res.json("Non");
	//   });
	res.json(0);
});

// PING
app.get('/api/ping', (req, res) => {
	pingService.sys.probe(options.host, function(isAlive) { 
	  const ping = isAlive; 
	  if (ping) {
		res.json('réussi');
	  } else {
		res.json('échoué');
	  }
	});
  });

//SSH
app.get('/api/ssh', (req, res) => {
	const sql = 'SELECT sshlogin FROM raspberry WHERE sshlogin IS NOT NULL ORDER BY id DESC LIMIT 1';
	connection.query(sql, (err, results) => {
		let ssh = results[0].sshlogin;
		if (err) throw err;
		if(results.length == 0){
			res.json(0);
		}
		if(ssh==1){
			res.json("Oui");
		}else{
			res.json("Non");
		}
	});
});

//VNC
app.get('/api/vnc', (req, res) => {
	const sql = 'SELECT vnclogin FROM raspberry WHERE vnclogin IS NOT NULL ORDER BY id DESC LIMIT 1';
	connection.query(sql, (err, results) => {
		let vnc = results[0].vnclogin;
		if (err) throw err;
		if(results.length == 0){
			res.json(0);
		}
		if(vnc==1){
			res.json("Oui");
		}else{
			res.json("Non");
		}
	});
});

// Bande passante Wifi
app.get('/api/bandwidthWifi', (req, res) => {
	const sql = 'SELECT bandwidthWifi FROM raspberry WHERE bandwidthWifi IS NOT NULL ORDER BY id DESC LIMIT 1';
	connection.query(sql, (err, results) => {
		let wifi = results[0].bandwidthWifi;
		if (err) throw err;
		if(results.length == 0){
			res.json(0);
		}
		else res.json(wifi);
	});
});

// Bande passante filaire
app.get('/api/bandwidthFilaire', (req, res) => {
	const sql = 'SELECT bandwidthFilaire FROM raspberry WHERE bandwidthFilaire IS NOT NULL ORDER BY id DESC LIMIT 1';
	connection.query(sql, (err, results) => {
		let filaire = results[0].bandwidthFilaire;
		if (err) throw err;
		if(results.length == 0){
			res.json(0);
		}
		else res.json(filaire);
	});
});

//MAJ
app.get('/api/MAJ', (req, res) => {
	const sql = 'SELECT MAJ FROM raspberry WHERE MAJ IS NOT NULL ORDER BY id DESC LIMIT 1';
	connection.query(sql, (err, results) => {
		let a = results[0].MAJ;
		if (err) throw err;
		if(results.length == 0){
			res.json(0);
		}

		if(a==1){
			res.json("Votre système est à jour");
		}else{
			res.json("Veuillez faire la mise à jour du sytème");
		}
	});
});

//remise a zero de la simulation
app.get('/api/reset', (req, res) => {
	const aujourdhui=new Date();

	const jour=`${aujourdhui.getFullYear()}-${aujourdhui.getMonth()+1}-${aujourdhui.getDate()}`;

	let pingval ="1";

	const sql = `TRUNCATE TABLE raspberry.raspberrysimulation`;
			connection.query(sql, (err, results) => {
				if (err) throw err;
			});

	for (let i = aujourdhui.getHours()-1; i <aujourdhui.getHours()+2; i++) {
		for(let j = 1; j <60; j++) {
			
			const sql = `INSERT INTO raspberry.raspberrysimulation  (timestamp,usagecpu,ping,temperature) VALUES ('${jour} ${i}:${j}:00','${j}','${pingval}','${j}')`;
			connection.query(sql, (err, results) => {
				if (err) throw err;
			});
		}
		
		if(i>=aujourdhui.getHours()){pingval ="0";}
	}
	  res.json(0);
});

//Supprimer un enregistrement de la simulation
app.post('/api/supprimer', (req, res) => {
	const reqbody = req.body;
	const id = reqbody['id']
	const sql = `DELETE FROM raspberry.raspberrysimulation WHERE id = ${id}`;
	connection.query(sql, (err, results) => {
		if (err) throw err;	
	});
	res.json(0);
});

//Ajouter un enregistrement à la simulation
app.post('/api/ajouter', (req, res) => {
	const reqbody = req.body;
	const timestamp =reqbody["timestamp"];
	const usagecpu =reqbody["usagecpu"];
	const pingval =reqbody["ping"];
	const temperature =reqbody["temperature"];

	const sql = `INSERT INTO raspberry.raspberrysimulation (timestamp,usagecpu,ping,temperature)  VALUES ('${timestamp}','${usagecpu}','${pingval}','${temperature}')`;
	connection.query(sql, (err, results) => {
		if (err) throw err;	
	});
	res.json(0);
});

//Modifier un enregistrement de la simulation
app.post('/api/modifier', (req, res) => {
	const reqbody = req.body;
	const timestamp = reqbody["timestamp"];
	const usagecpu = reqbody["usagecpu"];
	const pingval = reqbody["ping"];
	const temperature = reqbody["temperature"];
	const id = reqbody['id']
	const sql = `UPDATE raspberry.raspberrysimulation SET timestamp='${timestamp}',usagecpu='${usagecpu}',ping='${pingval}',temperature='${temperature}' WHERE id=${id}`;
	connection.query(sql, (err, results) => {
		if (err) throw err;	
	});
	res.json(0);
});

//Requete CRUD
app.get('/api/modifier', (req, res) => {
	const reqbody = req.body;
	const id = reqbody['id']
	const sql = `SELECT timestamp, temperature,usagecpu,ping,id FROM raspberrysimulation WHERE id = '${id}'`;
	connection.query(sql, (err, results) => {
		if (err) throw err;
		if(results.length == 0){
			res.json(0);
		}
		else res.json(results);
	});
});

//Requete CRUD
app.get('/api/id', (req, res) => {
	const sql = 'SELECT timestamp, temperature,usagecpu,ping,id FROM raspberrysimulation ORDER BY timestamp DESC';
	connection.query(sql, (err, results) => {
		if (err) throw err;
		if(results.length == 0){
			res.json(0);
		}
		else res.json(results);
	});
});


// démarrage du serveur sur le port 3000
const server = app.listen(port, function () {
	console.log('http://localhost:' + port + '/');
	console.log('Server is running on port ' + port);
});


//------------------SNMP------------------//

const options = {
	host: '10.224.0.224', //Adresse IP du raspberry
	port: 161,
	community: 'public'
};

const session = snmp.createSession(options.host, options.community);

//Variables de chaque champs de la base de données
let userdatabase = null, userwebsite = null, physicallogin = null, sshlogin = null, vnclogin = null, databaselogin = null, websitelogin = null, temperature = null, usagecpu = null, usageram = null, usagestorage = null, maxstorage = null, powersupply = null, ping = null, bandwidthWifi = null,bandwidthFilaire = null,MAJ = null;
pingService.sys.probe(options.host, function(isAlive) { ping = isAlive; });

//Variables pour les calculs
let ramDispo = null, ramTotal = null, ssCpuRawUser = null, ssCpuRawSystem = null, ssCpuRawNice = null, ssCpuRawIdle = null, wifiInputFlow = null, wifiOuputFlow = null, wiredInputFlow = null, wiredOuputFlow = null, versionDispo = null,versionOS;

//OID - variable - description
const monoid = [
	['1.3.6.1.4.1.2021.4.11.0',ramDispo,"RAM disponible"],
	['1.3.6.1.4.1.2021.4.5.0',ramTotal,'RAM Total'],
	['1.3.6.1.4.1.2021.11.50.0',ssCpuRawUser,'Utilisation du CPU par le user'],
	['1.3.6.1.4.1.2021.11.52.0',ssCpuRawSystem,'Utilisation du CPU par le système'],
	['1.3.6.1.4.1.2021.11.51.0',ssCpuRawNice,'Nombre cycle horloge CPU utilisateur'],
	['1.3.6.1.4.1.2021.11.53.0',ssCpuRawIdle,'Nombre cycle horloge CPU total'],
	['1.3.6.1.2.1.2.2.1.10.3',wifiInputFlow,'flux en entrée wifi'],
	['1.3.6.1.2.1.2.2.1.16.3',wifiOuputFlow,'flux en sortie wifi'],
	['1.3.6.1.2.1.2.2.1.10.2',wiredInputFlow,'flux en entrée filaire'],
	['1.3.6.1.2.1.2.2.1.16.3',wiredOuputFlow,'flux en sortie filaire'],
	['1.3.6.1.2.1.25.1.8',temperature,'température CPU']
	//Ajouter la version de l'OS
]
//Récupère la dernière version disponible d'ubuntu
const axios = require('axios');
const cheerio = require('cheerio');


const getLatestLTSVersion = async () => {
  try {
    const response = await axios.get('https://ubuntu.com/download/server');
    const $ = cheerio.load(response.data);
    const version = $('button.p-button--positive').text().match(/Ubuntu Server (\d+\.\d+\.\d+) LTS/)[1];
    return version;
  } catch (error) {
    console.error(error);
  }
};

getLatestLTSVersion().then((version) => {
  versionDispo = version;
});


let oid = monoid.map(x => x[0]);

function serviceGetInfosFromMIB() {

	pingService.sys.probe(options.host, function(isAlive) { ping = isAlive; });
	if(ping){
		
		session.get(oid, function (error, varbinds) {
			if (error) {
				console.error(error);
			} else {
				//console.log(varbinds
				ramDispo = varbinds[0].value;
				ramTotal = varbinds[1].value;
				ssCpuRawUser = varbinds[2].value;
				ssCpuRawSystem = varbinds[3].value;
				ssCpuRawNice = varbinds[4].value;
				ssCpuRawIdle = varbinds[5].value;
				wifiInputFlow = varbinds[6].value;
				wifiOuputFlow = varbinds[7].value;
				wiredInputFlow = varbinds[8].value;
				wiredOuputFlow = varbinds[9].value;
				temperature = Math.round(varbinds[10].value/1000) / 1;
				//console.log(temperature)
				//Calculs
				usagecpu = ((ssCpuRawUser + ssCpuRawSystem) / (ssCpuRawNice + ssCpuRawUser + ssCpuRawSystem + ssCpuRawIdle)) * 100;
				usagecpu = Math.round(usagecpu * 100) / 100;
				bandwidthWifi = (wifiInputFlow + wifiOuputFlow) * 8;
				bandwidthFilaire = (wiredInputFlow + wiredOuputFlow) * 8;
				//versionOS = '22.04.2' a ajouter avec la MIB
				if (versionDispo.toString() === versionOS){
					MAJ = 1;
				}else {
					MAJ = 0;
				}
			}
		});	
	}

	const sql = `INSERT INTO raspberry \
	(userdatabase, userwebsite, physicallogin, sshlogin, vnclogin, databaselogin, websitelogin, temperature, usagecpu, usageram, usagestorage, maxstorage, powersupply, ping, bandwidthWifi, bandwidthFilaire, MAJ) \
	VALUES (${userdatabase},${userwebsite},${physicallogin},${sshlogin},${vnclogin},${databaselogin},${websitelogin},${temperature},${usagecpu},${usageram},${usagestorage},${maxstorage},${powersupply},${ping},${bandwidthWifi},${bandwidthFilaire},${MAJ});`;
	//console.log(sql);
	connection.query(sql, (err, result) => { if (err) throw err; });
}


//serviceGetInfosFromMIB();
setInterval(function () {
	serviceGetInfosFromMIB();
}, 2000);