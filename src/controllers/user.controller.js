import { crypt } from "../middlewares/crypt.js";
import { format, addDays } from 'date-fns';
import  { PrismaClient } from '@prisma/client';
import { userLogin } from "../schemas/user.schema.js";
import formatTimestamp from "../middlewares/formatTimeStamp.js";

const prisma = new PrismaClient()


export async function signUp(req, res){
    try{              
        const cidade = await prisma.cidade.findFirst({
            where: {
                nome: req.body.cidade
            }
        });
        
        const estado = await prisma.estado.findFirst({
            where: {
                uf: 'SP'
            }
        })
        if (!cidade || !estado) {
            return res.status(404).send("Cidade ou estado não encontrados ");
        }

        let data = {
            nome: req.body.nome,
            email: req.body.email,
            password: crypt(req.body.password),
            endereco: req.body.endereco,
            cep: req.body.cep,
            permission: 1,
            createdAt: new Date(),
            numEnd: parseInt(req.body.numEnd),
            bairro: req.body.bairro,
            cidadeId: parseInt(cidade.id),
            estadoId: parseInt(estado.id),
            permission: req.body.permission,
        }  
        console.log(data)
        let insertedUser = await prisma.users.create({data})
        let categoriaEncontrada = await prisma.categoriasServicos.findUnique({
            where: {
                id: parseInt(req.body.servico)
            }
        })
        let insertedPrestador = null
        if (req.body.servico != "") {
            insertedPrestador = await prisma.prestadorServico.create({
                    data:{
                        userId: insertedUser.id,
                        categoriaId: categoriaEncontrada.id
                    }
                })
            }

        console.log(`Cadastro do ${req.body.nome} realizado com sucesso !`)
        if (!insertedUser || !insertedPrestador) return res.status(404).send("Ocorreu algum erro no cadastro.")
        let response = insertedPrestador ? {insertedUser, insertedPrestador} : insertedUser
        res.status(201).send(response)
    }catch (err) {
        console.error("Erro signUp: ", err)
        return res.status(500).send("Erro no cadastro: ",err)
    }
}

export async function signIn(req, res){
    const data = {
        userId: res.userData.id,
        token: res.token,
        createdAt: new Date(),
        valid: true
    }
    console.log("DATA: ", data)
    try{
        const dataRes = await prisma.sessions.create({data})
        console.log(`Login do ${res.userData.nome} realizado com sucesso !`)
        res.send({token: res.token, userId: data.userId}).status(200)
    }catch (err) {
        console.error("Erro signUp: ", err)
        return res.status(500).send("Erro no cadastro: ",err)
    }
}


export const logOut = async (req, res) => {
    try{
        await prisma.sessions.update({
            where: {
                token: res.token
            },
            data: {
                valid: false
            }
        })
        return res.sendStatus(201)
    }catch (err) {
        console.error("Erro addView: ", err)
        return res.status(500).send("Erro no addView: ",err)
    }
}

export const getUser = async (req, res) => {
    try{
        const data = {
            userData: res.user,
            cidade: res.cidade,
            estado: res.estado
        }
        return res.status(200).send(data)
    }catch (err) {
        console.error("Erro addView: ", err)
        return res.status(500).send("Erro no addView: ",err)
    }
}

export const editPerfil = async (req, res) => {
    try{
        console.log(req.body)
        const updatedUser = await prisma.users.update({
            where: {
                id: req.body.id
            },
            data: {
                nome: req.body.nome,
                email: req.body.email,
                permission: req.body.permission,
                endereco: req.body.endereco,
                numEnd: req.body.numEnd,
                createdAt: new Date().toISOString()
            }
        })
        return res.status(204).send(updatedUser)
    }catch (err) {
        console.error("Erro addView: ", err)
        return res.status(500).send("Erro no addView: ",err)
    }
}


export const getPrestadores = async (req, res) => {

    try{
        const categoriaId = parseInt(req.headers.categoriaid)
        const prestadoresByCategoryId = await prisma.prestadorServico.findMany({ 
            where: {
                categoriaId: categoriaId
            }
        })
        let arrayPrestadores = []
        for (const prestador of prestadoresByCategoryId) {
            const i = prestadoresByCategoryId.indexOf(prestador)

            const userPrestador = await prisma.users.findUnique({
                where: {
                    id: prestador.userId
                }
            });
            console.log(userPrestador)
            arrayPrestadores.push({
                id: userPrestador.id, 
                email: userPrestador.email, 
                nome: userPrestador.nome,
                precoMin: prestadoresByCategoryId[i].precoMin,
                precoMax: prestadoresByCategoryId[i].precoMax
            })
        }
        return res.status(201).send(arrayPrestadores)
    }catch (err) {
        console.error("Erro addView: ", err)
        return res.status(500).send("Erro no addView: ",err)
    }
}