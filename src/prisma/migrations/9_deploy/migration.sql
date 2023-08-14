-- CreateTable
CREATE TABLE "apiCEP" (
    "cep" SERIAL NOT NULL,
    "cidade" CHAR(1) NOT NULL,
    "uf" CHAR(1) NOT NULL,

    CONSTRAINT "apiCEP_pk" PRIMARY KEY ("cep")
);

-- CreateTable
CREATE TABLE "cidade" (
    "id" BIGSERIAL NOT NULL,
    "nome" VARCHAR(120),
    "uf" INTEGER,

    CONSTRAINT "cidade_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "estado" (
    "id" BIGSERIAL NOT NULL,
    "nome" VARCHAR(60),
    "uf" VARCHAR(2),
    "ibge" INTEGER,
    "pais" INTEGER,
    "ddd" JSON,

    CONSTRAINT "estado_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "servicos" (
    "id" SERIAL NOT NULL,
    "descricao" VARCHAR NOT NULL,
    "img" VARCHAR,
    "preco" DOUBLE PRECISION,
    "userId" INTEGER,
    "categoriaId" INTEGER NOT NULL,
    "available" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "servicos_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sessions" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "token" VARCHAR NOT NULL,
    "createdAt" TIMESTAMP(6) NOT NULL,
    "valid" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "sessions_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "statusServico" (
    "id" SERIAL NOT NULL,
    "servicoId" INTEGER NOT NULL,
    "clienteId" INTEGER NOT NULL,
    "prestadorId" INTEGER NOT NULL,
    "status" CHAR(1) NOT NULL,
    "contractedAt" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "statusServico_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR NOT NULL,
    "email" VARCHAR NOT NULL,
    "password" VARCHAR NOT NULL,
    "endereco" VARCHAR NOT NULL,
    "cep" DECIMAL NOT NULL,
    "permission" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(6) NOT NULL,
    "numEnd" INTEGER NOT NULL,
    "bairro" VARCHAR,
    "cidadeId" INTEGER NOT NULL,
    "estadoId" INTEGER NOT NULL,

    CONSTRAINT "users_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categoriasServicos" (
    "id" SERIAL NOT NULL,
    "descricao" VARCHAR NOT NULL,
    "icon" VARCHAR NOT NULL,

    CONSTRAINT "categorias_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "prestadorServico" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "categoriaId" INTEGER NOT NULL,
    "precoMin" INTEGER,
    "precoMax" INTEGER,

    CONSTRAINT "prestadores_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "servicoSolicitado" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "categoriaId" INTEGER NOT NULL,
    "solicitanteId" INTEGER NOT NULL,
    "prestadorId" INTEGER NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "servicoSolicitado_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "public.sessions_token_key" ON "sessions"("token");

-- CreateIndex
CREATE UNIQUE INDEX "email" ON "users"("email");

-- AddForeignKey
ALTER TABLE "servicos" ADD CONSTRAINT "servicos_fk0" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "servicos" ADD CONSTRAINT "servicos_fk1" FOREIGN KEY ("categoriaId") REFERENCES "categoriasServicos"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "sessions" ADD CONSTRAINT "userFk" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "statusServico" ADD CONSTRAINT "statusServico_fk0" FOREIGN KEY ("servicoId") REFERENCES "servicos"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "statusServico" ADD CONSTRAINT "statusServico_fk1" FOREIGN KEY ("clienteId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "statusServico" ADD CONSTRAINT "statusServico_fk2" FOREIGN KEY ("prestadorId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "prestadorServico" ADD CONSTRAINT "categoriaFk" FOREIGN KEY ("categoriaId") REFERENCES "categoriasServicos"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "prestadorServico" ADD CONSTRAINT "userFK" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

