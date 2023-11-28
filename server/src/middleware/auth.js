const jwt = require('jsonwebtoken');

const config = process.env;

const verifyToken = (req, res, next) => {
    const authHeader = req.headers.authorization;
    
    if (!authHeader)
        return res.sendStatus(403);
    
    const parts = authHeader.split(' ');
    
    if (parts.length !== 2)
        return res.sendStatus(401);

    const [ scheme, token ] = parts;

    if (!/^Bearer$/i.test(scheme))
        return res.sendStatus(401);

    jwt.verify(token, config.TOKEN_KEY, (error, decoded) =>
        {
            if (error) 
                return res.sendStatus(401);  
            
            req.authId = decoded.params.id;  
            
            return next();
        }
    );
};

module.exports = verifyToken;