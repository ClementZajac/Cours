import { createRef, Component } from 'react';


export default class LogicielDetail extends Component {

	state = {
		BDD : "oui",
		miseAJour : "non disponible",
		accesAuSite : "non disponible",
		NombreSim : "non disponible",
		logErr : 0
	};
	render() {
		return (
			<div className="">
				<div>
					<div className="topResumeElementTitle">
						<h2>Logiciel {'>'} Détails</h2>
					</div>
					<div className="topResumeElementLink">
						<button className="btn btn-link">Détails</button>
					</div>
				</div>
				<div className="clear"></div>

				<div className="grilleLightSec">
					<h5 className='MAJ'>
						Acces à la BDD
					</h5>
					<div className="mx-auto text-center">{this.state.BDD}</div>
				</div>
				<div className="grilleLightSec">
					<h5 className='MAJ'>
						Logs d'erreurs
					</h5>
					<div className="mx-auto text-center">{this.state.logErr}</div>
				</div>
				<div className="clear"></div>
				<div className="grilleLightSec">
					<h5 className="MAJ">
						Acces au site
						<div className='Valeur'>{this.state.accesAuSite}</div>
					</h5>
				</div>
				<div className="grilleLightSec">
					<h5 className="MAJ">
						Nombre de simulation
						<div className='Valeur'>{this.state.NombreSim}</div>
					</h5>
				</div>
				<h5 className='MAJ'>
					Mise à jour
					<div className='Valeur'>{this.state.miseAJour}</div>
				</h5>
			</div>
            
		);
	}
	componentDidMount() {
		fetch(`http://localhost:5000/api/accessbdd`)
		 .then(response => response.json())
		 .then(response => this.setState({BDD: response}));	
		fetch(`http://localhost:5000/api/log`)
		 .then(response => response.json())
		 .then(response => this.setState({logErr: response}));
		 /*fetch(`http://localhost:5000/api/site`)
		 .then(response => response.json())
		 .then(response => this.setState({accesAuSite: response}));*/
	  }
	
}
