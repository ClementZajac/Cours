import { createRef, Component } from 'react';
import { Link } from "react-router-dom";


export default class SecuriteDetail extends Component {
	state = {
		BDDConnectionNumber: 1,
		BDDUserConnected: 'test',
		SiteConnectionNumber: 1,
		SiteUserConnected: 'test',
		MiseAJour: 'non',
		Physique: 'non',
		SSH: 'non',
		VNC : 'non'
	  };

	render() {
		return (
			<div className="">
				<div>
					<div className="topResumeElementTitle">
						<h2>Securite</h2>
					</div>
					<div className="topResumeElementLink">
						<button className="btn btn-link">Détails</button>
					</div>
				</div>
				<div className="clear"></div>

				<div className="grilleLightSec">
					<h5 className='MAJ'>
						Mise à jour de l'OS
					</h5>
					<div className='valeur mx-auto text-center'>Mise à jour nécessaire :  {this.state.MiseAJour}</div>
				</div>
				<div className="grilleLightSec">
					<h5 className='MAJ'>
						Connexion à la machine
					</h5>
					<div className='valeur mx-auto text-center'>PHYSIQUE :  {this.state.Physique}</div>
					<div className='valeur mx-auto text-center'>SSH :  {this.state.SSH}</div>
					<div className='valeur mx-auto text-center'>VNC :  {this.state.VNC}</div>
				</div>
				<div className="clear"></div>
				<div className="grilleLightSec">
					<h5 className="MAJ">
						Connexion au site
						
					</h5>
					<div className='valeur mx-auto text-center'>Nombre de connexion au site :  {this.state.SiteConnectionNumber}</div>
					<div className='valeur mx-auto text-center'>Voici les utilisateurs connectés :  {this.state.SiteUserConnected}</div>
				</div>
				<div className="grilleLightSec">
					<h5 className="MAJ">
						Connexion BDD
						
					</h5>
					<div className='valeur mx-auto text-center'>Nombre de personne connectés à la BDD :  {this.state.BDDConnectionNumber}</div>
					<div className='valeur mx-auto text-center'>Voici les utilisateurs connectés à la BDD :  {this.state.BDDUserConnected}</div>
				</div>
			</div>
            
		);
	}
}
