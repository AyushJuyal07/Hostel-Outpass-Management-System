const wardenCheck = (req, res, next)=> {
    if(req.user.role != "warden")
        return res.sendStatus(401);
    else
        next();

}

module.exports = wardenCheck;