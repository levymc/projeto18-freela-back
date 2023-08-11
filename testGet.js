import axios from 'axios'
import UsuarioService from './src/prisma/orm/orm.users.js';

const orm = new UsuarioService()

try{
    const user = await orm.prisma.users.findUnique({
        where: {
          id: 1,
        },
    })
    console.log(user)
}catch(err){
    console.error(err)
}

// axios.get('http://localhost:5000/urls/open/uUV80_puirvm8Q2QV4WT0').then(res => {
//     console.log(res.data)
// }).catch(err => {
//     console.log(err.response)
// })

const token = 'eaadb706-304f-40e5-8388-b71888dbfafc';

// axios.get('http://localhost:5000/users/me', {
//   headers: {
//     'Authorization': `Bearer ${token}`
// }}).then(res => {
//   console.log(res.data);
// }).catch(err => {
//   console.log(err.response.data);
// });


