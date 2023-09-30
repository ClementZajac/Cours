import React from 'react';
import { Container } from 'react-bootstrap';

import Logiciel from './pages/Logiciel';
import Reseau from './pages/Reseau';
import Securite from './pages/Securite';
import Systeme from './pages/Systeme';

const Accueil = () => {
	return (
	
	<div className="global">
				
		<div className="grille">
			<div className="sousGrille">
				<Securite />
			</div>
		</div>
		<div className="grille">
			<div className="sousGrille">
				<Logiciel />
			</div>
		</div>
		<div className="grille">
			<div className="sousGrille">
				<Systeme />
			</div>
		</div>
		<div className="grille">
			<div className="sousGrille">
				<Reseau />
			</div>
		</div>
		
	</div>
	
	);
};

export default Accueil;
