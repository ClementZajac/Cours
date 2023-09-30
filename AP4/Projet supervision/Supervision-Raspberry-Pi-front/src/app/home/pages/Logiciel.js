import { createRef, Component } from 'react';
import { Link } from "react-router-dom";
document.body.style.height = "100%";
document.body.style.margin = "0";
document.body.style.padding = "0";


export default class logiciel extends Component {
	state = {
		BDD : "oui",
		miseAJour : "non disponible",
		accesAuSite : 2,
		NombreSim : 42,
		logErr : 25
	};
	render() {
		return (
			<div className="">
				<div>
					<div className="topResumeElementTitle">
						<h2>Logiciel</h2>
					</div>
					<div className="topResumeElementLink">
						<Link className='btn btn-link' to="/logiciel">Détails</Link>
					</div>
				</div>
				<div className="clear"></div>

				<div className="grilleLightSec">
					<h5 className='MAJ'>
						Acces à la BDD
					</h5>
					<div className='Valeur'>{this.state.BDD}</div>
				</div>
				<div className="grilleLightSec">
					<h5 className='MAJ'>
						Logs d'erreurs
					</h5>
					<div className='Valeur'>{this.state.logErr}</div>
				</div>
				<div className="clear"></div>
				<div className="grilleLightSec">
					<h5 className="MAJ">
						Acces au site
						
					</h5>
					<div className='Valeur'>{this.state.accesAuSite}</div>
				</div>
				<div className="grilleLightSec">
					<h5 className="MAJ">
						Nombre de simulation
						
					</h5>
					<div className='Valeur'>{this.state.NombreSim}</div>
				</div>
				<h5 className='MAJ'>
					Mise à jour
				</h5>
				<div className='Valeur'>{this.state.miseAJour}</div>
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
		 fetch(`http://localhost:5000/api/site`)
		 .then(response => response.json())
		 .then(response => this.setState({accesAuSite: response}));
		// fetch(`http://localhost:5000/api/maj`)
		 //.then(response => response.json())
		 //.then(response => this.setState({accesAuSite: response}));
	  }
}
