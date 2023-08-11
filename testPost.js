import axios from 'axios'
import UsuarioService from './src/prisma/orm/orm.users.js';
import  { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient()
// const url = 'http://localhost:5000/urls/shorten';
// const token = 'efca96e6-9f3a-4a08-998e-a3bc5023e8b2';

// axios.post(url, {
//   url: 'https://www.youtube.com/',
// }, { headers: {
//     'Authorization': `Bearer ${token}`
//   }
// }).then(res => {
//   console.log(res.data);
// }).catch(err => {
//   console.log(err.response.data);
// });


axios.post('http://localhost:5000/signup', {
    nome: 'Novo Usuário',
    email: 'novousuario@example.com',
    password: 'senha123',
    confirmPassword: 'senha123',
    endereco: 'Rua Exemplo',
    numEnd: 123,
    cep: '14021160',
    permission: 1,
    createdAt: new Date(),
}).then(res => {
    console.log(res.data)
}).catch(err => {
    console.error(err.response)
})

const usuarioService = new UsuarioService();
// try {
//     const novoUsuario = await usuarioService.createUser({
//         nome: 'Novo Usuário',
//         email: 'novousuario@example.com',
//         password: 'senha123',
//         confirmPassword: 'senha123',
//         endereco: 'Rua Exemplo',
//         numEnd: 123,
//         cep: '14021160',
//         permission: 1,
//         createdAt: new Date(),
//     });
// }catch(err){
//     console.error(err)
// }