const bcrypt = require("bcrypt");

const SALT_ROUNDS = 12;

async function passwordHash(password : string){
    return bcrypt.hash(password, SALT_ROUNDS)
}

passwordHash("test2009").then(
    (data : any)=> {
        console.log(data)
    }
)
module.exports = passwordHash;