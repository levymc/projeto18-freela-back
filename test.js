import  { PrismaClient } from '@prisma/client';
import { faker } from '@faker-js/faker';
const prisma = new PrismaClient();

const categoriaIds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]; // IDs das categorias de 1 a 14

async function relateUsersToCategories() {
    const totalUsers = 30;
    
    for (let userId = 1; userId <= totalUsers; userId++) {
        const categoriaId = categoriaIds[(userId - 1) % categoriaIds.length]; // Distribui os IDs de categoria de forma circular
        
        await prisma.prestadores.create({
            data: {
                userId,
                categoriaId
            }
        });
    }
}

(async () => {
    await relateUsersToCategories();
    console.log(`Usuários relacionados com categorias.`);
    await prisma.$disconnect();
})();
