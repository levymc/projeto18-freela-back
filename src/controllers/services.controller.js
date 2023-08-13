import { crypt } from "../middlewares/crypt.js";
import { format, addDays } from 'date-fns';
import  { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient()

export async function getCategorias(req, res){
    try{              
        const categorias = await prisma.categoriasServicos.findMany({})
        res.status(201).send(categorias)
    }catch (err) {
        console.error("Erro signUp: ", err)
        return res.status(500).send("Erro no cadastro: ",err)
    }
}

export async function getServicesByCategoryId(req, res){
    const categoryId = parseInt(req.params.id)
    try{
        const servicos = await prisma.servicos.findMany({
            where: {
                categoriaId: categoryId
            }
        })
        const categoria = await prisma.categoriasServicos.findUnique({
            where: {
                id: categoryId
            }
        })
        res.status(200).send({servicos, categoria})
    }catch (err) {
        console.error("Erro getServicesByCategoryId: ", err)
        return res.status(500).send("Erro no getServicesByCategoryId: ",err)
    }
}

export async function solicitarServico(req, res){
    try{
        const insertedService = await prisma.servicoSolicitado.create({
            data:{
                solicitanteId: parseInt(res.user.id),
                categoriaId: parseInt(req.body.categoriaId),
                prestadorId: parseInt(req.body.prestadorId)
            }
        })
        console.log(insertedService)
        res.status(201).send(insertedService)
    }catch (err) {
        console.error("Erro getServicesByCategoryId: ", err)
        return res.status(500).send("Erro no getServicesByCategoryId: ",err)
    }
}