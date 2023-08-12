import UsuarioDAO from "../prisma/dao/dao.users.js";
import { crypt } from "../middlewares/crypt.js";
import { format, addDays } from 'date-fns';
import  { PrismaClient } from '@prisma/client';
import { userLogin } from "../schemas/user.schema.js";

const prisma = new PrismaClient()

const dao = new UsuarioDAO()

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

        const data = {
            nome: req.body.nome,
            email: req.body.email,
            password: crypt(req.body.password),
            endereco: req.body.endereco,
            cep: req.body.cep,
            permission: 1,
            createdAt: new Date(),
            numEnd: parseInt(req.body.numEnd),
            bairro: req.body.bairro,
            cidadeId: cidade.id,
            estadoId: estado.id,
        }  
        const dataRes = await prisma.users.create({data})

        console.log(`Cadastro do ${req.body.nome} realizado com sucesso !`)
        if (!dataRes) return res.status(404).send("Ocorreu algum erro no cadastro.")
        res.status(201).send(dataRes)
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
        // await daoLog.desativaOutrosAccess(res.userData.id) // desativando outros tokens
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

