import Joi from 'joi'

export const userSchema = Joi.object({
    nome: Joi.string().trim().required(),
    email: Joi.string().trim().email({ minDomainSegments: 2, tlds: { allow: ['com', 'br'] } }).required(),
    password: Joi.string().trim().required(),
    confirmPassword: Joi.string().trim().required().valid(Joi.ref('password')),
    cep: Joi.string().trim().required(),
    numEnd: Joi.string(),
    endereco: Joi.string().required(),
    permission: Joi.number().default(1),
    createdAt: Joi.date(),
    bairro: Joi.string().required(),
    cidade: Joi.string().required(),
    estado: Joi.string().required(),
    permission: Joi.number().required(),
    servico: Joi.string()
});
  
export const userLogin = Joi.object({
    email: Joi.string().trim().email({ minDomainSegments: 2, tlds: { allow: ['com', 'br'] } }).required(),
    password: Joi.string().trim().required(),
});
  
export const urlSchema = Joi.object({
    url: Joi.string().trim().uri().required()
});

