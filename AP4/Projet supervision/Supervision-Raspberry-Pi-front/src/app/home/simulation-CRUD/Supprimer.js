import { useState } from 'react';
import { Button } from 'react-bootstrap';
import { useParams, useNavigate } from 'react-router-dom';



function Supprimer() {
    const { id } = useParams();
    // const [formData, setFormData] = useState({
    //   id: ''
    // });
  
    const navigate = useNavigate();
    const handleSubmit = (event) => {
      event.preventDefault();
      fetch("http://localhost:5000/api/supprimer", {method: 'POST',headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({ id: id })})
      navigate('/senariosDeSimulation');
    };
      

    return (
        <div className='monFormulaire'>
        <h3>Voulez-vous réelement supprimer la ligne {id}</h3>
        <form onSubmit={handleSubmit}>
        <Button type="submit" className="btn-primary" >oui</Button>
      </form>
      </div>
    );
  }
  export default Supprimer;