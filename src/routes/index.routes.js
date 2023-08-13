import { Router } from "express";
import validateSchema from "../middlewares/validateSchema.js";
import { userSchema, userLogin } from "../schemas/user.schema.js";
import { signUp, signIn, logOut, getPrestadores } from "../controllers/user.controller.js";
import {  validateUserPass } from "../middlewares/userValidates.js";
import generateToken from "../middlewares/generateToken.js";
import validateAuth from "../middlewares/validateAuth.js";
import { getCategorias, getServicesByCategoryId } from "../controllers/services.controller.js";

const router = Router();

router.post('/signup', (req, res, next) => validateSchema(req, res, next, userSchema), signUp)
router.post('/signin', (req, res, next) => validateSchema(req, res, next, userLogin), validateUserPass, generateToken, signIn)
router.post('/logout', validateAuth, logOut)

router.get('/categorias',  getCategorias)
router.get('/categoria/:id', validateAuth, getServicesByCategoryId)
router.get('/prestadores', getPrestadores)
// router.get('/users/me', validateAuth, userMe)


router.use((err, req, res, next) => {
    console.error(err);
    res.status(500).send('Erro interno no servidor');
})

export default router;