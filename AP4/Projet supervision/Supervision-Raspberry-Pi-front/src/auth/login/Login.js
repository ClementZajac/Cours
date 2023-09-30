import React from "react";
import { Button, Col, Container, Form, FormGroup, FormLabel, Row } from "react-bootstrap";
import { useNavigate } from "react-router-dom";

const Login = () => {

    const loginAPI = `http://localhost:5000/api/auth`;
    const navigate = useNavigate();


    const submitLoginForm = (event) => {
        event.preventDefault();
        const formElement = document.querySelector('#loginForm');
        const formData = new FormData(formElement);
        const formDataJSON = Object.fromEntries(formData);
        const btnPointer = document.querySelector('#login-btn');
        btnPointer.innerHTML = 'Connexion en cours...';
        btnPointer.setAttribute('disabled', true);

        fetch(loginAPI, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formDataJSON)
        })
        .then(response => response.json())
        .then(data => {
            btnPointer.innerHTML = 'Connexion';
            btnPointer.removeAttribute('disabled');
            const token = data.token;
            if (!token) {
                alert('Impossible de se connecter. Veuillez vérifier vos identifiants.');
                return;
            }
            localStorage.clear();
            localStorage.setItem('user-token', token);
            setTimeout(() => {
                navigate('/');
            }, 500);
        })
        .catch(error => {
            btnPointer.innerHTML = 'Connexion';
            btnPointer.removeAttribute('disabled');
            alert("Oops! Une erreur est survenue.");
        });
    }

    return (
        <React.Fragment>
            <Container className="my-5 d-flex justify-content-center">
                <Row>
                    <Col md={{span: 40}}>
                        <Form id="loginForm" onSubmit={submitLoginForm}>
                            <FormGroup className="mb-3">
                                <FormLabel htmlFor={'login-username'}>Nom d'utilisateur:</FormLabel>
                                <input type={'text'} className="form-control" id={'login-username'} name="username" required />
                            </FormGroup>
                            <FormGroup className="mb-3">
                                <FormLabel htmlFor={'login-password'}>Mot de passe:</FormLabel>
                                <input type={'password'} className="form-control" id={'login-password'} name="password" required />
                            </FormGroup>
                            <Button type="submit" className="btn-success mt-2" id="login-btn">Connexion</Button>
                        </Form>
                    </Col>
                </Row>
            </Container>
        </React.Fragment>
    );
}

export default Login;