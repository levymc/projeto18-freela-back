import  { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

const categoriaIds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]; // IDs das categorias de 1 a 14

async function insertPrestadorServico() {
    const totalPrestadores = 31;
    
    for (let prestadorId = 1; prestadorId <= totalPrestadores; prestadorId++) {
        const categoriaId = categoriaIds[(prestadorId - 1) % categoriaIds.length]; // Distribui os IDs de categoria de forma circular
        const precoMin = Math.floor(Math.random() * 480) + 20; // Entre 20 e 500
        const precoMax = Math.floor(Math.random() * (500 - precoMin + 1)) + precoMin; // Entre precoMin e 500
        
        await prisma.prestadorServico.create({
            data: {
                userId: prestadorId,
                categoriaId,
                precoMin,
                precoMax
            }
        });
    }
}

(async () => {
    await insertPrestadorServico();
    console.log(`Relacionamentos de prestador de serviço inseridos.`);
    await prisma.$disconnect();
})();
