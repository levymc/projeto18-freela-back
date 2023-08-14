import  { PrismaClient } from '@prisma/client';
import { faker } from '@faker-js/faker';

const prisma = new PrismaClient();

async function generateRandomUser() {
    const nome = faker.person.fullName()
    const email = faker.internet.email()
    const password = "$2b$10$DxeIE8KUx9qoi7t39558AOgWg8jidZHUTZWbZ9kgr4g4vrBf2XFEW"
    const endereco = faker.location.streetAddress()
    const cep = "111111111111"
    const permission = 2
    const createdAt = new Date()
    const numEnd = 99999
    const bairro = "faker"
    const cidadeId = 1
    const estadoId = 1

    const newUser = {
        nome,
        email,
        password,
        endereco,
        cep,
        permission,
        createdAt,
        numEnd,
        bairro,
        cidadeId,
        estadoId
    };

    await prisma.users.create({
        data: newUser
    });
}

async function generateRandomUsers(count) {
    for (let i = 0; i < count; i++) {
        await generateRandomUser();
    }
}

const numberOfUsers = 10; // Número de usuários que você quer gerar

(async () => {
    await generateRandomUsers(numberOfUsers);
    console.log(`${numberOfUsers} usuários aleatórios foram inseridos.`);
    await prisma.$disconnect();
})();
