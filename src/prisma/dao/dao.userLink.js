import conectDB from "../database.connection.js";

class UserLink {
    constructor(userId, linkId, linksCount, visitCount) {
        this.userId = userId;
        this.linkId = linkId;
        this.linksCount = linksCount;
        this.visitCount = visitCount;
    }
}

export default class UserLinkDAO {
    constructor() {
        this.pool = null;
        this.userLinks = [];
    }
        
    async connect() {
        this.pool = await conectDB();
        console.log("Conexão realizada!!!");
    }
    
    async disconnect() {
        if (this.pool) {
            await this.pool.end();
            console.log("Conexão encerrada...");
        }
    }
    
    async create(userLinkData) {
        await this.connect();
        const newUserLink = new UserLink(
            userLinkData.userId,
            userLinkData.linkId,
            userLinkData.linksCount,
            userLinkData.visitCount
        );

        const queryString = 'INSERT INTO public.userLink ("userId", "linkId", "linksCount", "visitCount") VALUES ($1, $2, $3, $4)';
        const values = [newUserLink.userId, newUserLink.linkId, newUserLink.linksCount, newUserLink.visitCount];
    
        try {
            await this.pool.query(queryString, values);
            console.log('Novo UserLink adicionado ao banco de dados.');
        } catch (error) {
            console.error('Erro ao adicionar novo UserLink ao banco de dados:', error.message);
        }
    
        this.userLinks.push(newUserLink);
        await this.disconnect();
        return newUserLink;
    }
    
    async read(limit = null, offset = null, order = null, desc = null) {
        await this.connect();

        let queryString = 'SELECT * FROM public.userLink ';
        if (order){
            queryString += 'ORDER BY ' + order;
            if( desc === 'true' ) queryString += ' DESC ';
        }
        queryString += 'LIMIT $1 OFFSET $2 ';
        console.log(queryString);
        const values = [limit, offset];
    
        try {
            const response = await this.pool.query(queryString, values);
            console.log('Consulta realizada com sucesso.');
            await this.disconnect();
            return response.rows || [];
        } catch (error) {
            console.error('Erro ao consultar os UserLinks no banco de dados:', error.message);
            await this.disconnect();
            return [];
        }
    }

    async readById(id) {
        await this.connect();

        const queryString = `SELECT * FROM public.userLink WHERE "id" = $1`;
        const value = [id];
        try {
            const response = await this.pool.query(queryString, value);
            console.log('Consulta realizada com sucesso.');
            await this.disconnect();
            return response.rows[0] || null;
        } catch (error) {
            console.error('Erro ao consultar o UserLink no banco de dados:', error.message);
            await this.disconnect();
            return null;
        }
    }
    
    async update(id, userLinkData) {
        await this.connect();
    
        const userLinkToUpdate = this.userLinks.find(userLink => userLink.id === id);
        if (!userLinkToUpdate) {
            await this.disconnect();
            return null; // UserLink não encontrado, retorna null
        }
    
        userLinkToUpdate.userId = userLinkData.userId || userLinkToUpdate.userId;
        userLinkToUpdate.linkId = userLinkData.linkId || userLinkToUpdate.linkId;
        userLinkToUpdate.linksCount = userLinkData.linksCount || userLinkToUpdate.linksCount;
        userLinkToUpdate.visitCount = userLinkData.visitCount || userLinkToUpdate.visitCount;
    
        const queryString = 'UPDATE public.userLink SET "userId" = $1, "linkId" = $2, "linksCount" = $3, "visitCount" = $4 WHERE "id" = $5';
        const values = [userLinkToUpdate.userId, userLinkToUpdate.linkId, userLinkToUpdate.linksCount, userLinkToUpdate.visitCount, id];
    
        try {
            await this.pool.query(queryString, values);
            console.log('UserLink atualizado no banco de dados.');
        } catch (error) {
            console.error('Erro ao atualizar o UserLink no banco de dados:', error.message);
        }
    
        await this.disconnect();
        return userLinkToUpdate;
    }

    async delete(id) {
        await this.connect();
    
        const index = this.userLinks.findIndex(userLink => userLink.id === id);
        if (index === -1) {
            await this.disconnect();
            return null;
        }

        const queryString = 'DELETE FROM public.userLink WHERE "id" = $1';
        const values = [id];
    
        try {
            await this.pool.query(queryString, values);
            console.log('UserLink excluído do banco de dados.');
        } catch (error) {
            console.error('Erro ao excluir o UserLink do banco de dados:', error.message);
        }
    
        const userLinkExcluido = this.userLinks.splice(index, 1)[0];
    
        await this.disconnect();
        return userLinkExcluido;
    }
}
