import React, { useContext, useEffect, useState} from 'react';
import { Button } from "react-bootstrap";
import { useNavigate, Link } from "react-router-dom";

import GlobalContext from '../home/GlobalContext';

function PortalNavbar(param){

    const { globalValue } = useContext(GlobalContext);

    useEffect(() => {
    }, [globalValue]);


    //const globalValue = 'Production';

    const navigate = useNavigate();

    const logout = () => {
        localStorage.clear();
        navigate('/auth/login');
    }

    return (
        <nav class="navbar navbar-expand-lg monbackground">
        <div class="container-fluid">

            <Link className='navbar-brand' to="/">
                <img src="../images/icon.png" alt="" width="30" height="30" class="d-inline-block align-text-top nav-icon"/>
                <span>
                    Supervision Raspberry Pi
                </span>
            </Link>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            </button>
            <div class="collapse"> | </div>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                    <Link className='nav-link' to="/">Accueil</Link>
                    </li>
                    <li class="nav-item">
                    <Link className='nav-link' to="/logiciel">Logiciel</Link>
                    </li>
                    <li class="nav-item">
                    <Link className='nav-link' to="/reseau">Reseau</Link>
                    </li>
                    <li class="nav-item">
                    <Link className='nav-link' to="/securite">Securite</Link>
                    </li>
                    <li class="nav-item">
                    <Link className='nav-link' to="/systeme">Systeme</Link>
                    </li>
                </ul>
                <form class="d-flex" role="search">
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item">
                                <Link className='nav-link' to="/senariosDeSimulation">Scénarios de simulation</Link>
                            </li>
                            <li class="navbar-text">
                                <span>Mode : {globalValue}</span>
                            </li>
                        </ul>
                    </div>
                    <Button className="btn-warning" onClick={logout}>Déconnexion</Button>
                </form>
            </div>
        </div>
    </nav>
    );
}
export default PortalNavbar;