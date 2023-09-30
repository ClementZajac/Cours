import { useState } from 'react';
import { Button } from 'react-bootstrap';
import { useParams,useNavigate } from 'react-router-dom';

function Modifier() {

  const { id } = useParams();

  const [formData, setFormData] = useState({
    temperature: '',
    usagecpu: '',
    timestamp: '',
    ping: ''
  });


  const handleInputChange = (event) => {
    const { name, value } = event.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value
    }));
  };
  const navigate = useNavigate();
  const handleSubmit = (event) => {
    event.preventDefault();
    fetch(`http://localhost:5000/api/modifier/`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        id: id,
        temperature: formData.temperature,
        usagecpu: formData.usagecpu,
        timestamp: formData.timestamp,
        ping: formData.ping
      })
    })
    navigate('/senariosDeSimulation');
  };
  

  return (
    <div className='Modifier'>
      <h3>Modifier la ligne {id}:</h3>
      <form onSubmit={handleSubmit}>

        <label htmlFor="temp-field">Température:</label>
        <input
          type="text"
          id="temp-field"
          name="temperature"
          value={formData.temperature}
          onChange={handleInputChange}
        />

        <label htmlFor="usagecpu-field">Usage CPU:</label>
        <input
          type="text"
          id="usagecpu-field"
          name="usagecpu"
          value={formData.usagecpu}
          onChange={handleInputChange}
        />

        <label htmlFor="timestamp-field">Timestamp:</label>
        <input
          type="text"
          id="timestamp-field"
          name="timestamp"
          value={formData.timestamp}
          onChange={handleInputChange}
          pattern="\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}"
          title="Enter a date and time in the format YYYY-MM-DD hh:mm:ss"
        />


        <label htmlFor="ping-field">Ping:</label>
        <input
          type="text"
          id="ping-field"
          name="ping"
          value={formData.ping}
          onChange={handleInputChange}
        />
        <Button type="submit" className="btn-primary">Modifier</Button>
      </form>
      

    </div>
  );
}

export default Modifier;
