import  { PrismaClient } from '@prisma/client';

export default class UsuarioService {
  constructor() {
    this.prisma = new PrismaClient();
  }

  async createUser(newUserData) {
    try {
      const newUser = await this.prisma.users.create({
        data: {
          nome: newUserData.nome.substring(0, 255),
          email: newUserData.email,
          password: newUserData.password,
          endereco: newUserData.endereco.substring(0, 255),
          cep: newUserData.cep,
          permission: newUserData.permission,
          createdAt: newUserData.createdAt,
        },
      });
      return newUser;
    } catch (error) {
      console.error('Erro ao adicionar usuário:', error);
      throw error;
    }
  }

  async listarUsuarios(limit = 10, orderBy = 'createdAt', desc = false) {
    try {
      const orderOption = orderBy ? { [orderBy]: desc ? 'desc' : 'asc' } : undefined;
      const usuarios = await this.prisma.usuario.findMany({
        take: limit,
        orderBy: orderOption,
      });
      return usuarios;
    } catch (error) {
      console.error('Erro ao listar usuários:', error);
      throw error;
    }
  }

  async atualizarUsuario(id, dadosAtualizados) {
    try {
      const usuarioAtualizado = await this.prisma.usuario.update({
        where: { id },
        data: dadosAtualizados,
      });
      return usuarioAtualizado;
    } catch (error) {
      console.error('Erro ao atualizar usuário:', error);
      throw error;
    }
  }

  async excluirUsuario(id) {
    try {
      const usuarioExcluido = await this.prisma.usuario.delete({
        where: { id },
      });
      return usuarioExcluido;
    } catch (error) {
      console.error('Erro ao excluir usuário:', error);
      throw error;
    }
  }

  async desconectar() {
    await this.prisma.$disconnect();
  }
}
