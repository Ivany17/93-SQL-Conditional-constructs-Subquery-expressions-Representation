const axios = require('axios');
const querystring = require('querystring');
const config = require('../configs/api.json');

const {baseURL, get:{users:usersGET}} = config;

const http = axios.create({ baseURL });

module.exports.loadUsers = async (options = {}) => {
  const queryParams = {
    ...usersGET,
    ...options,
  }
  //console.log(querystring.stringify(queryParams));
  const {data:{results}} = await http.get(`?${querystring.stringify(queryParams)}`);
  //console.log(results);
  return results;
}