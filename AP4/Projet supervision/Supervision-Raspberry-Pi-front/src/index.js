import React from "react";
import { createRoot } from 'react-dom/client';
import { BrowserRouter, Routes, Route} from 'react-router-dom';

import Login from './auth/login/Login';
import Auth from './auth/Auth';
import ProtectedRoute from './util/ProtectedRoute';

import App from './app';
import Accueil from './app/home/Accueil';

import SecuriteDetail from './app/home/pages/details/SecuriteDetail';
import ReseauDetail from './app/home/pages/details/ReseauDetail';
import SystemeDetail from './app/home/pages/details/SystemeDetail';
import LogicielDetail from './app/home/pages/details/LogicielDetail';

import SenariosSimu from './app/home/simulation-CRUD/SenariosSimu';
import Ajouter from "./app/home/simulation-CRUD/Ajouter";
import Supprimer from "./app/home/simulation-CRUD/Supprimer";
import Modifier from "./app/home/simulation-CRUD/Modifier";


const root = createRoot(document.querySelector('.appContainer'));
root.render(
	<React.StrictMode>
		<BrowserRouter basename={'/'}>
			<Routes>
				<Route path='/auth' element={<Auth />}>
					<Route path='login' element={<Login />} />
				</Route>
				<Route path="/" element={<App />}>
					<Route path='' element={ <ProtectedRoute> <Accueil /> </ProtectedRoute>	} />
					<Route path='Securite' element={ <ProtectedRoute> <SecuriteDetail /> </ProtectedRoute> } />
					<Route path='Reseau' element={ <ProtectedRoute> <ReseauDetail /> </ProtectedRoute> } />
					<Route path='Systeme' element={ <ProtectedRoute> <SystemeDetail /> </ProtectedRoute> } />
					<Route path='Logiciel' element={ <ProtectedRoute> <LogicielDetail /> </ProtectedRoute> } />
					<Route path='senariosDeSimulation' element={ <ProtectedRoute> <SenariosSimu /> </ProtectedRoute> } />
						<Route path='senariosDeSimulation/ajouter' element={ <ProtectedRoute> <Ajouter /> </ProtectedRoute> } />
						<Route path='senariosDeSimulation/modifier/:id' element={ <ProtectedRoute> <Modifier /> </ProtectedRoute> } />
						<Route path='senariosDeSimulation/supprimer/:id' element={ <ProtectedRoute> <Supprimer /> </ProtectedRoute> } />
				</Route>
			</Routes>
		</BrowserRouter>
	</React.StrictMode>
);
