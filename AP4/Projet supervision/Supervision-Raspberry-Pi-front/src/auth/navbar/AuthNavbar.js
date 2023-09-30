import React from "react";
import Container from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';

const AuthNavbar = () => {
    return (
        <nav class="navbar navbar-expand-lg monbackground">
            <div class="container-fluid">
                <span className='navbar-brand' to="/">
                    <img src="../images/icon.png" alt="" width="30" height="30" class="d-inline-block align-text-top nav-icon"/>
                    <span>
                        Supervision Raspberry Pi
                    </span>
                </span>
            </div>
        </nav>
    );
}

export default AuthNavbar;