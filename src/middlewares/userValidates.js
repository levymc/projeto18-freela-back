import { crypt, compare } from "./crypt.js";
import  { PrismaClient } from '@prisma/client';


const prisma = new PrismaClient();



export async function validateUserPass(req, res, next){
    const email = req.body.email

    try{
        const dataRes = await prisma.users.findUnique({
            where: {
                email: email
            }
        }) // validação do email
        if (!dataRes || !compare(req.body.password, dataRes.password)) return res.status(401).send("Email ou Senha inválidos")
        res.userData = dataRes
        next()
    }catch (err) {
        console.error("Erro validateUserPass: ", err)
        return res.status(500).send("Erro Validação de Email e Senha: ",err)
    }
}
