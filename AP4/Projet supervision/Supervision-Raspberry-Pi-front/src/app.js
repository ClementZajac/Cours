import PortalNavbar from "./app/navbar/PortalNavbar";
import { Outlet } from "react-router-dom";
import React, { useState, useEffect } from 'react';
import GlobalContext from './app/home/GlobalContext';

export default function App() {

	const [isLoggedIn, setIsLoggedIn] = useState(false);
  
  
  fetch("http://localhost:5000/api/getMode")
  .then(response => response.json())
  .then(response => localStorage.setItem('mode', response.mode))
  
  let mode = localStorage.getItem('mode');
  const [globalValue, setGlobalValue] = useState(mode);


  const checkUserToken = () => {
      const userToken = localStorage.getItem('user-token');
      if (!userToken || userToken === 'undefined') {
          setIsLoggedIn(false);
      }
      setIsLoggedIn(true);
  }

  useEffect(() => {
      checkUserToken();
  }, [isLoggedIn]);
	
	return (
      <GlobalContext.Provider value={{ globalValue, setGlobalValue }}>
        {isLoggedIn && <PortalNavbar/>}
        <Outlet />
        {/* {isLoggedIn && <PortalFooter />} */}
      </GlobalContext.Provider>
	);
}