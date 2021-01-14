import React from 'react';
import axios from 'axios';
import './deviceList.css';

export default class DeviceList extends React.Component {
  state = {
    devices: []
  }

  formatTime(val) {

    if (val != null) {
      let ts = new Date(val);
      val = ts.getFullYear() + "-" + 
            (ts.getMonth() +1).toString().padStart(2, '0') + "-" + 
            ts.getDate().toString().padStart(2, '0') + " " + 
            ts.getHours().toString().padStart(2, '0') + ":" + 
            ts.getMinutes().toString().padStart(2, '0') + ":" + 
            ts.getSeconds().toString().padStart(2, '0');
    }
    return(val);

  }

  componentDidMount() {
    setInterval(() => {
      axios.get(process.env.REACT_APP_HEARTBEAT_SERVER + `/stats/devices`) 
        .then(res => {
          const devices = res.data;
          this.setState({ devices });
        })
    }, 1000)
  }

  render() {
    return (
      <div class="wrap-table">
        <table>
          <thead>
            <tr class="table100-head">
              <th>Device</th>
              <th>Last Seen</th>
            </tr>
          </thead>
          <tbody>
            {this.state.devices.map((device, index) => {
              return(
                <tr>
                  <td>{device.description}</td>
                  <td>{this.formatTime(device.last_seen)}</td>
                </tr>
              )
            })}
          </tbody>
        </table>
      </div>
    );
  }

  
}