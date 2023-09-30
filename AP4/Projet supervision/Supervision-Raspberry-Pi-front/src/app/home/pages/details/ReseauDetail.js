import { createRef, Component } from 'react';

export default class ReseauDetail extends Component {
  state = {
    Ping: '',
    ssh: '',
    vnc: '',
    Wifi: '',
    filaire: '',
  };

  render() {
    return (
      <div className="">
        <div>
          <div className="topResumeElementTitle">
            <h2 className="text-center">Reseau {'>'} Détails</h2>
          </div>
          <div className="topResumeElementLink">
            <button className="btn btn-link">Détails</button>
          </div>
        </div>
        <div className="clear"></div>

        <div className="grilleLightResDet">
          <h5 className='MAJ'>
            Accès à la Raspberry
          </h5>
          <div className='valeur mx-auto text-center'>PING :  {this.state.Ping}</div>
          <div className="mx-auto text-center">SSH :  {this.state.ssh}</div>
          <div className="mx-auto text-center">VNC:  {this.state.vnc}</div>
        </div>
        <div className="grilleLightResDet">
          <h5 className='MAJ'>
            Bande passante
          </h5>
          <div className='valeur mx-auto text-center'>Bande passante Wifi  :{this.state.Wifi} Mbps</div>
          <div className="mx-auto text-center">Bande passante Ethernet  :{this.state.filaire} Mbps</div>
        </div>
      </div>
    );
  }
  componentDidMount() {
		fetch(`http://localhost:5000/api/ping`)
		 .then(response => response.json())
		 .then(response => this.setState({Ping: response}));	
		fetch(`http://localhost:5000/api/ssh`)
		 .then(response => response.json())
		 .then(response => this.setState({ssh: response}));
    fetch(`http://localhost:5000/api/vnc`)
		 .then(response => response.json())
		 .then(response => this.setState({vnc: response}));
    fetch(`http://localhost:5000/api/bandwidthWifi`)
		 .then(response => response.json())
		 .then(response => this.setState({Wifi: response}));
    fetch(`http://localhost:5000/api/bandwidthFilaire`)
		 .then(response => response.json())
		 .then(response => this.setState({filaire: response}));
    }
}
