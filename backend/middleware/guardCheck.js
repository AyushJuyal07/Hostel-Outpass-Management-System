const guardCheck = (req, res, next)=> {
    if(req.user.role != "guard")
        return res.sendStatus(401);
    else
        next();

}

module.exports = guardCheck;