import { createRef, Component } from 'react';
import LineChart from '../LineChart';
import HorizontalBarChart from '../HorizontalBarChart';
export default class SystemeDetail extends Component {

	render() {
		return (
			<div className="" style={{marginTop: 10, marginLeft: 10 }}>
				<div>
					<div className="topResumeElementTitle">
						<h2>Système {'>'} Détails</h2>
					</div>
					<div className="topResumeElementLink">
						<button className="btn btn-link">Détails</button>
					</div>
				</div>
				<div className="clear"></div>

	

				<div className='globalGrilleSystemDetail'>
					{/* <div className="grilleFullWeightSystemDetail">
						<div>
							<span>Alimentation: </span>
						</div>
					</div> */}
					<div className="clear"></div>
					<div className="grilleLightSystemDetail">
						<LineChart apiUrn={"temperature"} myLabel={"Temperature en °C"} myBorderColor={"rgb(255, 99, 132)"} myBackgroundColor={"rgba(255, 99, 132, 0.5)"} />
					</div>
					<div className="grilleLightSystemDetail">
						<LineChart apiUrn={"usagecpu"} myLabel={"Charge CPU en %"} myBorderColor={"rgb(255, 99, 132)"} myBackgroundColor={"rgba(255, 99, 132, 0.5)"}/>
					</div>
					<div className="clear"></div>

					<div className="grilleLightSystemDetail">
						<HorizontalBarChart />
					</div>
					<div className="grilleLightSystemDetail">
						<LineChart apiUrn={"usageram"} myLabel={"Charge RAM en %"} myBorderColor={"rgb(255, 99, 132)"} myBackgroundColor={"rgba(255, 99, 132, 0.5)"}/>
					</div>
				
				</div>
			</div>
		);
	}
}
