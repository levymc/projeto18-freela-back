import conectDB from "../database.connection.js";

class LogAccess {
    constructor(userId, token, createdAt, valid) {
        this.userId = userId;
        this.token = token;
        this.createdAt = createdAt;
        this.valid = valid;
    }
}

export default class LogAccessDAO {
    constructor() {
        this.pool = null;
        this.logAccessList = [];
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
    
    async create(logAccessData) {
        await this.connect();
        const newLogAccess = new LogAccess(
            logAccessData.userId,
            logAccessData.token,
            logAccessData.createdAt,
            logAccessData.valid
        );

        const queryString = 'INSERT INTO public."logAccess" ("userId", token, "createdAt", valid) VALUES ($1, $2, $3, $4)';
        const values = [newLogAccess.userId, newLogAccess.token, newLogAccess.createdAt, newLogAccess.valid];
    
        try {
            await this.pool.query(queryString, values);
            console.log('Novo LogAccess adicionado ao banco de dados.');
        } catch (error) {
            console.error('Erro ao adicionar novo LogAccess ao banco de dados:', error.message);
        }
    
        this.logAccessList.push(newLogAccess);
        await this.disconnect();
        return newLogAccess;
    }

    async readByToken(token) {
        await this.connect();

        const queryString = 'SELECT * FROM public."logAccess" WHERE token = $1 and valid = true';
        const values = [token];

        try {
            const response = await this.pool.query(queryString, values);
            console.log('Consulta token realizada com sucesso.');
            await this.disconnect();
            return response.rows[0] || null;
        } catch (error) {
            console.error('Erro ao consultar o token no banco de dados:', error.message);
            await this.disconnect();
            return null;
        }
    }

    async desativaOutrosAccess(userId){
        await this.connect()

        const queryString = `update public."logAccess" set valid = false 
                            where id <> (select id from public."logAccess" order by id desc limit 1)
                            and "userId" = $1`
        try {
            await this.pool.query(queryString, [userId]);
            console.log('LogAccess updated do banco de dados.');
        } catch (error) {
            console.error('Erro ao att o LogAccess do banco de dados:', error.message);
            return false
        }
        await this.disconnect();
        return true
    }

    async delete(id) {
        await this.connect()
    
        const index = this.logAccessList.findIndex(logAccess => logAccess.id === id);
        if (index === -1) {
            await this.disconnect();
            return null;
        }

        const queryString = 'DELETE FROM public.logAccess WHERE "id" = $1';
        const values = [id];
    
        try {
            await this.pool.query(queryString, values);
            console.log('LogAccess excluído do banco de dados.');
        } catch (error) {
            console.error('Erro ao excluir o LogAccess do banco de dados:', error.message);
        }
    
        const logAccessExcluido = this.logAccessList.splice(index, 1)[0];
    
        await this.disconnect();
        return logAccessExcluido;
    }
}
