import React from 'react';
import axios from 'axios';
var tableify = require('tableify');
var parse = require('html-react-parser');

export default class PersonList extends React.Component {
  state = {
    devices: []
  }

  componentDidMount() {
    setInterval(() => {
      axios.get(`http://localhost:3000/test/dashboard`) 
        .then(res => {
          const devices = res.data;
          this.setState({ devices });
        })
    }, 1000)
  }

  render() {
    return (
      parse(tableify(this.state.devices))
    )
  }
}