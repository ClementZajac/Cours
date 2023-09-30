import React, { useContext,useState,useEffect} from 'react';
import GlobalContext from '../../../app/home/GlobalContext';
import { Button } from 'react-bootstrap';
import { Link } from "react-router-dom";


import TableSimulation from './TableSimulation';
function SenariosSimu() {
    const { globalValue, setGlobalValue } = useContext(GlobalContext);

    useEffect(() => {
    }, [globalValue]);


    const invMode = globalValue === 'Production' ? 'Simulé' : 'Production';

    function changeMode() {
      if (globalValue === 'Production') {
          fetch("http://localhost:5000/api/setMode", {method: 'POST',headers: {'Content-Type': 'application/json'},
              body: JSON.stringify({ mode: 'Simulé' })
          })
          setGlobalValue('Simulé');
        } else {
          fetch("http://localhost:5000/api/setMode", {method: 'POST',headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({ mode: 'Production' })
          })
          setGlobalValue('Production');
        }
    }
    function reset() {
      fetch(`http://localhost:5000/api/reset`);
    } 
    return (
      <div>
      <h2>Scénarios de simulation</h2>
      <div className='page'>
        <h3>Sur cette page vous aller pouvoir:</h3>
        <p>
          <ul>
            1. Changer le mode de fonctionnement de l'application : Production (données du Raspberry Pi) ou Simulé (données fictives que vous pouvez créer)
          </ul>
          <ul>
            2. Créer, modifier, mettre à jour et supprimer le scénario de simulation
          </ul>
        </p>
        <h3>Mode actuellement utilisé : {globalValue}</h3>
        <Button className="btn-primary" onClick={changeMode}>
          Passer en mode {invMode}
        </Button>
        <h3>Mes scénarios de simulation:</h3>
					<Link className='btn btn-success' to="/senariosDeSimulation/ajouter">Ajouter une ligne</Link>
        <h3>Reset du jeu de test :</h3>
        <Button className="btn-primary" onClick={reset}>
          Reset
        </Button>
        <h4>Données de simulation:</h4>
        <TableSimulation/>
		
      </div>
    </div>
    
    
    );
}
export default SenariosSimu;