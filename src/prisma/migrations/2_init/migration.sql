-- CreateTable
CREATE TABLE "apiCEP" (
    "cep" SERIAL NOT NULL,
    "cidade" CHAR(1) NOT NULL,
    "uf" CHAR(1) NOT NULL,

    CONSTRAINT "apiCEP_pk" PRIMARY KEY ("cep")
);

-- CreateTable
CREATE TABLE "cidade" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(120),
    "uf" INTEGER,

    CONSTRAINT "cidade_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "estado" (
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(60),
    "uf" VARCHAR(2),
    "ddd" JSON,

    CONSTRAINT "estado_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "servicos" (
    "id" SERIAL NOT NULL,
    "nome" INTEGER NOT NULL,
    "descricao" CHAR(1) NOT NULL,
    "img" CHAR(1) NOT NULL,
    "preco" DOUBLE PRECISION NOT NULL,
    "userId" INTEGER NOT NULL,
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

-- CreateIndex
CREATE UNIQUE INDEX "public.sessions_token_key" ON "sessions"("token");

-- CreateIndex
CREATE UNIQUE INDEX "email" ON "users"("email");

-- AddForeignKey
ALTER TABLE "cidade" ADD CONSTRAINT "ufFk" FOREIGN KEY ("uf") REFERENCES "estado"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

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
ALTER TABLE "users" ADD CONSTRAINT "cidadeId FK" FOREIGN KEY ("cidadeId") REFERENCES "cidade"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "estadoId FK" FOREIGN KEY ("estadoId") REFERENCES "estado"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
