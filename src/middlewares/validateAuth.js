import  { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient()


async function validateAuth(req, res, next) {
    const { authorization } = req.headers
    if (!authorization?.startsWith("Bearer ")) return res.sendStatus(422);
    const token = authorization?.replace("Bearer ", "")
    if (!token) return res.sendStatus(401)

    try {
        const session = await prisma.sessions.findUnique({
            where: {
                token: token
            }
        })
        if (!session) return res.sendStatus(401);

        const user = await prisma.users.findUnique({
            where: {
                id: session.userId
            }
        })
        if (!user) return res.sendStatus(401);

        res.user = user
        res.token = token
        // console.log("Deu bom!")
        next();
        
    } catch (err) {
        res.status(500).send(err.message)
    }
}

export default validateAuth;