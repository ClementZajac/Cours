import React, { Component } from 'react';
import moment from 'moment';
import { FaTrashAlt, FaEdit } from 'react-icons/fa';
import { useNavigate, Link } from "react-router-dom";
//const navigate = useNavigate();

class TableSimulation extends Component {
  state = {
    data: []
  };

  

  componentDidMount() {
    fetch('http://localhost:5000/api/id')
      .then(response => response.json())
      .then(data => this.setState({ data }))
      .catch(error => console.error(error));
  }
  
  renderTableData() {
    if(this.state.data === 0){
      return (<tr><td colSpan="6" className="text-center">Aucune donnée</td></tr>);
    }else{
      return this.state.data.map((row, index) => {
        const { id, timestamp, temperature, usagecpu, ping } = row;
        const formattedDate = moment(timestamp).format("DD/MM/YYYY HH:mm:ss");
        return (
          <tr key={id}>
            <td className="text-center">{id}</td>
            <td className="text-center">{formattedDate}</td>
            <td className="text-center">{temperature}</td>
            <td className="text-center">{usagecpu}</td>
            <td className="text-center">{ping}</td>
            <td className='action'>
              <Link className='text-center btn btn-outline-primary' to={`/senariosDeSimulation/modifier/${id}`}><FaEdit /> Editer</Link>
              <Link className='text-center btn btn-outline-danger' to={`/senariosDeSimulation/supprimer/${id}`}><FaTrashAlt /> Supprimer</Link>
            </td>
          </tr>
        );
      });
    }
  }

  render() {
    return (
      <div className="monTableau">
        <table className="table">
          <thead>
            <tr>
              <th className="text-center" scope="col">id</th>
              <th className="text-center" scope="col">timestamp</th>
              <th className="text-center" scope="col">temperature</th>
              <th className="text-center" scope="col">usagecpu</th>
              <th className="text-center" scope="col">ping</th>
              <th className = "action" scope="col">Actions</th>
            </tr>
          </thead>
          <tbody>{this.renderTableData()}</tbody>
        </table>
      </div>
    );
  }
}

export default TableSimulation;
