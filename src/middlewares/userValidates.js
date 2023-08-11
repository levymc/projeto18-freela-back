import UsuarioDAO from "../prisma/dao/dao.users.js";
import { crypt, compare } from "./crypt.js";
import LinkDAO from "../prisma/dao/dao.links.js";
import  { PrismaClient } from '@prisma/client';


const daoLink = new LinkDAO()
const dao = new UsuarioDAO()

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

export async function checkShortUrlUserID(req, res, next) {
    try {
        const userId = parseInt(res.user.id);
        const urlId = parseInt(req.params.id);
        console.log("USER: ", userId);
        const checkUserID = await daoLink.readByCreatedBy(userId);
        const readByUrlId = await daoLink.readById(urlId);

        if(!readByUrlId) return res.sendStatus(404)
        if (!checkUserID) return res.status(404).send("Este usuário não possui nenhuma ShortUrl.");
        const urlExistsForUser = checkUserID.some(urlObject => urlObject.id === urlId);
        if (!urlExistsForUser) return res.sendStatus(401)    
        next();
    } catch (err) {
        console.error("Erro checkShortUrlUserID: ", err);
        return res.status(500).send("Erro checkShortUrlUserID: ", err);
    }
}
  