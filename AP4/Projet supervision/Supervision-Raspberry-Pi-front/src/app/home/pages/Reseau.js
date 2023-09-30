import { createRef, Component } from 'react';

export default class Reseau extends Component {
  state = {
    Ping: 'true',
    ssh: 'ok',
    vnc: 'ok',
    Wifi: 152,
    filaire: 192,
  };

  render() {
    return (
      <div className="">
        <div>
          <div className="topResumeElementTitle">
            <h2 className="text-center">Reseau</h2>
          </div>
          <div className="topResumeElementLink">
            <button className="btn btn-link">Détails</button>
          </div>
        </div>
        <div className="clear"></div>

        <div className="grilleLightRes">
          <h5 className='MAJ'>
            Accès à la Raspberry
          </h5>
          <div className='valeur mx-auto text-center'>PING :  {this.state.Ping}</div>
          <div className="mx-auto text-center">SSH :  {this.state.ssh}</div>
          <div className="mx-auto text-center">VNC:  {this.state.vnc}</div>
        </div>
        <div className="grilleLightRes">
          <h5 className='MAJ'>
            Bande passante
          </h5>
          <div className='valeur mx-auto text-center'>Bande passante Wifi  :{this.state.Wifi} Mbps</div>
          <div className="mx-auto text-center">Bande passante Ethernet  :{this.state.filaire} Mbps</div>
        </div>
      </div>
    );
  }
}
