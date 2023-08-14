import  { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient()


export async function getCidade(req, res, next) {
    try {
        const cidade = await prisma.cidade.findUnique({
            where: {
                id: res.user.cidadeId
            }
        })
        res.cidade = cidade
        next()
    } catch (err) {
        res.status(500).send(err.message)
    }
}

export async function getEstado(req, res, next) {
    try {
        const estado = await prisma.estado.findUnique({
            where: {
                id: res.user.estadoId
            }
        })
        res.estado = estado
        next()
    } catch (err) {
        res.status(500).send(err.message)
    }
}